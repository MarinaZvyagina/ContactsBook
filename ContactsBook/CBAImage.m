//
//  CBAImage.m
//  ContactsBook
//
//  Created by Марина Звягина on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAImage.h"

@implementation CBAImage

-(instancetype) initWithURL: (NSURL *)url {
    self = [super init];
    CIImage * im = [[CIImage alloc] initWithContentsOfURL:url];
    self.image = [[UIImage alloc] initWithCIImage:im scale:1.0 orientation:UIImageOrientationUp];
    return self;
}

@end
