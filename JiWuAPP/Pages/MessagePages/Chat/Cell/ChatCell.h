//
//  ChatCell.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageFrame;

@interface ChatCell : UITableViewCell

@property (nonatomic) MessageFrame * messageFrame;

+(instancetype)chatCellWithTableView:(UITableView *)tableView;

@end
