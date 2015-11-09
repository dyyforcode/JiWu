//
//  NetInterface.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "NetInterface.h"

@implementation NetInterface

#pragma mark -地理位置
+(NSString *)locationServerPath{
    return @"http://m.jiwu.com/app!cityList.action?v=1.4&appKey=&deviceId=862851029616599&deviceType=IOS";
}
+(NSString *)locationCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"location.json"];
}
#pragma mark -新房
+(NSString *)freshHouseServerPath{
    return @"http://m.jiwu.com/app!buildList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=%@&plateId=%@&priceId=%@&featureId=%@&startId=%d&pageSize=10&type=0";
}
+(NSString *)freshHouseCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"freshHouse.json"];
}
#pragma mark -二手房
+(NSString *)secondHandHouseServerPath{
    return @"http://m.jiwu.com/app!oldHouseList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=%@&plateId=%@&priceId=%@&startId=1&houseType=%@";
}
+(NSString *)secondHandHouseCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"secondHandHouse.json"];
}
#pragma mark -本地均价
+(NSString *)localPriceServerPath{
    return @"http://m.jiwu.com/app!homeInfos.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@";
}
+(NSString *)localPriceCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"localPrice.json"];
}
#pragma mark -热门楼盘
+(NSString *)hotHouseServerPath{
    return @"http://m.jiwu.com/app!buildList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=0&plateId=0&priceId=0&featureId=0&startId=%ld&pageSize=10&type=0";
}
+(NSString *)hotHouseCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"hotHouse.json"];
}
#pragma mark -团购
+(NSString *)groupBuyingServerPath{
    return @"http://m.jiwu.com/app!buildList.action?v=1.4&appKey=7daf08ccfc302a08fa7a58341e8390ca&deviceId=862851029616599&cityId=%@&areaId=0&plateId=0&priceId=0&featureId=0&startId=1&pageSize=10&type=1";
}
+(NSString *)groupBuyingCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"groupBuyingHouse.json"];
}

#pragma mark -经纪人
+(NSString *)agentServerPath{
    return @"http://m.jiwu.com/app!agentList.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@&areaId=0&startId=0&pageSize=10";
}
+(NSString *)agentCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:@"agentServer.json"];
}
#pragma mark -帮我找
+(NSString *)helpMeFindServerPath{
    return @"http://m.jiwu.com/app!cityDetail.action?v=1.4&appKey=&deviceId=862851029616599&cityId=%@";
}

@end


















