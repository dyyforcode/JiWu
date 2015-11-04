//
//  LocationCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface LocationCell : UITableViewCell

@property (nonatomic) LocationModel * model;

@property (nonatomic) NSArray * modelArray;

@property (nonatomic,strong) void(^buttonClickedBlock)(LocationModel * model);

@end
