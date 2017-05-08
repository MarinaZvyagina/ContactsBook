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

@implementation CBAContactsBookDataBase

-(CBAContactList *)getContacts {

    return [[CBAContactList alloc] initWithArray:[self getContactsWithAddressBook]];

}

-(NSMutableArray *)getContactsWithAddressBook{
    
    NSMutableArray *finalContactList = [[NSMutableArray alloc] init];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {
                // First time access has been granted, add the contact
                [finalContactList addObject:[self getContacts]];
            } else {
                // User denied access
                // Display an alert telling user the contact could not be added
            }
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
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
    NSArray *arrayOfAllPeople1 = (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSUInteger peopleCounter = 0;
    for (peopleCounter = 0;peopleCounter < [arrayOfAllPeople1 count]; peopleCounter++)
    {
        ABRecordRef thisPerson = (__bridge ABRecordRef) [arrayOfAllPeople1 objectAtIndex:peopleCounter];
  //      NSString *name = (__bridge NSString *) ABRecordCopyCompositeName(thisPerson);
        NSString *name = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
        NSString *surname = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
        NSString *numbers = @"";
        ABMultiValueRef number = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
        for (NSUInteger numberCounter = 0; numberCounter < ABMultiValueGetCount(number); numberCounter++)
        {
            NSString *currentPhoneNumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex(number, numberCounter);
            if ([currentPhoneNumber length]!=0)
            {
                numbers = [numbers stringByAppendingString:[currentPhoneNumber stringByAppendingString:@" "]];
            }
            
        }
        NSString *mails = @"";
        ABMultiValueRef email = ABRecordCopyValue(thisPerson, kABPersonEmailProperty);
        for (NSUInteger emailCounter = 0; emailCounter < ABMultiValueGetCount(email); emailCounter++)
        {
            NSString *currentEmail = (__bridge NSString *)ABMultiValueCopyValueAtIndex(email, emailCounter);
            if ([currentEmail length]!=0)
            {
                mails = [mails stringByAppendingString:[currentEmail stringByAppendingString:@" "]];
            }
            
        }
        
        [newContactArray addObject:createContact(name,surname,numbers,mails,@"")];
    }
    return newContactArray;
}



@end
