//
//  ALPHAImageRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 10/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAActions.h"
#import "ALPHAScreenModel.h"

#import "ALPHAImageRendererViewController.h"

#import "ALPHAConverterManager.h"

@interface ALPHAImageRendererViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *refreshTimer;

@end

@implementation ALPHAImageRendererViewController

#pragma mark - Getters and Setters

- (void)setScreenModel:(ALPHAScreenModel *)screenModel
{
    _screenModel = screenModel;
    
    if ([screenModel.rightAction.request.identifier isEqualToString:ALPHAActionCloseIdentifier])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    }
    else if ([screenModel.rightAction.request.identifier isEqualToString:ALPHAActionCopyIdentifier])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyButtonPressed:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.title = screenModel.title;
    
    [self createRefreshTimerWithModel:screenModel];
    
    if (screenModel.request)
    {
        self.request = screenModel.request;
    }
}

- (void)setObject:(id<ALPHASerializableItem>)object
{
    _object = object;
    
    if ([object isKindOfClass:[ALPHAScreenModel class]])
    {
        self.screenModel = (ALPHAScreenModel *)object;
    }
    else
    {
        //
        // Use a data converter to get screen model
        //
        
        if ([[ALPHAConverterManager sharedManager] canConvertObject:object])
        {
            self.screenModel = [[ALPHAConverterManager sharedManager] screenModelForObject:object];
        }
    }
}

- (void)setImage:(UIImage *)image
{
    if (!self.imageView)
    {
        return;
    }
    
    self.imageView.image = image;
    [self.imageView sizeToFit];
    
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.minimumZoomScale = fmin(self.scrollView.frame.size.width / self.imageView.frame.size.width, self.scrollView.frame.size.height / self.imageView.frame.size.height) * 0.9;
    
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    
    [self centerContentInScrollViewIfNeeded];
}

#pragma mark - Initialization

- (instancetype)initWithObject:(id)object
{
    return [self init];
}

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        self.title = @"Preview";
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = self.theme.backgroundColor;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.layer.borderWidth = self.theme.imageViewBorderWidth;
    self.imageView.layer.borderColor = [self.theme.imageViewBorderColor CGColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = self.view.backgroundColor;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.scrollView addSubview:self.imageView];
    
    self.scrollView.maximumZoomScale = 2.0;
    [self.view addSubview:self.scrollView];
    
    if (self.object)
    {
        [self setImage:(UIImage *)self.object];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.object)
    {
        [self refresh];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

- (void)viewDidLayoutSubviews
{
    [self centerContentInScrollViewIfNeeded];
}

#pragma mark - ALPHADataRenderer


- (void)refresh
{
    [self.source dataForRequest:self.request completion:^(ALPHAModel *dataModel, NSError *error) {
        self.object = dataModel;
        
        //
        // TODO: Handle error and display it properly (this can happen with over network sources)
        //
    }];
}

#pragma mark - Actions

- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

- (void)copyButtonPressed:(id)sender
{
    if (self.object)
    {
        [[UIPasteboard generalPasteboard] setImage:(UIImage *)self.object];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContentInScrollViewIfNeeded];
}

#pragma mark - Private methods

- (void)createRefreshTimerWithModel:(ALPHAScreenModel *)screenModel
{
    if (screenModel.expiration > 0 && self.source)
    {
        self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:self.screenModel.expiration target:self selector:@selector(refresh) userInfo:nil repeats:NO];
    }
    else
    {
        [self.refreshTimer invalidate];
        self.refreshTimer = nil;
    }
}

- (void)centerContentInScrollViewIfNeeded
{
    CGFloat horizontalInset = 0.0;
    CGFloat verticalInset = 0.0;
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    
    if (self.scrollView.contentSize.width < self.scrollView.bounds.size.width)
    {
        horizontalInset = (self.scrollView.bounds.size.width - self.scrollView.contentSize.width) / 2.0;
        
        insets.left = horizontalInset;
        insets.right = horizontalInset;
    }
    if (self.scrollView.contentSize.height < self.scrollView.bounds.size.height)
    {
        verticalInset = (self.scrollView.bounds.size.height - self.scrollView.contentSize.height) / 2.0;
        
        insets.top = 44.0 + verticalInset;
        
        insets.bottom = verticalInset;
    }
    //self.scrollView.contentInset = UIEdgeInsetsMake(verticalInset, horizontalInset, verticalInset, horizontalInset);
    self.scrollView.contentInset = insets;
    
    //NSLog(@"Insets: %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
}

@end
