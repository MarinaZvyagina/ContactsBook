//
//  CBANetworkDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"

@interface CBANetworkDataBase : NSObject <CBADataBaseDriver>
-(CBAContactList *)getContacts:(ViewController *) view;
@end
