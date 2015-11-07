//
//  MessageChatController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/2.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MessageChatController.h"

#import "MessageModel.h"
#import "MessageFrame.h"
#import "ChatCell.h"

@interface MessageChatController () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomContraint;


@property (nonatomic) NSMutableArray * messageFrameArray;
@property (nonatomic) NSDictionary * autoreplyDict;

@end

@implementation MessageChatController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0  blue:235/255.0  alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.textField.delegate = self;
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
   
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//发送消息
-(void)addMessage:(NSString *)text type:(JWMessageType)type{
    //设置数据模型
    MessageModel * message = [[MessageModel alloc] init];
    message.messageType = type;
    message.contentText = text;
    //设置时间
    NSDate * now = [NSDate date];
    NSDateFormatter * dateFormater = [[NSDateFormatter alloc] init];
    dateFormater.dateFormat = @"HH:mm";
    message.sendTime = [dateFormater stringFromDate:now];
    
    //看是否需要隐藏时间
    MessageFrame * lastMessageFrame = [self.messageFrameArray lastObject];
    MessageModel * lastMessage = lastMessageFrame.message;
    message.isHideTime = [message.sendTime isEqualToString:lastMessage.sendTime];
    
    //frame模型
    MessageFrame * messageFrame = [[MessageFrame alloc] init];
    messageFrame.message = message;
    [self.messageFrameArray addObject:messageFrame];
    
    //刷新tableView
    [self.tableView reloadData];
    
    //自动滚动到tableView的最后
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.messageFrameArray.count - 1 inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}

-(NSString *)replyWithText:(NSString *)text{
    return @"XX";
}

- (IBAction)smileButtonClicked:(UIButton *)sender {
    
}
- (IBAction)addOtherButtonClicked:(UIButton *)sender {
    
}
- (IBAction)soundButtonClicked:(UIButton *)sender {
    
}
#pragma mark -实现textField代理协议
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //自己发送一条消息
    [self addMessage:self.textField.text type:JWMessageTypeMe];
    //自动回复一条消息
    NSString * replyMessage = [self replyWithText:self.textField.text];
    [self addMessage:replyMessage type:JWMessageTypeOther];
    
    self.textField.text = nil;
    
    return textField.resignFirstResponder;
}
#pragma mark -键盘弹出与弹进事件
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    //设置窗口颜色
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //取出键盘动画时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //取出键盘最后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算tableView的移动距离
    CGFloat transformY = self.view.frame.size.height - keyboardFrame.origin.y;
    
    [UIView animateWithDuration:duration animations:^{
        //自动滚动到tableView的最后
       
        self.toolBottomConstraint.constant = transformY;
        
    }];
    NSLog(@"float : %f  %f",transformY,self.toolBottomConstraint.constant);
}
#pragma mark -设置autoreplyDict
- (NSDictionary *)autoreplyDict
{
    if (_autoreplyDict == nil) {
        _autoreplyDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreplyDict;
}
#pragma mark -设置messageFrameArray
-(NSMutableArray *)messageFrameArray{
    if(!_messageFrameArray){
        NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        NSMutableArray * mfArray = [NSMutableArray array];
        
        for(NSDictionary * dict in dictArray){
            MessageModel * message = [MessageModel messageModelWithNode:dict];
            
            MessageFrame * lastMessageFrame = [mfArray lastObject];
            MessageModel * lastMessage = lastMessageFrame.message;
            
            //判断两个消息的发送时间是否一致
            message.isHideTime = [message.sendTime isEqualToString:lastMessage.sendTime];
            
            MessageFrame * messageFrame = [[MessageFrame alloc] init];
            messageFrame.message = message;
            
            [mfArray addObject:messageFrame];
            
           
        }
        _messageFrameArray = mfArray;
    }
    return _messageFrameArray;
}

#pragma mark -实现tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrameArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageFrame * messageFrame = self.messageFrameArray[indexPath.row];
    return messageFrame.cellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell * chatCell = [ChatCell chatCellWithTableView:self.tableView];
    chatCell.messageFrame = self.messageFrameArray[indexPath.row];
    return chatCell;
}

#pragma mark -滑动界面时调用改方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
