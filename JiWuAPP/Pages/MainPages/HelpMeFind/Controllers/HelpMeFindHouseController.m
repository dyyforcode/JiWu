//
//  HelpMeFindHouseController.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HelpMeFindHouseController.h"

#import "HelpMeFindHouseCell.h"
#import "HelpMeFindChooseController.h"

@interface HelpMeFindHouseController ()

@property (nonatomic,copy) NSString * alertString;


@end

@implementation HelpMeFindHouseController

#pragma mark -页面加载前预设置
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView reloadData];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -配置Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == 2){
        return 1;
    }
    
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            return 25;
        }else if(indexPath.row == 1){
            return 80;
        }else if(indexPath.row == 2){
            return 44;
        }
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelpMeFindHouseCell * cell;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"HelpMeFindCommonCell"];
        cell.index = indexPath.row;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"CommonCell"];
            if(!cell){
                cell = [[HelpMeFindHouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommonCell"];
            }
            cell.textLabel.text = @"补充信息（多选项）";
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"HelpMeFindFeatureCell"];
            
            
            [cell setHelpMeFindHouseBlock:^(NSArray * buttonArray) {
                NSMutableString * mutableString = [NSMutableString string];
                for(int i=0;i<buttonArray.count;i++){
                    UIButton * button = buttonArray[i];
                    [mutableString appendString:button.titleLabel.text];
                    if(buttonArray.count > 1 && i < buttonArray.count - 1){
                        [mutableString appendString:@" , "];
                    }
                   
                }
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HelpMeFindFeature"];
                [[NSUserDefaults standardUserDefaults] setObject:mutableString forKey:@"HelpMeFindFeature"];
                
               
            }];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:@"HelpMeFindMoreCell"];
        }
        
    }else if(indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"HelpMeFindSendToCell"];
        
        [cell setHelpMeFindSendBlock:^{
            
            NSString * priceString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindPrice"];
            NSString * houseTypeString = [[NSUserDefaults standardUserDefaults] objectForKey:@"HelpMeFindHouseType"];
            
            if(!priceString){
                self.alertString = @"请选择价格";
                [self alertDealMethod];
            }else{
                if(!houseTypeString){
                    self.alertString = @"请选择户型";
                     [self alertDealMethod];
                }else{
                    [self performSegueWithIdentifier:@"ShowHelpMeFindHouseSure" sender:nil];
                }
            }
            
            
        }];
    }
    
    return cell;
}

-(void)alertDealMethod{
   
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:self.alertString preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        
    }]];
    
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        
            HelpMeFindChooseController * chooseController = [[HelpMeFindChooseController alloc] init];
            chooseController.index = indexPath.row;
            [self.navigationController pushViewController:chooseController animated:YES];
       
        

       
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
    
    if([segue.identifier isEqualToString:@"ShowHelpMeFindHouseSure"]){
        
    }
}


@end
