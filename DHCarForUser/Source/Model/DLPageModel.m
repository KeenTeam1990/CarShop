//
//  DLPageModel.m
//  Auction
//
//  Created by 卢迎志 on 15-3-2.
//
//

#import "DLPageModel.h"

@implementation DLPageModel

DEF_FACTORY(DLPageModel);

-(id)init
{
    self = [super init];
    if(self){
        self.count = @"0";
        self.limit  = @"10";
        self.nextMax = @"";
        self.hasMore = NO;
        self.lastMax = @"";
    }
    return self;
}

-(void)toData:(DLPageModel*)data
{
    self.count = data.count;
    self.limit = data.limit;
    self.nextMax = data.nextMax;
    self.hasMore = data.hasMore;
    self.lastMax = data.lastMax;
}

+(id)copyClone:(DLPageModel*)model
{
    DLPageModel* tempModel = [DLPageModel allocInstance];
    tempModel.count = model.count;
    tempModel.limit = model.limit;
    tempModel.nextMax = model.nextMax;
    tempModel.hasMore = model.hasMore;
    tempModel.lastMax = model.lastMax;
    return tempModel;
}

@end
