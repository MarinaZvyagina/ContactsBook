//
//  VKVMainViewController.h
//  VK videos
//
//  Created by 1 on 17.03.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBAViewManager.h"

@interface VKVMainViewController : UIViewController
-(instancetype) initWithViewManager: (id<CBAViewManager>) viewManager;
@end
