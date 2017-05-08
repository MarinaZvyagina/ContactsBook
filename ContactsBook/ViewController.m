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
#import "CBADataBaseDriver.h"
#import "CBANetworkDataBase.h"
#import "CBAPathFileJsonDataBase.h"
#import "CBAContactsBookDataBase.h"
#import "CBAContact.h"
@import Masonry;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) CBAContactList * contacts;
@property (nonatomic, strong) id<CBADataBaseDriver> contactManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];  
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(30);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    /* VK */
    self.contactManager = [CBAContactsBookDataBase new];
    /* You shoud use it for work with local json file */
    //self.contactManager = [CBAPathFileJsonDataBase new];
    
    self.contacts = [self.contactManager getContacts];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
