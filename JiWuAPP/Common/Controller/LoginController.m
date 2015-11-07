//
//  LoginController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "LoginController.h"

#define Height 150

@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopContstraint;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textField.delegate = self;
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    //取出键盘动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //取出键盘最后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算tableView的移动距离
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(self.textField.text){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserName"];
        [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"UserName"];
        
    }
    
    return textField.resignFirstResponder;
}

- (IBAction)verificationButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)passwordButtonClicked:(UIButton *)sender {
    
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
