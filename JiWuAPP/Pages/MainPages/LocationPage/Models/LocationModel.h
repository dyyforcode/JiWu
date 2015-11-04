//
//  LocationModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic,copy) NSString * pingyin;
@property (nonatomic,copy) NSString * cityId;
@property (nonatomic,copy) NSString * cityName;
@property (nonatomic,copy) NSString * hot;


+ (id) locationModelWithNode: (id) node;

@end
