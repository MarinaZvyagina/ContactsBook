//
//  CBANetworkDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"
#import "CBAViewManager.h"

@interface CBANetworkDataBase : NSObject <CBADataBaseDriver>
-(void)getContacts: (id<CBAViewManager>) viewManager;
@end
