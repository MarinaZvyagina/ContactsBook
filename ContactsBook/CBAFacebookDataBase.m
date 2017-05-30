//
//  CBAFacebookDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 08.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAFacebookDataBase.h"
#import "CBAContactList.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "CBAJsonDataBase.h"
#import "CBAContact.h"
#import "ViewController.h"
#import "CBAViewManager.h"

@interface CBAFacebookDataBase()
@property (nonatomic, strong) id<CBAViewManager> viewManager;
@end

@implementation CBAFacebookDataBase


-(CBAContactList *)getContacts: (id<CBAViewManager>) viewManager {
    NSArray * fields = @[
                         @"first_name",
                         @"last_name",
                         @"",
                         @"id",
                         @"picture"
                         ];
    CBAContact* (^createContact)(NSString *, NSString *, NSString *, NSString *, NSString *);
    createContact = ^CBAContact*(NSString *name,
                                 NSString *surname,
                                 NSString *phone,
                                 NSString *email,
                                 NSString *url) {
        CBAContact *contact = [CBAContact new];
        contact.name = name;
        contact.surname = surname;
        contact.phone = phone;
        contact.email = email;
        contact.urlForPhoto = url;
        return contact;
    };
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc]
          initWithGraphPath:@"/me"
          parameters:@{ @"fields": @"id,name,taggable_friends{first_name,last_name,picture}",}
          HTTPMethod:@"GET"] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSDictionary * contacts = [[result objectForKey:@"taggable_friends"] objectForKey:@"data"];
                NSMutableArray *resultContacts = [NSMutableArray new];
                for (NSDictionary *contact in contacts) {
                    NSString *name = [contact objectForKey:fields[0]];
                    NSString *surname = [contact objectForKey:fields[1]];
                    NSString *phone = [contact objectForKey:fields[2]];
                    NSString *email = [contact objectForKey:fields[3]];
                    
                    NSDictionary *url1 = [contact objectForKey:fields[4]];
                    NSDictionary *url2 = [url1 objectForKey:@"data"];
                    NSString *url = [ url2 objectForKey:@"url"];
                    
                    [resultContacts addObject:createContact(name,surname,phone,email,url)];
                }
                [viewManager updateContacts:[[CBAContactList alloc] initWithArray:resultContacts]];
                [viewManager reloadTable];
            }
        }];
    }
    
    return [CBAContactList new];
    
}

@end
