//
//  GroupBuyingDetialController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "GroupBuyingDetialController.h"

#import "NSString+Frame.h"
#import "GroupBuyingDetialCell.h"
#import "GroupBuyingDetialModel.h"
#import "AFNetworking.h"
#import "HouseDetialController.h"
#import "LocationMapController.h"

#import "UMSocial.h"

@interface GroupBuyingDetialController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarView;


@property (nonatomic) GroupBuyingDetialModel * detialModel;

@end

@implementation GroupBuyingDetialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self loadData];
}
#pragma mark -分享
- (IBAction)shareBarButtonClicked:(UIBarButtonItem *)sender {
    __weak typeof (self) ws = self;
    UIActionSheet * ac = [[UIActionSheet alloc] initWithTitle:@"分享"
                                                     delegate:ws
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"新浪微博",@"腾讯微博",@"微信好友",@"微信圈子",@"QQ好友",@"QQ空间",@"短信",@"邮箱",nil];
    [ac showInView:ws.view];
    
    
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if(buttonIndex < 8){
        //
        NSArray *sharePlatforms = @[UMShareToSina,
                                    UMShareToTencent,
                                    UMShareToWechatSession,
                                    UMShareToWechatTimeline,
                                    UMShareToQQ,
                                    UMShareToQzone,
                                    UMShareToSms,
                                    UMShareToEmail];
        
        
        //0~5 每种分享形式
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        
        [UMSocialSnsPlatformManager getSocialPlatformWithName:sharePlatforms[buttonIndex]].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
        
    }
}

#pragma mark -参加团购
- (IBAction)joinGroupBuyingButtonClicked:(UIBarButtonItem *)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"参加团购" message:@"报名后我们将与您联系" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        
    }]];

    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark -数据加载
-(void)loadData{
    [self loadDataFromServe];
}
-(void)loadDataFromServe{
    
    NSString * path = @"http://m.jiwu.com/app!gropuonDetail.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&id=%@&type=0";
    NSString * servePath = [NSString stringWithFormat:path,self.groupID];
    
   
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:servePath parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if(responseObject){
            NSDictionary * objectDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            GroupBuyingDetialModel * detialModel = [GroupBuyingDetialModel groupBuyingDetialModelWithNode:objectDict[@"build"]];
            self.detialModel = detialModel;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark -配置tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(!self.detialModel){
        return 0;
    }
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!self.detialModel){
        return 0;
    }
    
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 6;
    }else if(section == 2){
        return 3;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.detialModel){
        return 0;
    }
    
    if(indexPath.section == 0){
        return 230;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            return 30;
        }else if(indexPath.row == 3 || indexPath.row == 2){
            return [self.detialModel.address heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.tableView.bounds.size.width - 134] + 20;
        }
        return 44;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            return 30;
        }else if(indexPath.row == 1){
            return 79;
        }
        return 80;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.detialModel){
        return nil;
    }
    GroupBuyingDetialCell * cell;
    
    if(indexPath.section == 0){
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingImageDetialCell"];
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
            if(!cell){
                cell = [[GroupBuyingDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonCell"];
            }
            cell.textLabel.text = @"楼盘信息";
            return cell;
        }else if(indexPath.row == 1){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingPriceDetialCell"];
        }else if(indexPath.row < 5 && indexPath.row > 1){
            NSArray * titleArray = @[@"开盘时间",@"楼盘地址",@"咨询电话"];
            NSArray * accstyleArray = @[@(UITableViewCellAccessoryNone),@(UITableViewCellAccessoryDisclosureIndicator),@(UITableViewCellAccessoryDisclosureIndicator)];
            NSArray * contentArray = @[self.detialModel.openTime,self.detialModel.address,self.detialModel.salePhone];
            cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingInfoDetialCell"];
            cell.titleString = titleArray[indexPath.row - 2];
            cell.contentString = contentArray[indexPath.row - 2];
            cell.accessoryType = [accstyleArray[indexPath.row - 2] integerValue];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
            if(!cell){
                cell = [[GroupBuyingDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonCell"];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"查看%@更多信息",self.detialModel.name];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
            if(!cell){
                cell = [[GroupBuyingDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonCell"];
            }
            cell.textLabel.text = @"参团流程";
            return cell;
        }else if(indexPath.row == 1){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingGroupFlowDetialCell"];
        }else if(indexPath.row == 2){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"GroupBuyingUsingInfoDetialCell"];
        }
    }
    cell.detialModel = self.detialModel;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 5){
            [self performSegueWithIdentifier:@"ShowHouseDetial" sender:nil];
        }else if(indexPath.row == 3){
            [self performSegueWithIdentifier:@"ShowLocationMap" sender:nil];
        }else if(indexPath.row == 4){
            [self callPhoneNumber];
        }
    }
}
-(void)callPhoneNumber{
    NSString * messageString = [NSString stringWithFormat:@"是否拨打电话:%@",self.detialModel.salePhone];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:messageString preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSString * phoneURL = [NSString stringWithFormat:@"tel://%@",self.detialModel.salePhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneURL]];
        
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"ShowHouseDetial"]){
        
        
        HouseDetialController * buildDetialController = segue.destinationViewController;
        buildDetialController.buildModelID = self.detialModel.ID;
    }else if([segue.identifier isEqualToString:@"ShowLocationMap"]){
        LocationMapController * locationMapController = segue.destinationViewController;
        locationMapController.latitude = self.detialModel.latitude;
        locationMapController.longitude = self.detialModel.longitude;
        locationMapController.name = self.detialModel.name;
    }
}


@end
