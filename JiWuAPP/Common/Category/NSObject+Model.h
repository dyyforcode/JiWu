//
//  NSObject+Model.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+(id) objectWithDictionary: (NSDictionary *)dict;

-(id) initWithDictionary: (NSDictionary *)dict;

@end
