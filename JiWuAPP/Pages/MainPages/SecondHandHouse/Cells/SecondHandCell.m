//
//  SecondHandCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "SecondHandCell.h"
#import "UIImageView+WebCache.h"

@interface SecondHandCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@end

@implementation SecondHandCell

-(void)setModel:(SecondHandHouseModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.path]];
    self.titleLabel.text = model.name;
    self.addressLabel.text = model.areaName;
    self.priceLabel.text = model.price;
    self.descriptionLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
