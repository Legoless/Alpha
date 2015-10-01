//
//  ALPHAWebRendererViewController.m
//  Alpha
//
//  Created by Dal Rupnik on 11/06/15.
//  Copyright © 2015 Unified Sense. All rights reserved.
//

#import "ALPHAUtility.h"

#import "ALPHAScreenManager.h"

#import "ALPHAActions.h"

#import "NSString+Entities.h"

#import "ALPHAConverterManager.h"

#import "ALPHAWebRendererViewController.h"

@interface ALPHAWebRendererViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *refreshTimer;

@end

@implementation ALPHAWebRendererViewController

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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Copy" style:UIBarButtonItemStylePlain target:self action:@selector(copyButtonTapped:)];
    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    //
    // Refresh timer
    //
    
    [self createRefreshTimerWithModel:screenModel];
    
    self.title = screenModel.title;
    
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

- (void)applyObject:(id)object
{
    if (!self.webView)
    {
        return;
    }
    
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *htmlString = [NSString stringWithFormat:@"<pre>%@</pre>", [[object description] alpha_stringByEscapingHTMLEntities]];
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
    else if ([object isKindOfClass:[NSURL class]])
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:object];
        [self.webView loadRequest:request];
    }
}

#pragma mark - Initialization

- (instancetype)initWithObject:(id)object
{
    return [self init];
}

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self)
    {
        self.title = @"Preview";
    }
    
    return self;
}

- (void)dealloc
{
    // UIWebView's delegate is assigned so we need to clear it manually.
    
    if (self.webView.delegate == self)
    {
        self.webView.delegate = nil;
    }
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeLink;
    self.webView.scalesPageToFit = YES;
    
    [self.view addSubview:self.webView];
    self.webView.frame = self.view.bounds;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self applyObject:self.object];
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

    
#pragma mark - Actions
    
- (void)donePressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(viewControllerDidFinish:)])
    {
        [self.delegate viewControllerDidFinish:self];
    }
}

- (void)refresh
{
    [self.source dataForRequest:self.request completion:^(ALPHAModel *dataModel, NSError *error)
    {
        self.object = dataModel;
        
        //
        // TODO: Handle error and display it properly (this can happen with over network sources)
        //
    }];
}

- (void)copyButtonTapped:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:[self.object description]];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL shouldStart = NO;
    
    if (navigationType == UIWebViewNavigationTypeOther)
    {
        // Allow the initial load
        shouldStart = YES;
    }
    else
    {
        // For clicked links, push another web view controller onto the navigation stack so that hitting the back button works as expected.
        // Don't allow the current web view do handle the navigation.
        
        [[ALPHAScreenManager defaultManager] pushObject:[request URL]];
    }
    return shouldStart;
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

#pragma mark - Class Helpers

/*
+ (BOOL)supportsPathExtension:(NSString *)extension
{
    BOOL supported = NO;
    NSSet *supportedExtensions = [self webViewSupportedPathExtensions];
    if ([supportedExtensions containsObject:[extension lowercaseString]]) {
        supported = YES;
    }
    return supported;
}

+ (NSSet *)webViewSupportedPathExtensions
{
    static NSSet *pathExtenstions = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Note that this is not exhaustive, but all these extensions should work well in the web view.
        // See https://developer.apple.com/library/ios/documentation/AppleApplications/Reference/SafariWebContent/CreatingContentforSafarioniPhone/CreatingContentforSafarioniPhone.html#//apple_ref/doc/uid/TP40006482-SW7
        pathExtenstions = [NSSet setWithArray:@[@"jpg", @"jpeg", @"png", @"gif", @"pdf", @"svg", @"tiff", @"3gp", @"3gpp", @"3g2",
                                                @"3gp2", @"aiff", @"aif", @"aifc", @"cdda", @"amr", @"mp3", @"swa", @"mp4", @"mpeg",
                                                @"mpg", @"mp3", @"wav", @"bwf", @"m4a", @"m4b", @"m4p", @"mov", @"qt", @"mqv", @"m4v"]];
        
    });
    return pathExtenstions;
}
*/

@end
