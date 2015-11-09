//
//  TabBarController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.tintColor = [UIColor colorWithRed:0.000 green:0.502 blue:0.251 alpha:1.000];
    
    UITabBarItem * item_01 = self.tabBar.items[0];
    item_01.selectedImage = [UIImage imageNamed:@"toolbar_L_1_"];
    UITabBarItem * item_02 = self.tabBar.items[1];
    item_02.selectedImage = [UIImage imageNamed:@"toolbar_L_2_"];
    UITabBarItem * item_03 = self.tabBar.items[2];
    item_03.selectedImage = [UIImage imageNamed:@"toolbar_L_3_"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
