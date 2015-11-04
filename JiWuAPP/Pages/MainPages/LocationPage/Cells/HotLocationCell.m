//
//  HotLocationCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HotLocationCell.h"
#import "Masonry.h"

@interface HotLocationCell ()

@property (nonatomic) NSMutableArray * buttonArray;

@end

@implementation HotLocationCell

+(id)hotLocationCellWithTableView:(UITableView *)tableView{
    NSString * cellIdentifier = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:cellIdentifier];
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

-(void)setModelArray:(NSArray *)modelArray{
    [super setModelArray:modelArray];
    
    NSArray * subViews = self.subviews;
    for(UIView * view in subViews){
        [view removeFromSuperview];
    }
    
    self.buttonArray = [NSMutableArray new];
    for(int i=0;i<modelArray.count;i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectZero;
        [self.buttonArray addObject:button];
        
        [self addSubview:button];
        
        LocationModel * model = modelArray[i];
        [button setTitle:model.cityName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dealCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 100;
    }
    CGFloat width = (self.frame.size.width - 20 * 5) / 4;
    for(int i=0;i<self.buttonArray.count;i++){
        UIButton * button = self.buttonArray[i];
        UIButton * lastButton = (i == 0) ? nil : self.buttonArray[i-1];
        
        UIButton * nextButton = (i%4 == 0 && i >= 4) ? self.buttonArray[i - 4] : nil;
        if(!lastButton){
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(15);
                make.top.equalTo(self.mas_top).offset(10);
                make.width.equalTo(@(width));
                make.height.equalTo(@(30));
            }];
        }else{
            if(!nextButton){
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(lastButton.mas_right).offset(10);
                    make.top.equalTo(lastButton.mas_top);
                    make.width.equalTo(lastButton.mas_width);
                    make.height.equalTo(lastButton.mas_height);
                }];
            }else{
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(nextButton.mas_left);
                    make.top.equalTo(nextButton.mas_bottom).offset(10);
                    make.width.equalTo(nextButton.mas_width);
                    make.height.equalTo(nextButton.mas_height);
                }];
            }
        }
    }
    
    
}

-(void)dealCityButtonClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    LocationModel * model = self.modelArray[index];
    if(self.buttonClickedBlock){
        self.buttonClickedBlock(model);
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
