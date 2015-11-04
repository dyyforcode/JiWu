//
//  CPSLocationCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "CPSLocationCell.h"

@interface CPSLocationCell ()
@property (weak, nonatomic) IBOutlet UIButton *GPSButton;

@end

@implementation CPSLocationCell

-(void)setModel:(LocationModel *)model{
    [super setModel:model];
    
    [self.GPSButton setTitle:model.cityName forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
