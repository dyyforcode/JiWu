//
//  AreaLocationCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AreaLocationCell.h"

@implementation AreaLocationCell

+ (id) areaLocationCellWithTableView:(UITableView *)tableView{
    NSString * cellIdentifier = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellIdentifier];
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(void)setModel:(LocationModel *)model{
    [super setModel:model];
    
    self.textLabel.text = model.cityName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
