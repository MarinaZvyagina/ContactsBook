//
//  Cell.h
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBACell : UITableViewCell
//@property (nonatomic, strong) UILabel * Name;
//@property (nonatomic, strong) UILabel * Surname;
//@property (nonatomic, strong) UIButton * Info;
//@property (nonatomic, strong) NSString *
-(instancetype)initWithName: (NSString *) name AndSurname: (NSString *)surname andURL: (NSString *)url;
@end
