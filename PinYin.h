//
//  PinYin.h
//  PhoneBookDemo
//
//  Created by ZeroHour on 15/9/26.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAllLetter @"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

char pinyinFirstLetter(unsigned short hanzi);

@interface NSString (FirstLetter)

- (NSString *)uppercasePinYinFirstLetter;
- (NSString *)lowercasePinYinFirstLetter;

@end


