//
//  DataBaseManager.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "DataBaseManager.h"

#import <sqlite3.h>
#import "HouseDetialModel.h"

#define CreateDataBaseVersionTable @"CREATE TABLE IF NOT EXISTS dataBaseVersion_info (v_key TEXT PRIMARY KEY,v_value TEXT);"
#define CreateAttentionHouseInfoTable @"CREATE TABLE IF NOT EXISTS attentionHouse_info (id TEXT PRIMARY KEY,name TEXT,address TEXT,price TEXT,grouponInfo TEXT,label TEXT,status TEXT,path TEXT);"

#define ModifyAttentionHouseInfoTable @"ALTER TABLE attentionHouse_info ADD COLUMN cityName TEXT;"

@interface DataBaseManager (){
    sqlite3 * dataBase;
}

@end

@implementation DataBaseManager

#pragma mark -查找关注房屋信息
-(NSArray *)selectAttentionHouse{
    
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return nil;
    }
    char * sqlString = "SELECT * FROM attentionHouse_info;";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sqlString, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return nil;
    }
    
    NSMutableDictionary * houseDict = [NSMutableDictionary dictionary];
    NSMutableArray * mutableArray = [NSMutableArray array];
    NSArray * titles = @[@"id",@"name",@"address",@"price",@"grouponInfo",@"label",@"status",@"path",@"cityName"];
    while(sqlite3_step(stmt) == SQLITE_ROW){
       
        for(int i=0;i<9;i++){
            char * house = (char *)sqlite3_column_text(stmt, i);
            
        //    NSLog(@"%d C字符串  %s",i,strdup(house));
            NSString * houseProperty = [NSString stringWithUTF8String:strdup(house)];
           
            [houseDict setValue:houseProperty forKey:titles[i]];
        }
        [mutableArray addObject:houseDict];
    }
    
    
    return mutableArray;
}
#pragma mark -删除关注房屋信息
-(BOOL)removeAttentionHouseInfo:(NSString *)houseId{
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
#pragma mark -添加关注房屋信息
-(BOOL)insertAttentionHouseInfo:(HouseDetialModel *)houseModel cityName:(NSString *)cityName{
    if(sqlite3_open([[self getSQLPath] UTF8String], &dataBase) != SQLITE_OK){
        return NO;
    }
    char * sql = "INSERT INTO attentionHouse_info values(?,?,?,?,?,?,?,?,?)";
    sqlite3_stmt * stmt;
    int result = sqlite3_prepare_v2(dataBase, sql, -1, &stmt, nil);
    if(result != SQLITE_OK){
        return NO;
    }
    sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%@",houseModel.ID] UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [houseModel.name UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 3, [houseModel.address UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 4, [houseModel.price UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 5, [houseModel.grouponInfo UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 6, [houseModel.label UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 7, [houseModel.status UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 8, [houseModel.path UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 9, [cityName UTF8String], -1, NULL);
    
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
    NSLog(@"sqlitePath : %@",[self getSQLPath]);
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
            NSLog(@"DBVersion : %d",dbVersion);
        }
         NSLog(@"DBVersion : %d",dbVersion);
        switch (dbVersion) {
            case 1:{
                [self excuteSQl:CreateDataBaseVersionTable];
                [self excuteSQl:CreateAttentionHouseInfoTable];
                [self setDBInfoValueWithKey:"db_version" value:"2"];
            }
                
            case 2:{
                [self excuteSQl:ModifyAttentionHouseInfoTable];
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
