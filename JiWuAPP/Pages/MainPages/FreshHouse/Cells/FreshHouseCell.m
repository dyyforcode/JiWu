//
//  FreshHouseCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "FreshHouseCell.h"

#import "UIImageView+WebCache.h"

@interface FreshHouseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLeastLabel;


@end

@implementation FreshHouseCell

+(id)freshHouseCellWithTableView:(UITableView *)tableView{
    NSString * cellID = @"FreshHouseCell";
    [tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
    return [tableView dequeueReusableCellWithIdentifier:cellID];
}

-(void)setHouseModel:(MainHouseModel *)houseModel{
    _houseModel = houseModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:houseModel.path]];
    self.nameLabel.text = houseModel.name;
    self.addLabel.text = houseModel.area;
    NSArray * desc = [houseModel.features componentsSeparatedByString:@","];
    if(desc.count < 1){
        
    }else if(desc.count == 1){
        self.descLabel.text = [NSString stringWithFormat:@"%@ ",desc[0]];
    }else if(desc.count == 2){
        self.descLabel.text = [NSString stringWithFormat:@"%@  |  %@ ",desc[0],desc[1]];
    }else{
        self.descLabel.text = [NSString stringWithFormat:@"%@  |  %@  |  %@",desc[0],desc[1],desc[2]];
    }
    self.priceLeastLabel.text = houseModel.price;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
