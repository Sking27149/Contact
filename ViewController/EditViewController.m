//
//  EditViewController.m
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (IBAction)finishButton:(id)sender {
    if (self.nameTF.text.length != 0) {
        [Contact updateContactWithGender:self.genderLabel.text PhoneNumber:self.phoneLabel.text Name:self.nameTF.text forName:self.contact.name];
        self.contact.name = self.nameTF.text;
        self.contact.gender = self.genderLabel.text;
        self.contact.phoneNumber = self.phoneLabel.text;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"姓名不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:(UIAlertActionStyleDefault) handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)cancelButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameTF.text = self.contact.name;
    self.genderLabel.text = self.contact.gender;
    self.phoneLabel.text = self.contact.phoneNumber;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
