//
//  AgentCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentCell.h"

#import "UIImageView+WebCache.h"

@interface AgentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodEvaluateLabel;




@end

@implementation AgentCell

-(void)setAgentModel:(AgentModel *)agentModel{
    _agentModel = agentModel;
    
    if(![agentModel.avatar isEqualToString:@""]){
         [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:agentModel.avatar]];
    }else{
        self.iconImageView.image = [UIImage imageNamed:@"消息-头像.png"];
    }
   
    self.nameLabel.text = agentModel.agentName;
    self.areaLabel.text = agentModel.areaName;
    self.companyLabel.text = agentModel.agencyName;
    self.goodEvaluateLabel.text = [NSString stringWithFormat:@"好评率:%@%%",agentModel.goodCommentPercent];
    
}


- (IBAction)evaluateButtonClicked:(UIButton *)sender {
    
}
- (IBAction)phoneButtonClicked:(UIButton *)sender {
    
}
- (IBAction)chatButtonClicked:(UIButton *)sender {
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
