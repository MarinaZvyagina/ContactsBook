//
//  CBADataBaseDriver.h
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CBAContactList;

@protocol CBADataBaseDriver <NSObject>

@required
-(CBAContactList *)getContacts ;

@end
