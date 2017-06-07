//
//  CBAContactsBookDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAContactsBookDataBase.h"
#import "CBAContactList.h"
#import "CBAContact.h"
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ViewController.h"

@implementation CBAContactsBookDataBase

-(void)getContacts: (id<CBAViewManager>) viewManager {
    CBAContactList * contacts = [[CBAContactList alloc] initWithArray:[self getContactsWithAddressBook]];
    [viewManager updateContacts:contacts];
    [viewManager reloadTable];
}

-(NSArray *)getContactsWithAddressBook{
    
    NSMutableArray *finalContactList = [[NSMutableArray alloc] init];

    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                // First time access has been granted, add the contact
                [finalContactList addObject:[self getCBContacts]];
            } else {
                // User denied access
                // Display an alert telling user the contact could not be added
            }
        });
    }
    else if (authorizationStatus == kABAuthorizationStatusAuthorized) {
        // The user has previously given access, add the contact
        finalContactList = [self getCBContacts];
    }
    else {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
    return finalContactList;
    
}

-(NSMutableArray *)getCBContacts
{
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
    
    NSMutableArray *newContactArray = [[NSMutableArray alloc]init];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray *arrayOfAllPeople = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (NSUInteger peopleCounter = 0; peopleCounter < arrayOfAllPeople.count; peopleCounter++) {
        ABRecordRef thisPerson = (__bridge ABRecordRef) arrayOfAllPeople[peopleCounter];
        NSString *name = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
        NSString *surname = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
        ABMultiValueRef number = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
        NSString *numbers = [self getItemStringFromABMultiValueRef:number];
        ABMultiValueRef email = ABRecordCopyValue(thisPerson, kABPersonEmailProperty);
        NSString *mails = [self getItemStringFromABMultiValueRef:email];
        [newContactArray addObject:createContact(name,surname,numbers,mails,@"")];
    }
    return newContactArray;
}

-(NSString *)getItemStringFromABMultiValueRef : (ABMultiValueRef) ref {
    NSString *items = @"";
    for (NSUInteger itemCounter = 0; itemCounter < ABMultiValueGetCount(ref); itemCounter++) {
        NSString *currentItem = (__bridge NSString *)ABMultiValueCopyValueAtIndex(ref, itemCounter);
        if ([currentItem length]!=0) {
            items = [items stringByAppendingString:[currentItem stringByAppendingString:@" "]];
        }
    }
    return items;
}

@end
