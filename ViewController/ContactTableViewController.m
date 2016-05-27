//
//  ContactTableViewController.m
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "ContactTableViewController.h"
#import "Contact.h"
#import "ContactTableViewCell.h"
#import "PinYin.h"
#import "DetailTableViewController.h"
#import "SearchTableViewController.h"
@interface ContactTableViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *contactArray;
@property (nonatomic, strong) NSMutableDictionary *contactDic;
@property (nonatomic, strong) NSArray *keyArray;
@property (nonatomic, strong) UIView *searchView;

@end

@implementation ContactTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
    [self.tableView reloadData];
}

- (NSMutableDictionary *)contactDic {
    if (_contactDic == nil) {
        _contactDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _contactDic;
}

- (void)getData {
    self.keyArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
    for (NSString *key in self.keyArray) {
        NSMutableArray *tempArr = [@[] mutableCopy];
        [self.contactDic setObject:tempArr forKey:key];
    }
    self.contactArray =[[Contact getAllContact] mutableCopy];
    for (Contact *contact in self.contactArray) {
        NSString *key = [contact.name uppercasePinYinFirstLetter];
        [self.contactDic[key] addObject:contact];
    }
//    for (NSString *key in self.contactDic.allKeys) {
//        [self.contactDic[key] sortUsingSelector:@selector(compare:)];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    CGFloat kWidth = self.view.frame.size.width;
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    UITextField *searchTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, kWidth - 40, 20)];
    searchTF.delegate = self;
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.backgroundColor = [UIColor whiteColor];
    [self.searchView addSubview:searchTF];
    self.searchView.backgroundColor = [UIColor grayColor];
    searchTF.placeholder = @"搜索";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索"]];
    imageView.frame = CGRectMake(0, 0, 15, 15);
    searchTF.leftView = imageView;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    self.tableView.tableHeaderView = self.searchView;
    self.tableView.separatorColor = [UIColor clearColor];
    CGFloat kHeight = self.view.frame.size.height;
    UIView *cancelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, kHeight - 345)];
    cancelView.backgroundColor = [UIColor grayColor];
    cancelView.alpha = 0.2;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [cancelView addGestureRecognizer:tap];
    //UIView *touchView = [[UIView alloc] initWithFrame:self.view.frame];
    //[self.tableView addSubview:touchView];
   // [touchView addGestureRecognizer:tap];
    searchTF.inputAccessoryView = cancelView;
    
}

- (void)tap {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSArray *array = [Contact findContactsByNname:textField.text];
    NSLog(@"%@", textField.text);
    SearchTableViewController *resultView = [[SearchTableViewController alloc] init];
    resultView.contactArray = array;
    [self.navigationController pushViewController:resultView animated:YES];
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.contactDic[self.keyArray[section]] count] == 0) {
        return 0;
    }else
        return 30;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keyArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.keyArray[section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactDic[self.keyArray[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact" forIndexPath:indexPath];
    cell.nameLabel.text = [self.contactDic[self.keyArray[indexPath.section]][indexPath.row] name];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"detail"]) {
        ContactTableViewCell *cell = (ContactTableViewCell *)sender;
        DetailTableViewController *detailTVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Contact *contact = self.contactDic[self.keyArray[indexPath.section]][indexPath.row];
        detailTVC.contact = contact;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        Contact *contact = self.contactDic[self.keyArray[indexPath.section]][indexPath.row];
        [self.contactDic[self.keyArray[indexPath.section]] removeObjectAtIndex:indexPath.row];
        [Contact deleteContactForName:contact.name];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [self.tableView endUpdates];
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

*/

@end
