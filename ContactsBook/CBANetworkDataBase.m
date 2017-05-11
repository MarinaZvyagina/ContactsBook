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

@implementation CBANetworkDataBase


-(CBAContactList *)getContacts:(UITableView *) tableView {
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString*url=[@"https://api.vk.com/method/friends.get?user_id=14229717&fields=nickname,contacts,photo_100&" stringByAppendingString:accessToken];
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    __block NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];


    [[session dataTaskWithRequest:nsurlRequest
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {

                        responseData = data;

                    
                    
                }] resume];

    NSArray * fields = @[
                         @"first_name",
                         @"last_name",
                         @"home_phone",
                         @"nickname",
                         @"photo_100"
                         ]; 
    
    return [[CBAJsonDataBase new] getContacts:responseData forFields:fields];
}

@end
