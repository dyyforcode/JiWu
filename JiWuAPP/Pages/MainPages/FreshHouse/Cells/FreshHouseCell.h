//
//  FreshHouseCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MainHouseModel.h"

@interface FreshHouseCell : UITableViewCell

@property (nonatomic) MainHouseModel * houseModel;

+(id)freshHouseCellWithTableView:(UITableView *)tableView;

@end
