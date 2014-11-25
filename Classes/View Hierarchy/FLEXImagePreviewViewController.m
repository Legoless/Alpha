//
//  FLEXImagePreviewViewController.m
//  Flipboard
//
//  Created by Ryan Olson on 6/12/14.
//  Copyright (c) 2014 Flipboard. All rights reserved.
//

#import "FLEXImagePreviewViewController.h"
#import "FLEXUtility.h"

@interface FLEXImagePreviewViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation FLEXImagePreviewViewController

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Preview";
        self.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [FLEXUtility scrollViewGrayColor];
    
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    self.imageView.layer.borderWidth = 1.0;
    self.imageView.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = self.view.backgroundColor;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.minimumZoomScale = fmin(self.scrollView.frame.size.width / self.imageView.frame.size.width, self.scrollView.frame.size.height / self.imageView.frame.size.height) * 0.9;
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    [self.view addSubview:self.scrollView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyButtonPressed:)];
}

- (void)viewDidLayoutSubviews
{
    [self centerContentInScrollViewIfNeeded];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContentInScrollViewIfNeeded];
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
    
    NSLog(@"Insets: %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
}

- (void)copyButtonPressed:(id)sender
{
    [[UIPasteboard generalPasteboard] setImage:self.image];
}

@end
