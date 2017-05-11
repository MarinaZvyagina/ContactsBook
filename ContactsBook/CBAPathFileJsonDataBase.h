//
//  CBAPathFileJsonDataBase.h
//  ContactsBook
//
//  Created by Марина Звягина on 28.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBADataBaseDriver.h"

@interface CBAPathFileJsonDataBase : UIImageView <CBADataBaseDriver>
-(CBAContactList *)getContacts:(UITableView *) tableView;

@end
