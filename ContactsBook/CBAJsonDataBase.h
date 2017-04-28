//
//  CBAJsonDataBase.h
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBADataBaseDriver.h"

@interface CBAJsonDataBase : NSObject <CBADataBaseDriver>
-(CBAContactList *)getContacts;
@end
