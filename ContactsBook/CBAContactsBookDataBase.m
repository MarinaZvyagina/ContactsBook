//
//  CBAContactsBookDataBase.m
//  ContactsBook
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAContactsBookDataBase.h"
#import "CBAContactList.h"
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation CBAContactsBookDataBase

-(CBAContactList *)getContacts {
    
    
  //  self.getContactsWithAddressBook;
    return [CBAContactList new];
}





+ (void)getContactsWithAddressBook {
    
    ABAddressBookRef addressBook = ABAddressBookCreate();//WithOptions(NULL, nil);
    
    
    
    NSMutableArray * contactList = [[NSMutableArray alloc] init];
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    
    for (int i=0;i < nPeople;i++) {
        NSMutableDictionary *dOfPerson=[NSMutableDictionary dictionary];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople,i);
        
        //For username and surname
        ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(ref, kABPersonPhoneProperty));
        
        CFStringRef firstName, lastName;
        firstName = ABRecordCopyValue(ref, kABPersonFirstNameProperty);
        lastName  = ABRecordCopyValue(ref, kABPersonLastNameProperty);
        [dOfPerson setObject:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forKey:@"name"];
        
        //For Email ids
        ABMutableMultiValueRef eMail  = ABRecordCopyValue(ref, kABPersonEmailProperty);
        if(ABMultiValueGetCount(eMail) > 0) {
            [dOfPerson setObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0) forKey:@"email"];
            
        }
        
        //For Phone number
        NSString* mobileLabel;
        
        for(CFIndex j = 0; j < ABMultiValueGetCount(phones); j++) {
            mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, j);
            if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) forKey:@"phone"];
            }
            else if ([mobileLabel isEqualToString:(NSString*)kABPersonPhoneIPhoneLabel])
            {
                [dOfPerson setObject:(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, j) forKey:@"phone"];
                break ;
            }
            
        }
        [contactList addObject:dOfPerson];
        
    }
    NSLog(@"Contacts = %@",contactList);
}


@end
