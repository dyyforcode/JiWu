//
//  HouseDetialOtherBuildController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/27.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HouseDetialOtherBuildController.h"

#import "AFNetworking.h"
#import "MainHouseModel.h"
#import "FreshHouseCell.h"
#import "HouseDetialController.h"

@interface HouseDetialOtherBuildController ()

@property (nonatomic) NSArray * dataArray;

@end

@implementation HouseDetialOtherBuildController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    
    
    [self loadData];
}

-(void)loadData{
    [self loadDataFromServe];
}
-(void)loadDataFromServe{
    NSMutableArray * dataArray = [NSMutableArray new];
    
    
    NSString * path = @"http://m.jiwu.com/app!interestList.action?v=1.4&appKey=40df803f811124f676bdea97839a87ce&deviceId=862851029616599&bid=%@&startId=1&pageSize=5";
    NSString * servePath = [NSString stringWithFormat:path,self.bid];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:servePath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject){
            NSDictionary * objectDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * objectArray = objectDictionary[@"buildArray"];
            for(NSDictionary * node in objectArray){
                MainHouseModel * houseModel = [MainHouseModel mainHouseModelWithDictionary:node];
                [dataArray addObject:houseModel];
            }
            self.dataArray = dataArray;
            [self.tableView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.dataArray.count < 1){
        return nil;
    }
    
    MainHouseModel * houseModel = self.dataArray[indexPath.row];
    
    FreshHouseCell * houseCell = [tableView dequeueReusableCellWithIdentifier:@"FreshHouseCell"];
    houseCell.houseModel = houseModel;
    
    return houseCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"ShowHouseDetial" sender:@{@"indexPath":indexPath}];
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
    
    if([segue.identifier isEqualToString:@"ShowHouseDetial"]){
        NSIndexPath * indexPath = sender[@"indexPath"];
        MainHouseModel * buildModel = self.dataArray[indexPath.section][indexPath.row-1];
        HouseDetialController * buildDetialController = segue.destinationViewController;
        buildDetialController.buildModelID = buildModel.ID;
    }

}


@end
