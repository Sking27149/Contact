//
//  DB.h
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DB : NSObject
+ (sqlite3 *)getDB;

+ (void)close;

+ (void)dropWithTable:(NSString *)table;

@end
