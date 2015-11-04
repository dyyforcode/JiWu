//
//  AgentDetialEvaluateCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentDetialEvaluateCell.h"

@interface AgentDetialEvaluateCell ()

@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (weak, nonatomic) IBOutlet UILabel *serveLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodReputationLabel;



@end

@implementation AgentDetialEvaluateCell


-(void)setDetialModel:(AgentDetialInfoModel *)detialModel{
    [super setDetialModel:detialModel];
    
    self.replyLabel.text = [NSString stringWithFormat:@"%@%%",detialModel.replyMark];
    self.responseLabel.text = [NSString stringWithFormat:@"%.1f分钟",[detialModel.replySpeed floatValue]];
    self.serveLabel.text = [NSString stringWithFormat:@"%@",detialModel.servicePeopleNum];
    self.goodReputationLabel.text = [NSString stringWithFormat:@"%@%%",detialModel.goodMarkPercent];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
