//
//  Contact.h
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DB.h"
@interface Contact : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *gender;


- (instancetype)initWithName:(NSString *)name
                      Gender:(NSString *)gender
                 PhoneNumber:(NSString *)phoneNumber;

+ (instancetype)contactWithName:(NSString *)name
                         Gender:(NSString *)gender
                    PhoneNumber:(NSString *)phoneNumber;


+ (NSArray *)getAllContact;

+ (void)insertContactWithName:(NSString *)name
                       Gender:(NSString *)gender
                  PhoneNumber:(NSString *)phoneNumber;

+ (void)deleteContactForName:(NSString *)name;

+ (Contact *)findContactForName:(NSString *)name;

+ (void)updateContactWithGender:(NSString *)gender
                    PhoneNumber:(NSString *)phoneNumber
                           Name:(NSString *)name
                        forName:(NSString *)newName;

+ (NSArray *)findContactsByNname:(NSString *)name;

@end
