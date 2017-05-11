//
//  VKVMainViewController.m
//  VK videos
//
//  Created by 1 on 17.03.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "VKVMainViewController.h"
#import <WebKit/WebKit.h>
#import <Security/Security.h>
#import "ViewController.h"
#import "CBANetworkDataBase.h"


#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface VKVMainViewController ()<WKNavigationDelegate>
@property(nonatomic) BOOL authorised;
@property (strong,nonatomic) WKWebView *webView;

@end

@implementation VKVMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=Rgb2UIColor(80, 114, 153);
}

-(void)viewWillAppear:(BOOL)animated{
    _authorised=NO;
    
    if (_authorised==NO) {
        [self showSignInWebView];
    }
    else {
        [self moveToTVC];
    }
}

-(void)showSignInWebView{
    if(!_webView)
    {
        _webView=[[WKWebView alloc]initWithFrame: self.view.bounds];
        _webView.navigationDelegate=self;
        [self.view addSubview:_webView];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
    
    NSString*url=@"https://oauth.vk.com/authorize?client_id=5932466&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=video&response_type=token&v=5.63&state=123456";
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:nsurlRequest];
}


-(void) moveToTVC{
    
    id<CBADataBaseDriver>  contactManager = [CBANetworkDataBase new];
    ViewController *vc = [[ViewController alloc] initWithContactManager:contactManager];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
  //  self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //[self.navigationController setViewControllers:@[navigationController]];
    
 //   [self addChildViewController:navigationController];
 //   [self showViewController:navigationController sender:nil];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
   // [self addChildViewController:navigationController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma - WKNavigationDelegate

-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}


-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([_webView.URL.absoluteString rangeOfString:@"access_token"].location != NSNotFound)
    {
        NSRange tokenBegin=[_webView.URL.absoluteString rangeOfString:@"access_token="];
        NSString *accessToken0=[_webView.URL.absoluteString substringFromIndex:tokenBegin.location+tokenBegin.length];
        NSRange tokenEnd=[accessToken0 rangeOfString:@"&expires" ];
        NSString *accessToken1=[accessToken0 substringToIndex:tokenEnd.location];
        
        [self saveToken:accessToken1];
        [self moveToTVC];
        
    } else if ([_webView.URL.absoluteString rangeOfString:@"error"].location != NSNotFound) {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"something went wrong :(" message:@"Check your internet connection and try again!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        [self showSignInWebView];
        
    }
}

-(void)saveToken:(NSString*)accessToken{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"VKAccessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"VKAccessTokenDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _authorised=YES;
}








@end
