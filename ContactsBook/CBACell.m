//
//  Cell.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBACell.h"
#import "CBAImage.h"
#import "CBAContact.h"
@import Masonry;

NSString *const CBACellIdentifier = @"CBACellIdentifier";

@interface CBACell()
@property (nonatomic, strong) UILabel * Name;
@property (nonatomic, strong) UILabel * Surname;
@property (nonatomic, strong) CBAImage * Info;

@end

@implementation CBACell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self createSubviews];
    }
    return self;
}

-(void)createSubviews {
    self.Info = [CBAImage new];
    self.Name = [UILabel new];
    self.Surname = [UILabel new];
    
    [self addSubview:self.Name];
    [self addSubview:self.Surname];
    [self addSubview:self.Info];
    
    [self.Info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(3);
        make.width.equalTo(@(self.frame.size.height));
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
        make.height.equalTo(@40);
    }];
    
    self.Info.layer.cornerRadius = self.frame.size.height / 2;
    self.Info.clipsToBounds = YES;
    
    [self.Name setTextAlignment:NSTextAlignmentCenter];
    [self.Surname setTextAlignment:NSTextAlignmentCenter];
    
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Info.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.Surname.mas_top);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.width.greaterThanOrEqualTo(@100).width.priorityHigh();
    }];
    
    [self.Surname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Info.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.Name.mas_width);
        make.right.equalTo(self.mas_right).with.offset(-20);
    }];
    
}

-(instancetype)initWithName: (NSString *) name AndSurname: (NSString *)surname andURL: (NSString *)url  {
    self = [super init];

   //  colors = @[UIColor.redColor, UIColor.blueColor, UIColor.grayColor, UIColor.greenColor, UIColor.cyanColor, UIColor.orangeColor, UIColor.yellowColor];
    
    if (self) {
        // If local json file is chosen, my photo shows
        NSString * initUrl = url ? url : @"https://lh3.googleusercontent.com/-NmcPm_QhFzw/AAAAAAAAAAI/AAAAAAAAAAA/AHalGho6R0sfDXYGc7TOb35Svg_uk5h6Ug/mo/photo.jpg?sz=46";
        
        self.Info = [[CBAImage alloc] initWithURL:[NSURL URLWithString:initUrl]];

        
        self.Name = [UILabel new];
        self.Surname = [UILabel new];
        
        [self addSubview:self.Name];
        [self addSubview:self.Surname];
        [self addSubview:self.Info];
        
        [self.Info mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(5);
            make.top.equalTo(self.mas_top).with.offset(3);
            make.width.equalTo(@40);
            make.bottom.equalTo(self.mas_bottom).with.offset(-3);
            make.height.equalTo(@40);
        }];

        self.Info.layer.cornerRadius =  self.frame.size.height / 2;
        self.Info.clipsToBounds = YES;
        
        
        self.Name.text = name;
        [self.Name setTextAlignment:NSTextAlignmentCenter];
        
        self.Surname.text = surname;
        [self.Surname setTextAlignment:NSTextAlignmentCenter];
        
        [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Info.mas_right).with.offset(10);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.Surname.mas_top);
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.width.greaterThanOrEqualTo(@100).width.priorityHigh();
        }];
        
        [self.Surname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Info.mas_right);
            make.bottom.equalTo(self.mas_bottom);
            make.width.equalTo(self.Name.mas_width);
            make.right.equalTo(self.mas_right).with.offset(-20);
        }];
    }
    return self;
}

- (void)addContact:(CBAContact *)contact {
    self.Name.text = contact.name;
    self.Surname.text = contact.surname;
    
    NSString * initUrl = contact.urlForPhoto ? contact.urlForPhoto : @"https://lh3.googleusercontent.com/-NmcPm_QhFzw/AAAAAAAAAAI/AAAAAAAAAAA/AHalGho6R0sfDXYGc7TOb35Svg_uk5h6Ug/mo/photo.jpg?sz=46";
    
    NSURL * url = [NSURL URLWithString:initUrl];
    CIImage * ciImage = [[CIImage alloc] initWithContentsOfURL:url];
    self.Info.image = [[UIImage alloc] initWithCIImage:ciImage scale:1.0 orientation:UIImageOrientationUp];
}

/*
- (UIColor *)generateColorFromInitials: (NSString *) name and:(NSString *)surname {
    NSString *firstNameCharacter = [name substringToIndex:1];
    NSString *firstSurnameCharacter = [surname substringToIndex:2];
    NSUInteger indexForColor = (firstNameCharacter.hash + firstSurnameCharacter.hash) % 7;
    return [[colors objectAtIndex:indexForColor] colorWithAlphaComponent:0.5];
}*/

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
