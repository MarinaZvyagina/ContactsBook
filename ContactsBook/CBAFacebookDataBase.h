//
//  CBAFacebookDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 08.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"

@interface CBAFacebookDataBase : NSObject<CBADataBaseDriver>
-(CBAContactList *)getContacts:(ViewController *) view;
@end
