//
//  CBAContactsBookDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"

@interface CBAContactsBookDataBase : NSObject<CBADataBaseDriver>
-(CBAContactList *)getContacts:(ViewController *) view;
@end
