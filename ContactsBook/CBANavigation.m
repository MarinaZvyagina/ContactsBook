//
//  CBANavigation.m
//  ContactsBook
//
//  Created by Марина Звягина on 09.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBANavigation.h"
#import "ViewController.h"
#import "CBAPathFileJsonDataBase.h"
#import "VKVMainViewController.h"
#import "CBAContactsBookDataBase.h"
#import "CBAFacebookDataBase.h"

@interface CBANavigation ()
@property (strong,nonatomic) UINavigationController *navController;
@end

@implementation CBANavigation


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController *vc = [[ViewController alloc] initWithContactManager:[CBAPathFileJsonDataBase new]];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:vc];

    NSArray* items = [[NSArray alloc] initWithObjects: @"VK", @"Facebook", @"Contacts", nil];
    
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.center = self.navigationBar.center;
    
    [self.navigationBar addSubview:segmentedControl];

    [self addChildViewController:self.navController];
    
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
  //  [self.view addSubview:vc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

typedef enum selectedStateTypes {
    VK,
    Facebook,
    Contacts
} selectedState;

- (void)segmentAction:(UISegmentedControl *)sender
{
    UIViewController *vc;

    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case VK:
            vc = [[VKVMainViewController alloc] init];
            break;
        case Facebook:
            vc =  [[ViewController alloc] initWithContactManager:[CBAFacebookDataBase new]];
            break;
        case Contacts:
            vc = [[ViewController alloc] initWithContactManager:[CBAContactsBookDataBase new]];
            break;
        default:
            break;
    }
    // [self.navController presentViewController:vc  animated:YES completion:nil];
    // [self.navigationController pushViewController:vc animated:YES];
    // [self pushViewController:vc animated:YES];
    // It work with ViewController !!!
       [self.navController setViewControllers:@[vc]];
    
    
    NSString * theTitle = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    NSLog(@"%@",theTitle);
}

@end
