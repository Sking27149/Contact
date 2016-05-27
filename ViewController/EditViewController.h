//
//  EditViewController.h
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@interface EditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *nameTF;

@property (strong, nonatomic) IBOutlet UITextField *phoneLabel;

@property (strong, nonatomic) IBOutlet UITextField *genderLabel;

@property (nonatomic, strong) Contact *contact;
@end
