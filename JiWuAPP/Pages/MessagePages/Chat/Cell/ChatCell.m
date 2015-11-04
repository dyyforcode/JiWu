//
//  ChatCell.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "ChatCell.h"

#import "MessageFrame.h"
#import "MessageModel.h"
#import "UIImage+Extension.h"

@interface ChatCell ()

/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeView;
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  正文
 */
@property (nonatomic, weak) UIButton *textView;

@end

@implementation ChatCell

+(instancetype)chatCellWithTableView:(UITableView *)tableView{
     NSString * cellIdentity = NSStringFromClass(self);
    
    ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(!cell){
        cell = [[ChatCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        //时间
        UILabel * timeLabel = [[UILabel alloc] init];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:timeLabel];
        self.timeView = timeLabel;
        
        //头像
        UIImageView * iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        //正文
        UIButton * textButton = [[UIButton alloc] init];
        textButton.titleLabel.numberOfLines = 0;
        textButton.titleLabel.font = JWTextFont;
        textButton.contentEdgeInsets = UIEdgeInsetsMake(JWTextPadding, JWTextPadding, JWTextPadding, JWTextPadding);
        [textButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textButton];
        self.textView = textButton;
        
        //设置cell 的背景颜色
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

//设置messageframe
-(void)setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    
    MessageModel * message = messageFrame.message;
    
    //时间
    self.timeView.text = message.sendTime;
    self.timeView.frame = messageFrame.timeFrame;
    
    //头像
    NSString * iconName = (message.messageType == JWMessageTypeMe) ? @"me" : @"other";
    self.iconView.image = [UIImage imageNamed:iconName];
    self.iconView.frame = messageFrame.iconFrame;
    
    //正文
    [self.textView setTitle:message.contentText forState:UIControlStateNormal];
    self.textView.frame = messageFrame.textFrame;
    
    //正文背景
    if(message.messageType == JWMessageTypeMe){
        [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
    }else{
       [self.textView setBackgroundImage:[UIImage resizableImage:@"chat_recive_nor"] forState:UIControlStateNormal];
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
