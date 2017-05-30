//
//  CBAViewManager.h
//  ContactsBook
//
//  Created by Марина Звягина on 29.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CBAContactList;
@protocol CBAViewManager <NSObject>
-(void) reloadView;
-(void) goToRootViewController;
-(void) updateContacts:(CBAContactList *) newContacts;
-(void) reloadTable;
@end
