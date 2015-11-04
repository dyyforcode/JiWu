//
//  FeatureChooseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeatureChooseModel : NSObject

@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * name;

+(id)featureChooseModelWithNode:(NSDictionary *)node;

@end
