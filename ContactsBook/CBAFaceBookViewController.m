//
//  CBAFaceBookViewController.m
//  ContactsBook
//
//  Created by Марина Звягина on 09.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAFaceBookViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface CBAFaceBookViewController ()
@property (strong, nonatomic) FBSDKLoginButton *loginButton;
@end

@implementation CBAFaceBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.readPermissions = @[@"user_relationships", @"read_custom_friendlists", @"user_friends"];
    _loginButton.center = self.view.center;
    [self.view addSubview:_loginButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
