//
//  CBAContact.h
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBAContact : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * surname;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * urlForPhoto;

-(BOOL) checkString: (NSString *)string withRegularExpression:(NSString *)regExpression;
-(BOOL) checkName: (NSString *)name;
@end
