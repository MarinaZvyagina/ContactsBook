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
#import "CBAPathFileJsonDataBase.h"
#import "CBAContactsBookDataBase.h"
#import "CBAFacebookDataBase.h"
#import "CBAContact.h"
#import "VKVMainViewController.h"
#import "CBAViewManager.h"
@import Masonry;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, CBAViewManager>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) CBAContactList * contacts;
@property (nonatomic, strong) id<CBADataBaseDriver> contactManager;

@end

@implementation ViewController

static CBAContactList * staticContacts;
+ (CBAContactList *) staticContacts
{ @synchronized(self) { return staticContacts; } }
+ (void) setstaticContacts:(CBAContactList *)val
{ @synchronized(self)
    { staticContacts = val; } }


-(instancetype) initWithContactManager:(id<CBADataBaseDriver>) contactManager {
    self = [super init];
    if (self) {
        self.contactManager = contactManager;
    }
    return self;
}

- (void)viewDidLoad {
    staticContacts = [CBAContactList new];
    [super viewDidLoad];  
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"VK", @"Facebook", @"Contacts", nil]];
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];

   // self.segmentedControl.center = self.navigationController.navigationBar.center;
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

   // self.navigationController.navigationBar set
    
    [self.navigationController.navigationBar addSubview:self.segmentedControl];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    self.contacts = [self.contactManager getContacts:self];
    staticContacts = self.contacts;
    [self.tableView registerClass:[CBACell class] forCellReuseIdentifier:CBACellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return staticContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (CBACell *)[tableView dequeueReusableCellWithIdentifier:CBACellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CBACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CBACellIdentifier];
    }
    CBAContact * contact = [staticContacts objectAtIndexedSubscript:indexPath.row];
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
   // [self.view addSubview:detailInfo];
 //   self.tableView view
    [self.navigationController pushViewController:detailInfo animated:YES];
   // [self presentViewController:detailInfo animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void) reloadView {
    self.contacts = [self.contactManager getContacts:self];
    staticContacts = self.contacts;
    [self.tableView reloadData];
}

-(void) goToRootViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

+(void)updateContacts:(CBAContactList *)newContacts {
    staticContacts = newContacts;
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
        VKVMainViewController *mainVC=[[VKVMainViewController alloc] initWithViewManager:self];;
        [self.navigationController pushViewController:mainVC animated:YES];
      //  [self presentViewController:mainVC animated:YES completion:nil];
    }
    else {
        self.contacts = [self.contactManager getContacts:self];
        staticContacts = self.contacts;
        [self.tableView reloadData];
    }
}

@end
