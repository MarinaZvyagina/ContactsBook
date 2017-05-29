//
//  CBAFaceBookViewController.m
//  ContactsBook
//
//  Created by Марина Звягина on 09.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAFaceBookViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface CBAFaceBookViewController () <FBSDKLoginButtonDelegate>
@property (strong, nonatomic) FBSDKLoginButton *loginButton;
@property (nonatomic, strong) id<CBAViewManager> viewManager;
@end

@implementation CBAFaceBookViewController

-(instancetype) initWithViewManager: (id<CBAViewManager>) viewManager {
    self = [super init];
    if (self) {
        _viewManager = viewManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.readPermissions = @[@"user_relationships", @"read_custom_friendlists", @"user_friends"];
    _loginButton.center = self.view.center;
    [self.view addSubview:_loginButton];
    _loginButton.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {

    [self.viewManager reloadView];
    [self.viewManager goToRootViewController];
}

/**
 Sent to the delegate when the button was used to logout.
 - Parameter loginButton: The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    NSLog(@"loginButtonDidLogOut");
}


@end
