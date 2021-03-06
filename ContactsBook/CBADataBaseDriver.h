//
//  CBADataBaseDriver.h
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CBAContactList;
@protocol CBAViewManager;

@protocol CBADataBaseDriver <NSObject>

@required
-(void)getContacts: (id<CBAViewManager>) viewManager;

@end
