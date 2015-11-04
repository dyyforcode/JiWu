//
//  SubAreaChooseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubAreaChooseModel : NSObject

@property (nonatomic,copy) NSString * plateId;
@property (nonatomic,copy) NSString * plateName;
@property (nonatomic,copy) NSString * areaId;

+(id)subAreaChooseModelWithNode:(NSDictionary *)node;

@end
