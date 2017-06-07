//
//  CBAPathFileJsonDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAPathFileJsonDataBase.h"
#import "CBAJsonDataBase.h"
#import "CBAContactList.h"
#import "ViewController.h"

@implementation CBAPathFileJsonDataBase

-(void)getContacts: (id<CBAViewManager>) viewManager {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    
    NSArray * fields = @[
                         @"name",
                         @"surname",
                         @"phone",
                         @"email",
                         @""
                         ];
    CBAContactList * contacts = [[CBAJsonDataBase new] getContacts:JSONData forFields:fields];
    [viewManager updateContacts:contacts];
    [viewManager reloadTable];
}

@end
