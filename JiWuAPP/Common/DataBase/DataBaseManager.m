//
//  DataBaseManager.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "DataBaseManager.h"

#import <sqlite3.h>
#import "MainHouseModel.h"

#define CreateDataBaseVersionTable @"CREATE TABLE IF NOT EXISTS dataBaseVersion_info (v_key TEXT PRIMARY KEY,v_value TEXT);"
#define CreateAttentionHouseInfoTable @"CREATE TABLE IF NOT EXISTS attentionHouse_info (id TEXT PRIMARY KEY,name TEXT,address TEXT,price TEXT,grouponInfo TEXT,label TEXT,status TEXT,area TEXT,path TEXT);"

@interface DataBaseManager (){
    sqlite3 * dataBase;
}

@end

@implementation DataBaseManager

#pragma mark -删除找房信息
-(BOOL)removeFindHouseInfo:(NSString *)houseId{
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    char * sqlString = "DELETE FROM attentionHouse_info WHERE id = ?;";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sqlString, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [houseId UTF8String], -1, NULL);
    int ret = sqlite3_step(stmt);
    if(ret == SQLITE_OK){
        sqlite3_finalize(stmt);
        sqlite3_close(dataBase);
        return YES;
    }
    
    return NO;
}
#pragma mark -添加找房信息
-(BOOL)insertFindHouseInfo:(MainHouseModel *)houseMoidel{
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    char * sql = "INSERT INTO attentionHouse_info values(?,?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [houseMoidel.ID UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.name UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.address UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.price UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.grouponInfo UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.label UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.status UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.area UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 1, [houseMoidel.path UTF8String], -1, NULL);
    
    int ret = sqlite3_step(stmt);
    if(ret == SQLITE_OK){
        sqlite3_finalize(stmt);
        sqlite3_close(dataBase);
        return YES;
    }
    
    return NO;
}

#pragma mark -获取数据库文件路径
-(NSString*)documentPath:(NSString*)fileName

{
    if(fileName == nil)
        return nil;
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex: 0];
    NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
    return documentsPath;
}
-(NSString *)getSQLPath{
    return [self documentPath:@"sqllite.db"];
}
#pragma mark -判断文件是否存在
-(BOOL)isExistFile{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self getSQLPath]];
}
#pragma mark -单例
+(instancetype)shareManager{
    static DataBaseManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!manager){
            manager = [[DataBaseManager alloc] init];
        }
    });
    return manager;
}
#pragma mark -初始化
-(instancetype)init{
    self = [super init];
    
        
    if(self){
        int dbVersion = 1;
        if(![self isExistFile]){
            [self createDataBase];
        }else{
            char * info = NULL;
            [self getDataBaseVersionInfoWithKey:"dBVersion" value:&info];
            if(info == NULL){
                return self;
            }
            dbVersion = atoi(info);
            free(info);
        }
        switch (dbVersion) {
            case 1:{
                [self excuteSQl:CreateDataBaseVersionTable];
                [self excuteSQl:CreateAttentionHouseInfoTable];
                [self setDBInfoValueWithKey:"db_version" value:"2"];
            }
                
            case 2:{
                
                [self setDBInfoValueWithKey:"db_version" value:"3"];
            }
                
            case 3:{
                
                [self setDBInfoValueWithKey:"db_version" value:"4"];
            }

                
            default:
                break;
        }
    }
    
        
 
    return self;
}
#pragma mark -设置数据库版本信息
-(BOOL)setDBInfoValueWithKey:(const char *)key value:(const char *)value{
    char * info = NULL;
    //查询数据库版本是否以存在
    [self getDataBaseVersionInfoWithKey:key value:&info];
    if(info != NULL){
        //存在，则更新该版本
        [self updateDataBaseVersionInfoWithKey:key value:value];
    }else{
        //不存在，则插入新版本
        [self insertDataBaseVersionInfoWithKey:key value:value];
    }
    free(info);  //手动释放指针
    return YES;
}

#pragma mark -执行语句
-(BOOL)excuteSQl:(NSString *)SQL{
    
    char * error = NULL;
    
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    const char * sql = [SQL UTF8String];
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    if(sqlite3_exec(dataBase, sql, NULL, NULL, &error) == SQLITE_OK){
        sqlite3_finalize(stmt);
        sqlite3_close(dataBase);
        return YES;
    }
    
    return NO;
}
#pragma mark -获取版本信息
-(void)getDataBaseVersionInfoWithKey:(const char *)key value:(char **)value{
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return;
    }
    char * sql = "SELECT * FROM dataBaseVersion_info WHERE v_key = ?;";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return;
    }
    sqlite3_bind_text(stmt, 1, key, -1, NULL);
    if(sqlite3_step(stmt) == SQLITE_ROW){
        char * v = (char *)sqlite3_column_text(stmt, 1);
        *value = strdup(v);
    }
    sqlite3_finalize(stmt);
    
}
#pragma mark -更新数据版本信息
-(BOOL)updateDataBaseVersionInfoWithKey:(const char *)key value:(const char *)value{
    int ret = 0;
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    char * sql = "UPDATE dataBaseVersion_info SET v_value = ? WHERE v_key = ?";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, value, -1, NULL);
    sqlite3_bind_text(stmt, 1, key, -1, NULL);
    
    ret = sqlite3_step(stmt);
    if(ret == SQLITE_DONE){
        sqlite3_finalize(stmt);
        sqlite3_close(dataBase);
        return YES;
    }
    
    return NO;
}
#pragma mark -插入数据版本信息
-(BOOL)insertDataBaseVersionInfoWithKey:(const char *)key value:(const char *)value{
    
    int ret = 0;
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    char * sql = "INSERT INTO dataBaseVersion_info (v_key,v_value) values(?,?)";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, key, -1, NULL);
    sqlite3_bind_text(stmt, 1, value, -1, NULL);
    ret = sqlite3_step(stmt);
    if(ret == SQLITE_DONE){
        sqlite3_finalize(stmt);
        sqlite3_close(dataBase);
        return YES;
    }
    
    return NO;
}
#pragma mark -创建数据库
-(BOOL)createDataBase{
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) == SQLITE_OK){
        return YES;
    }
    
    return NO;
}


@end
