//
//  ViewController.h
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBADataBaseDriver.h"

@interface ViewController : UIViewController
-(void)updateContacts:(CBAContactList *)newContacts;
-(instancetype) initWithContactManager:(id<CBADataBaseDriver>) contactManager;
@property (nonatomic, strong) UITableView * tableView;
@end

