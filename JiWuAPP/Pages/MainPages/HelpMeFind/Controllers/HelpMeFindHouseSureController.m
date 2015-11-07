//
//  HelpMeFindHouseSureController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HelpMeFindHouseSureController.h"
#import "HelpMeFindSureCell.h"
#import "NSString+Frame.h"

@interface HelpMeFindHouseSureController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@property (nonatomic,copy) NSString * segmentedTitle;

@end

@implementation HelpMeFindHouseSureController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
    
    self.tableViewHeight.constant = 5 * 44 + 64;
    
    self.segmentedTitle = [self.segmentedControl titleForSegmentAtIndex:0];
    
    self.nameTextField.delegate = self;
}
- (IBAction)sexValueChanged:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    
    self.segmentedTitle = [sender titleForSegmentAtIndex:index];
    
    if(![self.nameTextField.text isEqualToString:@""]){
        self.nameLabel.text = [NSString stringWithFormat:@"我是 %@%@",self.nameTextField.text,self.segmentedTitle];
    }else{
        self.nameLabel.text = @"";
    }
    
}
- (IBAction)makeSureButtonClicked:(UIButton *)sender {
    
    NSString * messageTitle = [NSString stringWithFormat:@"是否确定发送？(确定后经纪人为您找到合适的房子后会及时通知您,%@%@)",self.nameTextField.text,self.segmentedTitle];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:messageTitle preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
#pragma mark -实现UITextField代理协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(![self.nameTextField.text isEqualToString:@""]){
        self.nameLabel.text = [NSString stringWithFormat:@"我是 %@%@",self.nameTextField.text,self.segmentedTitle];
    }else{
        self.nameLabel.text = @"";
    }
    self.tableViewTopContraint.constant = 0;
    return self.nameTextField.resignFirstResponder;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.tableViewTopContraint.constant = -64;
    return YES;
}

#pragma mark -设置tableView   
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpMeFindSureCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HelpMeFindSureCell"];
    cell.index = indexPath.row;
    
    return cell;

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
