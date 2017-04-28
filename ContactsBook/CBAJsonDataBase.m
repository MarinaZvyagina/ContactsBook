//
//  CBAJsonDataBase.m
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "CBAJsonDataBase.h"
#import "CBAContact.h"
#import "CBAContactList.h"

@implementation CBAJsonDataBase

-(CBAContactList *)getContacts {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"contacts" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary * JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    NSDictionary * contacts = [JSONObject objectForKey:@"contacts"];
    
    CBAContact* (^createContact)(NSString *, NSString *, NSString *, NSString *);
    createContact = ^CBAContact*(NSString *name,
                                NSString *surname,
                                NSString *phone,
                                NSString *email) {
        CBAContact *contact = [CBAContact new];
        contact.name = name;
        contact.surname = surname;
        contact.phone = phone;
        contact.email = email;
        return contact;
    };
    
    NSMutableArray *resultContacts = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (NSDictionary *contact in contacts) {
        NSString *name = [contact objectForKey:@"name"];
         NSString *surname = [contact objectForKey:@"surname"];
         NSString *phone = [contact objectForKey:@"phone"];
         NSString *email = [contact objectForKey:@"email"];
        
        [resultContacts addObject:createContact(name,surname,phone,email)];
    }

    NSArray * result = resultContacts;
    return [[CBAContactList alloc] initWithArray:result];

}

@end
