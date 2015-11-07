//
//  HouseDetialController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HouseDetialController.h"

#import "AFNetworking.h"
#import "HouseDetialModel.h"
#import "BuildDetialCell.h"
#import "NSString+Frame.h"
#import "HouseDetialOtherBuildController.h"

#import "Masonry.h"
#import "UMSocial.h"
#import "LocationMapController.h"

#import "DataBaseManager.h"


@interface HouseDetialController ()<UIActionSheetDelegate>

@property (nonatomic) DataBaseManager * dataManager;

@property (nonatomic) HouseDetialModel * detialModel;

@property (nonatomic) BOOL isLookAll;

@end

@implementation HouseDetialController

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dataManager = [DataBaseManager shareManager];
    
    [self loadData];
}

#pragma mark －数据加载
-(void)loadData{
    [self loadDataFromServer];
}
-(void)loadDataFromServer{
    
    NSString * subServerPath = @"http://m.jiwu.com/app!buildDetail.action?v=1.4&appKey=40df803f811124f676bdea97839a87ce&deviceId=862851029616599&id=%@&type=0";
    
    self.serverPath = [NSString stringWithFormat:subServerPath,self.buildModelID];
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:self.serverPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject){
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * node = objectDictionary[@"build"];
            
            HouseDetialModel * buildDetialModel = [HouseDetialModel HouseDetialModelWithNode:node];
            self.detialModel = buildDetialModel;
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -分享
- (IBAction)shareBarItemClicked:(UIBarButtonItem *)sender {
    
    __weak typeof (self) ws = self;
    UIActionSheet * ac = [[UIActionSheet alloc] initWithTitle:@"分享"
                                                     delegate:ws
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                            otherButtonTitles:@"新浪微博",@"腾讯微博",@"微信好友",@"微信圈子",@"QQ好友",@"QQ空间",@"短信",@"邮箱",nil];
    [ac showInView:ws.view];
    
     NSString * cityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCity"][@"cityName"];
    BOOL isExcuted = [self.dataManager insertAttentionHouseInfo:self.detialModel cityName:cityName];
  //  BOOL isExcuted = [self.dataManager removeAttentionHouseInfo:@"http://img12.jiwu.com/buildpics/10/4/1274/1274550_m.jpg"];
    if(!isExcuted){
        NSLog(@"成功执行");
    }

}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击了%ld",buttonIndex);
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


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!self.detialModel){
        return 0;
    }
    
    if(section == 0){
        return 5;
    }else if(section == 1){
        return 3;
    }else if(section == 2){
        return self.detialModel.houseTypesArray.count;
    }else if(section == 3){
        return 2;
    }else if(section == 4){
        return 5;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 150;
        }else if(indexPath.row == 3){
            return [self.detialModel.address heightWithFont:[UIFont systemFontOfSize:15] withinWidth:self.tableView.frame.size.width - 16] + 30;
        }
       
    }else if(indexPath.section == 1){
        if(indexPath.row == 1){
            return self.isLookAll ? [self.detialModel.hotSaleContent heightWithFont:[UIFont systemFontOfSize:15] withinWidth:self.tableView.frame.size.width - 16] : 60;
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            return 30;
        }
        return 100;
    }else if (indexPath.section == 3){
        if(indexPath.row == 1){
            return 170;
        }
    }else if(indexPath.section == 4){
        if(indexPath.row == 1){
            NSArray * array = [self.detialModel.label componentsSeparatedByString:@","];
            CGFloat totalWidth = 0;
            for(int i=0;i<array.count;i++){
                CGFloat width = [array[i] widthWithFont:[UIFont systemFontOfSize:13]] + 8;
                totalWidth += width;
            }
            NSInteger count = totalWidth / (self.tableView.frame.size.width )  * 20;
           
            
            return count + 26;
        }
    }
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!self.detialModel){
        return nil;
    }
    BuildDetialCell *cell = nil;
    
    if(indexPath.section == 0){
       
        if(indexPath.row == 0){
            BuildImageDetialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BuildImageDetialCell"];
            
           
            cell.detialModel = self.detialModel;
            return cell;
        }else if(indexPath.row == 1){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildPriceDetialCell"];
            cell.detialModel = self.detialModel;
            return cell;
        }else if(indexPath.row == 2){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildOpenTimeDetialCell"];
            cell.detialModel = self.detialModel;
            return cell;
           
        }else if(indexPath.row == 3){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildAddressDetialCell"];
            cell.detialModel = self.detialModel;
            return cell;
        }else if(indexPath.row == 4){
            
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildPhoneDetialCell"];
  //提示框确认拨打电话
            [cell setBuildPhoneClickedBlock:^(NSString * phoneNumber) {
                
                
                NSString * alertString = [NSString stringWithFormat:@"是否拨打电话呢：%@",phoneNumber];
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:   alertString preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    NSString * phoneNumberString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
                }]];
                
                
                
                [self presentViewController:alertController animated:YES completion:nil];
                
                
            }];
            
            [cell setBuildNotificationClickedBlock:^(NSString * phoneNumber) {
                NSString * alertString = [NSString stringWithFormat:@"降价后通知您：%@",phoneNumber];
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"降价通知" message:alertString preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    NSString * phoneNumberString = [NSString stringWithFormat:@"tel://%@",phoneNumber];
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumberString]];
                }]];
                
                
                
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        }
        cell.detialModel = self.detialModel;
        return cell;
    }else if(indexPath.section == 1){
       
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
            if(!cell){
                cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
            }
            cell.textLabel.text = @"最新动态";
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildHouseMoveDetialCell"];
            if(!cell){
                cell = [[BuildHouseMoveDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildHouseMoveDetialCell"];
            }
            cell.detialModel = self.detialModel;
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
            if(!cell){
                cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
            }
            cell.textLabel.text = @"查看全文";
        }
        return cell;
    }else if(indexPath.section == 2){
       
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
            if(!cell){
                cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
            }
            cell.textLabel.text = @"户型图";
            return cell;
        }
        else{
            
        cell = [tableView dequeueReusableCellWithIdentifier:@"BuildHouseTypeDetialCell"];
        HouseDetialHouseTypeModel * houseHouseTypeModel = self.detialModel.houseTypesArray[indexPath.row];
        cell.houseTypeModel = houseHouseTypeModel;
            return cell;
        }
    }else if(indexPath.section == 3){
       
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
            if(!cell){
                cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
            }
            cell.textLabel.text = @"位置";
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildMapLocationDetialCell"];
            if(!cell){
                cell = [[BuildHouseLocationMapDetial alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildMapLocationDetialCell"];
            }
            cell.detialModel = self.detialModel;
        }
        return cell;
    }else if(indexPath.section == 4){
        
        if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"BuildHouseFeatureDetialCell"];
            if(!cell){
                cell = [[BuildHouseFeatureDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildHouseFeatureDetialCell"];
            }
            cell.detialModel = self.detialModel;
            
            return cell;
        }
        cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
        if(!cell){
            cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
        }
        cell.textLabel.text = @"户型图";
        return cell;
    }else if (indexPath.section == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"BuildDetialCell"];
        if(!cell){
            cell = [[BuildDetialCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BuildDetialCell"];
        }
        cell.textLabel.text = @"意向新盘";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1 && indexPath.row == 2){
        self.isLookAll = !self.isLookAll;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(indexPath.section == 3 && indexPath.row == 1){
        [self performSegueWithIdentifier:@"ShowLocationMap" sender:nil];
        
    }else if(indexPath.section == 5){
        
        [self performSegueWithIdentifier:@"ShowBuildOtherHouse" sender:nil];
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"ShowBuildOtherHouse"]){
        HouseDetialOtherBuildController * otherHouseController = segue.destinationViewController;
        otherHouseController.bid = self.detialModel.ID;
    }else if([segue.identifier isEqualToString:@"ShowLocationMap"]){
        LocationMapController * locationMapController = segue.destinationViewController;
        locationMapController.latitude = self.detialModel.latitude;
        locationMapController.longitude = self.detialModel.longitude;
        locationMapController.name = self.detialModel.name;
    }
}


@end
