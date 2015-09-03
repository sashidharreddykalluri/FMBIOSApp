//
//  FMBWebsiteViewController.m
//  FeedMyBelly
//
//  Created by Sashidhar on 8/21/15.
//  Copyright (c) 2015 Sashidhar. All rights reserved.
//

#import "FMBWebsiteViewController.h"

@interface FMBWebsiteViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *bottleRocket;

@end

@implementation FMBWebsiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadWebPage];
}

#pragma mark - Webpage methods.
- (void)loadWebPage
{
    NSString *urlString = @"http://www.bottlerocketstudios.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_bottleRocket loadRequest:urlRequest];
    UIBarButtonItem *_backBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(goBack)];
    UIBarButtonItem *_refreshBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"Refresh.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(refresh)];
    UIBarButtonItem *_forwardBtn=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"forward.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(goForward)];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:_backBtn, _refreshBtn, _forwardBtn, nil]];
}

// Actoin methods for bar buttons
- (void)refresh
{
    [_bottleRocket reload];
}

- (void)goBack
{
    [_bottleRocket goBack];
}

- (void)goForward
{
    [_bottleRocket goForward];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
