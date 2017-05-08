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

-(CBAContactList *)getContacts: (NSData *)json forFields:(NSArray<NSString *>*)fields {

    NSDictionary * JSONObject = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    NSDictionary * contacts = [JSONObject objectForKey:@"response"];

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
    
    NSMutableArray *resultContacts = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (NSDictionary *contact in contacts) {
        NSString *name = [contact objectForKey:fields[0]];
        NSString *surname = [contact objectForKey:fields[1]];
        NSString *phone = [contact objectForKey:fields[2]];
        NSString *email = [contact objectForKey:fields[3]];
        NSString *url = [contact objectForKey:fields[4]];
        
        [resultContacts addObject:createContact(name,surname,phone,email,url)];
    }

    NSArray * result = resultContacts;
    return [[CBAContactList alloc] initWithArray:result];

}

@end
