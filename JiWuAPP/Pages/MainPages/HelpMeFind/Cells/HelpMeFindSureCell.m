//
//  HelpMeFindSureCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HelpMeFindSureCell.h"

@interface HelpMeFindSureCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



@end

@implementation HelpMeFindSureCell


-(void)setIndex:(NSInteger)index{

    _index = index;
    
    if(index == 0){
        self.titleLabel.text = @"区域:";
        self.contentLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindAddress"];
    }else if(index == 1){
        self.titleLabel.text = @"价格:";
        self.contentLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindPrice"];
    }else if(index == 2){
        self.titleLabel.text = @"户型:";
        self.contentLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindHouseType"];
    }else if(index == 3){
        self.titleLabel.text = @"标签:";
        self.contentLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindFeature"];
    }else if(index == 4){
        self.titleLabel.text = @"补充:";
        self.contentLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindMore"];
    }
    
}





- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
