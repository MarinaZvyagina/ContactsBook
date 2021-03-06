//
//  ViewController.m
//  ContactsBook
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "ViewController.h"
#import "CBACell.h"
#import "DetailInformation.h"
#import "CBAContactList.h"
#import "CBANetworkDataBase.h"
#import "CBAContactsBookDataBase.h"
#import "CBAFacebookDataBase.h"
#import "CBAVKViewController.h"
#import "CBAFaceBookViewController.h"
#import "CBAViewManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@import Masonry;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, CBAViewManager>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) CBAContactList * contacts;
@property (nonatomic, strong) id<CBADataBaseDriver> contactManager;

@end

@implementation ViewController

-(instancetype) initWithContactManager:(id<CBADataBaseDriver>) contactManager {
    self = [super init];
    if (self) {
        self.contactManager = contactManager;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"VK", @"Facebook", @"Contacts", nil]];
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    [self.contactManager getContacts:self];
    [self.tableView registerClass:[CBACell class] forCellReuseIdentifier:CBACellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (CBACell *)[tableView dequeueReusableCellWithIdentifier:CBACellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CBACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CBACellIdentifier];
    }
    CBAContact * contact = [self.contacts objectAtIndexedSubscript:indexPath.row];
    [(CBACell *)cell addContact:contact];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBAContact * cont = [self.contacts objectAtIndexedSubscript:indexPath.row];
    NSString * name = cont.name;
    NSString * surname = cont.surname;
    NSString * phone = cont.phone;
    NSString * url = cont.urlForPhoto;
    DetailInformation * detailInfo = [[DetailInformation alloc] initWithName:name                                                                     surname:surname andPhone:phone andUrl:url];
    detailInfo.view.backgroundColor = [UIColor whiteColor];
    detailInfo.navigationItem.title = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.navigationController pushViewController:detailInfo animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void) reloadData {
    [self.contactManager getContacts:self];
}

-(void) updateContacts: (CBAContactList *) newContacts {
    self.contacts = newContacts;
}

-(void) reloadTable {
    [self.tableView reloadData];
}

-(void) goToRootViewController {
    [self.navigationController popViewControllerAnimated:YES];
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
    NSInteger index = sender.selectedSegmentIndex;
    NSString* accessToken;
    switch (index) {
        case VK:
            self.contactManager = [CBANetworkDataBase new];
            accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
            break;
        case Facebook:
            self.contactManager = [CBAFacebookDataBase new];
            break;
        case Contacts:
            self.contactManager = [CBAContactsBookDataBase new];
            break;
        default:
            break;
    }
    if ((index == VK) && (accessToken == nil)) {
        CBAVKViewController *vkViewController=[[CBAVKViewController alloc] initWithViewManager:self];;
        [self.navigationController pushViewController:vkViewController animated:YES];
    } else if ((index == Facebook) && !([FBSDKAccessToken currentAccessToken])) {
        CBAFaceBookViewController * fbViewController = [[CBAFaceBookViewController alloc] initWithViewManager:self];
        [self.navigationController pushViewController:fbViewController animated:YES];
    } else {
        [self reloadData];
    }
}

@end
