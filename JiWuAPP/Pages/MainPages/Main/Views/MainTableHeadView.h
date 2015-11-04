//
//  MainTableHeadView.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainTableHeadViewDelegate <NSObject>

-(void)dealTingsWhenButtonClicked:(NSInteger) index serverPath:(NSString *)serverPath cachePath:(NSString *)cachepath;

@end

@interface MainTableHeadView : UIView

@property (nonatomic,strong) void(^mainTableHeadViewBlock)(BOOL isClicked);

@property (nonatomic,weak) id<MainTableHeadViewDelegate> delegate;

+(id)mainTableHeadView;

@end
