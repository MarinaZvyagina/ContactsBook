//
//  Cell.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBACell.h"
#import "CBAImage.h"
@import Masonry;


@interface CBACell()
@property (nonatomic, strong) UILabel * Name;
@property (nonatomic, strong) UILabel * Surname;
@property (nonatomic, strong) CBAImage * Info;

@end

@implementation CBACell
{
    NSString * _name;
    UIColor * _color;
    NSArray<UIColor *> * colors;
}

-(instancetype)initWithName: (NSString *) name AndSurname: (NSString *)surname andURL: (NSString *)url {
    self = [super init];
    colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor grayColor], [UIColor greenColor], [UIColor cyanColor], [UIColor orangeColor], [UIColor yellowColor], nil];
    
    
    if (self) {
        _name = name;
        self.Info = [[CBAImage alloc] initWithURL:[NSURL URLWithString:url]];

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
        
        self.Info.layer.cornerRadius = 20;
        
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

- (UIColor *)generateColorFromInitials: (NSString *) name and:(NSString *)surname {
    char firstNameCharacter = [name characterAtIndex:0];
    char firstSurnameCharacter = [surname characterAtIndex:0];
    NSUInteger indexForColor = (firstNameCharacter + firstSurnameCharacter) % 7;
    return [[colors objectAtIndex:indexForColor] colorWithAlphaComponent:0.5];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
