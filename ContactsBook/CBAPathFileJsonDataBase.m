//
//  CBAPathFileJsonDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAPathFileJsonDataBase.h"
#import "CBAJsonDataBase.h"
//#import "CBAContactList.h"

@implementation CBAPathFileJsonDataBase

-(CBAContactList *)getContacts:(UITableView *) tableView {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    
    NSArray * fields = @[
                         @"name",
                         @"surname",
                         @"phone",
                         @"email",
                         @""
                         ];
    
    return [[CBAJsonDataBase new] getContacts:JSONData forFields:fields];
}

@end
