//
//  CBAViewManager.h
//  ContactsBook
//
//  Created by Марина Звягина on 29.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CBAViewManager <NSObject>
-(void) reloadView;
-(void) goToRootViewController;
@end
