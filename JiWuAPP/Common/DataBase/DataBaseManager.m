//
//  DataBaseManager.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "DataBaseManager.h"

#import <sqlite3.h>

@implementation DataBaseManager

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
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(self){
            
        }
        
    });
    return self;
}
#pragma mark -创建数据库
-(BOOL)createDataBase{
    
    return NO;
}


@end
