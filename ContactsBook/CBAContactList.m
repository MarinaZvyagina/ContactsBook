//
//  CBAContactList.m
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "CBAContactList.h"
#import "CBAContact.h"

@interface CBAContactList()

@property(nonatomic, copy, readwrite) NSArray *contacts;
@end

@implementation CBAContactList



- (instancetype)initWithArray:(NSArray<CBAContact *> *)contacts {
    self = [super init];
    if (self) {
        _contacts = contacts;
    }
    return self;
}

- (NSUInteger)count {
    return self.contacts.count;
}

- (CBAContact*)objectAtIndexedSubscript:(NSUInteger)index {
    return self.contacts[index];
}

@end
