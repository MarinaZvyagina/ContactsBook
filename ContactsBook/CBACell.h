//
//  Cell.h
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAContact.h"

extern NSString *const CBACellIdentifier;

@interface CBACell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(instancetype)initWithName: (NSString *) name AndSurname: (NSString *)surname andURL: (NSString *)url;
- (void)addContact:(CBAContact *)contact;
@end
