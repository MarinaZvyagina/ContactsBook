//
//  CBANetworkDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBANetworkDataBase.h"
#import "CBAJsonDataBase.h"
#import "CBAContactList.h"
#import "CBAContact.h"
#import "ViewController.h"

@implementation CBANetworkDataBase


-(void)getContacts: (id<CBAViewManager>) viewManager {
    NSArray * fields = @[
                         @"first_name",
                         @"last_name",
                         @"home_phone",
                         @"nickname",
                         @"photo_100"
                         ];
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSString*url = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100&%@",userID,accessToken];
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:nsurlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    CBAContactList * contacts = [[CBAJsonDataBase new] getContacts:data forFields:fields];
                    [viewManager updateContacts:contacts];
                    [viewManager reloadTable];
                }];

    [downloadTask resume];
}

@end
