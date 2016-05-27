//
//  DB.m
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "DB.h"
static sqlite3 *db = nil;

@implementation DB

+ (sqlite3 *)getDB {
    if (db != nil) {
        return db;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *contatPath = [docPath stringByAppendingPathComponent:@"contact.sqlite"];
    NSLog(@"%@", docPath);
    if ([fileManager fileExistsAtPath:contatPath] == NO) {
       
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"mydatabase" ofType:@"sqlite"];
        [fileManager copyItemAtPath:bundlePath toPath:contatPath error:nil];
    }
    NSLog(@"%@", docPath);
    sqlite3_open([contatPath UTF8String], &db);
    return db;
}

+ (void)close {
    sqlite3_close(db);
    db = nil;
}

+ (void)dropWithTable:(NSString *)table {
    sqlite3 *db = [self getDB];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "drop table ?", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [table UTF8String], -1, nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

@end
