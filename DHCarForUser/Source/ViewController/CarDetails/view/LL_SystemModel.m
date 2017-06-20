//
//  LL_SystemModel.m
//  DHCarForSales
//
//  Created by leiyu on 16/3/30.
//  Copyright © 2016年 lucaslu. All rights reserved.
//

#import "LL_SystemModel.h"

@implementation LL_SystemModel
DEF_FACTORY(LL_SystemModel);
@end
@implementation LL_SystemModelArr
DEF_FACTORY(LL_SystemModelArr)
-(instancetype)init
{
    if (self = [super init]) {
        self.myDataArr = [NSMutableArray allocInstance];
    }
    return self;
}
-(void)parseDataDic:(NSDictionary *)str
{
    if ([str hasItemAndBack:@"result"]) {
        NSDictionary *tempDic = [str hasItemAndBack:@"result"];
        if (tempDic != nil) {
            self.myCount = [NSString fromString:[tempDic valueForKey:@"count"]];
            self.myLimit = [NSString fromString:[tempDic valueForKey:@"limit"]];
            self.myPage = [NSString fromString:[tempDic valueForKey:@"page"]];
            
            if (![tempDic valueForKey:@"data"]) {
                NSArray *datas = [tempDic valueForKey:@"data"];
                [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *tempDic = (NSDictionary *)obj;
                    LL_SystemModel *model = [[LL_SystemModel alloc]init];
                    model.myId =[NSString fromString:[tempDic hasItemAndBack:@"id"]];
                    model.myFromId = [NSString fromString:[tempDic hasItemAndBack:@"from"]];
                    model.myToId = [NSString fromString:[tempDic hasItemAndBack:@"to"]];
                    model.myType = [NSString fromString:[tempDic hasItemAndBack:@"type"]];
                    model.myTargetId = [NSString fromString:[tempDic hasItemAndBack:@"target_id"]];
                    model.myContent = [NSString fromString:[tempDic hasItemAndBack:@"content"]];
                    model.myTitle = [NSString fromString:[tempDic hasItemAndBack:@"title"]];
                    [self.myDataArr addObject:model];
                }];
            }
        }

    }
}
@end