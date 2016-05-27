//
//  Contact.m
//  Contact
//
//  Created by lanou on 16/5/13.
//  Copyright © 2016年 Sking. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)initWithName:(NSString *)name Gender:(NSString *)gender PhoneNumber:(NSString *)phoneNumber {
    self = [super init];
    if (self) {
        self.name = name;
        self.gender = gender;
        self.phoneNumber = phoneNumber;
    }
    return self;
}

+ (instancetype)contactWithName:(NSString *)name Gender:(NSString *)gender PhoneNumber:(NSString *)phoneNumber {
    return [[Contact alloc] initWithName:name Gender:gender PhoneNumber:phoneNumber];
}

+ (NSArray *)getAllContact {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from contact", -1, &stmt, nil);
    NSMutableArray *contactArray = nil;
    if (result == SQLITE_OK) {
        contactArray = [NSMutableArray arrayWithCapacity:0];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cName = sqlite3_column_text(stmt, 0);
            const unsigned char *cGender = sqlite3_column_text(stmt, 1);
            const unsigned char *cPhoneNumber = sqlite3_column_text(stmt, 2);
            NSString *name = @((const char *)cName);
            NSString *gender = @((const char *)cGender);
            NSString *phoneNumber = @((const char *)cPhoneNumber);
            Contact *contact = [Contact contactWithName:name Gender:gender PhoneNumber:phoneNumber];
            [contactArray addObject:contact];
        }
    }
    sqlite3_finalize(stmt);
    return contactArray;
}

+ (Contact *)findContactForName:(NSString *)name {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, "select * from contact where name = ?", -1, &stmt, nil);
    Contact *contact = nil;
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, nil);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cGender = sqlite3_column_text(stmt, 1);
            const unsigned char *cPhoneNumber = sqlite3_column_text(stmt, 2);
            NSString *gender = [NSString stringWithUTF8String:(const char *)cGender];
            NSString *phoneNumber = [NSString stringWithUTF8String:(const char *)cPhoneNumber];
            contact = [Contact contactWithName:name Gender:gender PhoneNumber:phoneNumber];
        }
    }
    sqlite3_finalize(stmt);
    return contact;
}

+(NSArray *)findContactsByNname:(NSString *)name {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "select *from contact where name like ?", -1, &stmt, nil);
    NSMutableArray *mArr = nil;
    if (result == SQLITE_OK) {
        mArr = [NSMutableArray arrayWithCapacity:0];
        NSString *temp = [NSString stringWithFormat:@"%%%@%%", name];
        sqlite3_bind_text(stmt, 1, [temp UTF8String], -1, nil);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *cName = sqlite3_column_text(stmt, 0);
            const unsigned char *cGender = sqlite3_column_text(stmt, 1);
            const unsigned char *cPhoneNumber = sqlite3_column_text(stmt, 2);
            NSString *name2 = @((const char*) cName);
            NSString *gender = @((const char*) cGender);
            NSString *phoneNumber = @((const char *) cPhoneNumber);
            
            Contact *contact = [Contact contactWithName:name2 Gender:gender PhoneNumber:phoneNumber];
            [mArr addObject:contact];
        }
    }
    sqlite3_finalize(stmt);
    return mArr;
}

+ (void)insertContactWithName:(NSString *)name Gender:(NSString *)gender PhoneNumber:(NSString *)phoneNumber {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "insert into contact (name, gender, phone_number) values(?, ?, ?)", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [gender UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [phoneNumber UTF8String], -1, nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

+ (void)updateContactWithGender:(NSString *)gender PhoneNumber:(NSString *)phoneNumber Name:(NSString *)name forName:(NSString *)newName {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "update contact set gender=?, phone_number=?, name = ? where name = ?", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [gender UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 2, [phoneNumber UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 3, [name UTF8String], -1, nil);
        sqlite3_bind_text(stmt, 4, [newName UTF8String], -1, nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}

+ (void)deleteContactForName:(NSString *)name {
    sqlite3 *db = [DB getDB];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, "delete from contact where name = ?", -1, &stmt, nil);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, nil);
        sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
}



@end
