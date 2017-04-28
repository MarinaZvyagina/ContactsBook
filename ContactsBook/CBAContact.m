//
//  CBAContact.m
//  ContactsBookApplication
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "CBAContact.h"

@implementation CBAContact

-(BOOL) checkString: (NSString *)string withRegularExpression:(NSString *)regExpr {
    NSRegularExpression * expression = [NSRegularExpression regularExpressionWithPattern:regExpr
                                                                                 options:0
                                                                                   error:NULL];
    NSTextCheckingResult * res = [expression firstMatchInString:string
                                                        options:0
                                                          range:NSMakeRange(0, string.length)];
    return  (res.range.length == string.length);
}


-(BOOL) checkName: (NSString *)name {
    NSString * nameRegExpr = @"[A-Z][a-z]*";
    return [self checkString: name withRegularExpression:nameRegExpr];
}



@end
