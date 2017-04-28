//
//  CBAContactList.h
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBAContact;

@interface CBAContactList : NSObject

@property(nonatomic, readonly) NSUInteger count;

- (instancetype)initWithArray:(NSArray<CBAContact *> *)contacts;
- (CBAContact*)objectAtIndexedSubscript:(NSUInteger)index;

@end
