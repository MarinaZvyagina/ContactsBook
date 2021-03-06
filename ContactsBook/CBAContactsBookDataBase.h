//
//  CBAContactsBookDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 04.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"
#import "CBAViewManager.h"

@interface CBAContactsBookDataBase : NSObject<CBADataBaseDriver>
-(void)getContacts: (id<CBAViewManager>) viewManager;
@end
