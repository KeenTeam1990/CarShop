//
//  TTReqEngine.m
//  TickTock
//
//  Created by 卢迎志 on 14-12-4.
//  Copyright (c) 2014年 卢迎志. All rights reserved.
//

#import "TTReqEngine.h"
#import "TTReqProtocol.h"
#import "TTReqUrl.h"
#import "DH_ADModel.h"
#import "M_CarListModel.h"
#import "M_BannerItemModel.h"
#import "M_DealerListModel.h"
#import "M_IndexModel.h"
#import "M_CityListModel.h"
#import "Dh_LoginModel.h"

#import "Dh_MyCollectModel.h"
#import "M_IntegralModel.h"
#import "M_TestDriverModel.h"
#import "M_MyOrderModel.h"
#import "M_IntegralModel.h"
#import "LL_SystemModel.h"

#import "M_BrandListModel.h"
#import "M_CarYearListModel.h"
#import "M_CarTypeListModel.h"
#import "M_CarPriceListModel.h"
#import "M_CarPersonListModel.h"
#import "M_SubBrandListModel.h"
#import "M_OrderAddModel.h"
#import "M_CommpanyListModel.h"
#import "M_CarInsuranceListModel.h"
#import "M_CarRemoteListModel.h"
#import "M_CarGasListModel.h"
#import "M_QueryModelsModel.h"
#import "M_CarMessageDetailModel.h"

#import "M_MymessageListModel.h"
#import "M_MyOrdelListModel.h"
#import "M_ConfigDataModel.h"
#import "M_SeriesListModel.h"

#import "M_SpikeListModel.h"
#import "M_SpikeRushModel.h"
#import "Dh_TitleModel.h"
#import "Dh_ChangePasswordModel.h"
#import "JPUSHService.h"
#define KERROR_CLEW @"联网失败，请重试"
#define KWAIT_STATUS @"请稍候..."
#import "LL_GetScanUrlModel.h"
@implementation TTReqEngine

#pragma mark  -  用户接口

//获取普通用户

+(void)C_GetUser_GetSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqUser_GetUrl]
           withParameters:[TTReqProtocol C_GetUser_GetSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_UserInfoModel* tempModel = [[M_UserInfoModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             
             NSString* tempPath = [NSString stringWithFormat:@"%@%@",[DLCache libCachesToTemp],@"info"];
             
             [DLCache writeString:tempModel.httpBackData toDocumentPath:tempPath];
             
             if ([tempModel.user_id notEmpty]) {
                 [DLAppData sharedInstance].myUserKey = tempModel.user_id;
                 [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
                 [JPUSHService setAlias:tempModel.user_id callbackSelector:nil object:nil];
             }
             
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}

//登录
+(void)C_PostUser_LoginPhone:(NSString*)phone
                    withCode:(NSString *)code
                   withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqUser_LoginUrl]
            withParameters:[TTReqProtocol C_PostUserLoginPhone:phone withCode:code]
                   success:^(id responseObject) {
    
        [SVProgressHUD dismiss];
        
        M_UserInfoModel* tempModel = [M_UserInfoModel allocInstance];
        [tempModel parseData:responseObject];
        
        if (tempModel.run_number == 0) {
            
            if ([tempModel.user_id notEmpty]) {
                [DLAppData sharedInstance].myUserKey = tempModel.user_id;
                [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
                [JPUSHService setAlias:tempModel.user_id callbackSelector:nil object:nil];
            }
            
            if (block!=nil) {
                block(YES,tempModel);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
            if (block!=nil) {
                block(NO,nil);
            }
        }
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismissWithError:KERROR_CLEW];
        if (block!=nil) {
            block(NO,nil);
        }
    }];
}


//密码方式登录
+(void)C_PostUser_LoginPhone:(NSString *)phone withPassword:(NSString *)password
                   withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_reqUser_LoginPasswordUrl]
            withParameters:[TTReqProtocol C_PostUserLoginPasswordPhone:phone withPassword:password]
                   success:^(id responseObject) {
                       
                       [SVProgressHUD dismiss];

                       M_UserInfoModel* tempModel = [M_UserInfoModel allocInstance];
                       [tempModel parseData:responseObject];
                       
                       if (tempModel.run_number == 0) {
                           
                           if ([tempModel.user_id notEmpty]) {
                               [DLAppData sharedInstance].myUserKey = tempModel.user_id;
                               [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
                               [JPUSHService setAlias:tempModel.user_id callbackSelector:nil object:nil];
                           }
                           
                           if (block!=nil) {
                               block(YES,tempModel);
                           }
                       }else{
                           [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                           if (block!=nil) {
                               block(NO,nil);
                           }
                       }
                       
                   } failure:^(NSString *error) {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil) {
                           block(NO,nil);
                       }
                   }];

}
/**
 *  用户注册
 *
 *  @param phone    手机号
 *  @param code     验证码
 *  @param password 密码
 */
+(void)C_PostUser_RegisterPhone:(NSString *)phone andWithCode:(NSString *)code andWithPassword:(NSString *)password withBlock:(TTBaseModelBlock)block;
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_reqUser_RegisterUrl]
            withParameters:[TTReqProtocol C_PostUserRegister:phone withPassword:password withCode:code]
                   success:^(id responseObject) {
                       
                       [SVProgressHUD dismiss];
                       
                       M_UserInfoModel* tempModel = [M_UserInfoModel allocInstance];
                       [tempModel parseData:responseObject];
                       
                       if (tempModel.run_number == 0) {
                           
                           if ([tempModel.user_id notEmpty]) {
                               [DLAppData sharedInstance].myUserKey = tempModel.user_id;
                               [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
                               [JPUSHService setAlias:tempModel.user_id callbackSelector:nil object:nil];
                           }
                           
                           if (block!=nil) {
                               block(YES,tempModel);
                           }
                       }else{
                           [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                           if (block!=nil) {
                               block(NO,nil);
                           }
                       }
                       
                   } failure:^(NSString *error) {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil) {
                           block(NO,nil);
                       }
                   }];

}
/**
 *  普通用户修改密码
 *
 *  @param password 用户新密码
 *  @param uid      用户id
 */
+(void)C_PostUser_SetPassword:(NSString *)password andWith:(NSString *)uid withBlock:(TTBaseModelBlock)block;
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_reqUser_SetPasswordUrl ]
            withParameters:[TTReqProtocol C_PostUserSetPassword:password andWithUserId:uid]
                   success:^(id responseObject) {
                       
                       [SVProgressHUD dismiss];
                       M_UserInfoModel* tempModel = [[M_UserInfoModel alloc] init];
                       if (tempModel.run_number == 0) {
                                              [tempModel parseData:responseObject];
                                                  if (block!=nil) {
                                                      block(YES,tempModel);
                                                  }
                                              }else{
                                                  [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                                                  if (block!=nil) {
                                                      block(NO,nil);
                                                  }
                                              }
                       
                   } failure:^(NSString *error) {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil) {
                           block(NO,nil);
                       }
                   }];

}
+(void)C_PostUser_ModifyPassword:(NSString *)uid andWithOldPassword:(NSString *)password andWithNewPassword:(NSString *)newPassword andWithBlock:(TTBaseModelBlock )block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_reqUser_ModifyPasswordUrl ]
            withParameters:[TTReqProtocol C_PostUserModifyPassWord:uid andWithOldPassword:password andWithNewPassword:newPassword]
                   success:^(id responseObject) {
                       
                       [SVProgressHUD dismiss];
                       
                                              M_UserInfoModel* tempModel = [[M_UserInfoModel alloc] init];
                                              [tempModel parseData:responseObject];
                       
                                              if (tempModel.run_number == 0) {
                       
                                                  if (block!=nil) {
                                                      block(YES,tempModel);
                                                  }
                                              }else{
                                                  [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                                                  if (block!=nil) {
                                                      block(NO,nil);
                                                  }
                                              }
                       
                   } failure:^(NSString *error) {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil) {
                           block(NO,nil);
                       }
                   }];

}
//获取验证码
+(void)C_GetCodeSetPhone:(NSString *)phone
                withType:(NSString *)type
               withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCode_GetphonecodeUrl]
           withParameters:[TTReqProtocol C_GetCode_SetPhone:phone
                                                   withType:type]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}
//首页信息
+(void)C_GetRecommend_App_IndexCity_id:(NSString *)city_id
                             withBlock:(TTBaseModelBlock)block
{
    
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper GetData:[TTReqUrl C_Reqrecommend_App_IndexUrl]
           withParameters:[TTReqProtocol C_Getqrecommend_App_IndexCity_id:city_id]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         M_IndexModel* tempModel = [M_IndexModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD dismiss];
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//首页banner信息
+(void)C_GetRecommend_BannerCity_id:(NSString *)city_id
                          withBlock:(TTBaseModelBlock)block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper GetData:[TTReqUrl C_Reqrecommend_BannerUrl]
           withParameters:[TTReqProtocol C_Getqrecommend_BannerCity_id:city_id]
                  success:^(id responseObject) {
//                      [SVProgressHUD dismiss];
                      M_BannerModel* tempModel = [M_BannerModel allocInstance];
                      [tempModel parseData:responseObject];
                      
                      if (tempModel.run_number == 0) {
                          if (block!=nil) {
                              block(YES,tempModel);
                          }
                      }else{
                          [SVProgressHUD dismiss];
                          [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                          if (block!=nil) {
                              block(NO,nil);
                          }
                      }
        
                } failure:^(NSString *error) {
                    [SVProgressHUD dismissWithError:KERROR_CLEW];
                    if (block!=nil) {
                        block(NO,nil);
                    }
                }];
}

//城市定位
+(void)C_GetCity_locationLng:(NSString *)lng withLat:(NSString *)lat withBlock:(TTBaseModelBlock)block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCity_locationUrl]
           withParameters:[TTReqProtocol C_GetCity_locationLng:lng withLat:lat]
                  success:^(id responseObject) {
//                      [SVProgressHUD dismiss];
                      
                      M_CityItemModel* tempModel = [M_CityItemModel allocInstance];
                      [tempModel parseData:responseObject];
                      
                      if (tempModel.run_number == 0) {
                          if (block!=nil) {
                              block(YES,tempModel);
                          }
                      }else{
                          [SVProgressHUD dismiss];
                          [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                          if (block!=nil) {
                              block(NO,nil);
                          }
                      }
                      
                  } failure:^(NSString *error) {
                      
                      [SVProgressHUD dismissWithError:KERROR_CLEW];
                      if (block!=nil) {
                          block(NO,nil);
                      }
                  }];
}

//获取城市列表
+(void)C_GetCity_listprovince_id:(NSString *)ID withStatus:(NSString *)status withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCity_ListUrl]
           withParameters:[TTReqProtocol C_GetCity_ListProvince_id:ID withStatus:status]
                  success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        M_CityList2Model* tempModel = [M_CityList2Model allocInstance];
        [tempModel parseData:responseObject];
        if (tempModel.run_number == 0) {
            if (block!=nil) {
                block(YES,tempModel);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
            if (block!=nil) {
                block(NO,nil);
            }
        }
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismissWithError:KERROR_CLEW];
        if (block!=nil) {
            block(NO,nil);
        }
    }];
}
//获取所有城市列表
+(void)C_GetCity_AllwithBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCity_AllUrl]
           withParameters:[TTReqProtocol C_GetCity_AllUrl]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_CityListModel *tempModel = [M_CityListModel allocInstance];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }

         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}


//更新用户信息
+(void)C_PostUser_UpdateSetUid:(NSString *)uid
                       withSex:(NSString *)sex
                      withNick:(NSString *)nick
                     withEmail:(NSString *)email
                  withBirthday:(NSString *)birthday
                    withAvatar:(NSString *)avatar
                   withCity_id:(NSString *)city_id
                        withQQ:(NSString *)qq
                     withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqUser_UpdateUrl]
            withParameters:[TTReqProtocol C_PostUser_UpdateSetUid:uid
                            
                                                          withSex:sex withNick:nick withEmail:email withBirthday:birthday withAvatar:avatar withCity_id:city_id withQQ:qq]                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_UserInfoModel *tempModel = [M_UserInfoModel allocInstance];
         [tempModel parseData:responseObject];
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }else
             {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}


//获取经销商

+(void)C_Getdealer_Dealer_id:(NSString *)dealer_id withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqDealer_GetUrl]
           withParameters:[TTReqProtocol C_Getdealer_Dealer_id:dealer_id]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
     }];
}

//获取经销商列表
+(void)C_GetdealerList_SetCity_id:(NSString *)city_id
                       withCar_id:(NSString *)car_id
                         withType:(NSString *)type
                  withBigbrand_id:(NSString *)bigbrand_id
                     withBrand_id:(NSString *)brand_id
                    withSeries_id:(NSString *)series_id
                       withLimitd:(NSString *)limit
                         withPage:(NSString *)page
                          withMax:(NSString *)max
                        withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqDealer_ListUrl]
           withParameters:[TTReqProtocol C_GetdealerListSetCity_id:city_id
                                                        withCar_id:car_id withType:type withBigbrand_id:bigbrand_id withBrand_id:brand_id withSeries_id:series_id withLimitd:limit withPage:page withMax:max]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         M_DealerListModel* tempModel = [M_DealerListModel allocInstance];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}

//获取经销商车型详情
+(void)C_Getcar_dealerSetCity_id:(NSString *)city_id
                                withCar_id:(NSString *)car_id
                                    withID:(NSString *)ID
                             withDealer_id:(NSString *)dealer_id
                                   withLng:(NSString *)lng
                                   withLat:(NSString *)lat
                                 withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCar_DealercarUrl]
           withParameters:[TTReqProtocol C_Getcar_dealerSetCity_id:city_id withCar_id:car_id withID:ID withDealer_id:dealer_id withLng:lng withUid:APPDELEGATE.viewController.myUserModel.user_id withLat:lat]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_CarItemModel* tempModel = [M_CarItemModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if(block!=nil){
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if(block!=nil){
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if(block!=nil){
             block(NO,nil);
         }
     }];
}

//获取经销商车型列表
+(void)C_Getcar_dealerlistSetCity_id:(NSString *)city_id
                       withDealer_id:(NSString *)dealer_id
                             withLng:(NSString *)lng
                             withLat:(NSString *)lat
                            withType:(NSString *)type
                          withLimitd:(NSString *)limit
                            withPage:(NSString *)page
                             withMax:(NSString *)max
                        withcar_Type:(NSString *)car_type
                     withPrice_range:(NSString *)price_range
                     withInstallment:(NSString *)installment
           withcar_Downpayment_range:(NSString *)downpayment_range
                     withBigbrand_id:(NSString *)bigbrand_id
                        withBrand_id:(NSString *)brand_id
                       withSeries_id:(NSString *)series_id
                           withBlock:(TTBaseModelBlock)block
{
//<<<<<<< .mine
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
//=======
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
//>>>>>>> .r2579
    
    [DLHttpHelper GetData:[TTReqUrl C_ReqCar_DealercarlistUrl]
           withParameters:[TTReqProtocol C_Getcar_dealerlistSetCity_id:city_id
                                                         withDealer_id:dealer_id
                                                               withLng:lng
                                                               withLat:lat
                                                              withType:type
                                                            withLimitd:limit
                                                              withPage:page
                                                               withMax:max
                                                          withcar_Type:car_type
                                                       withPrice_range:price_range
                                                       withInstallment:installment
                                             withcar_Downpayment_range:downpayment_range
                                                       withBigbrand_id:bigbrand_id
                                                          withBrand_id:brand_id
                                                         withSeries_id:series_id]
                  success:^(id responseObject)
     {
//<<<<<<< .mine
////         [SVProgressHUD dismiss];
//=======
//         //[SVProgressHUD dismiss];
//>>>>>>> .r2579
         
         M_CarListModel* tempModel = [M_CarListModel allocInstance];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//获取订单列表
+(void)C_GetOrderMylistSetUid:(NSString *)uid
                     withStep:(NSString *)step
                   withLimitd:(NSString *)limit
                     withPage:(NSString *)page
                      withMax:(NSString *)max
                    withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqOrderMylistUrl]
           withParameters:[TTReqProtocol C_GetOrderMylistSetUid:uid
                                                       withStep:step
                                                     withLimitd:limit
                                                       withPage:page
                                                        withMax:max]
                  success:^(id responseObject)
     {
         M_MyOrderModel* tempModel = [M_MyOrderModel allocInstance];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }

         
         //[SVProgressHUD dismiss];
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
     }];
}

//获取订单详情
+(void)C_GetOrderMylistSetID:(NSString *)ID  withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqOrderGetUrl]
           withParameters:[TTReqProtocol C_GetOrderMylistSetID:ID]
                  success:^(id responseObject)
     {
         
         [SVProgressHUD dismiss];
         
         M_MyOrderTtemModel* tempModel = [M_MyOrderTtemModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if(block!=nil){
             block(NO,nil);
         }
     }];
}

//配置项数据获取
+(void)C_GetConfig_GetType:(NSString *)type  withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqConfig_GetUrl]
           withParameters:[TTReqProtocol C_GetConfig_GetType:type]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         
         M_ConfigDataModel* tempModel = [M_ConfigDataModel allocInstance];
         tempModel.type = type;
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//app广告页面获取

+(void)C_GetConfig_AD:(NSString *)type  withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqConfig_GetUrl]
           withParameters:[TTReqProtocol C_GetConfig_GetType:type]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         
         DH_ADModel* tempModel = [[DH_ADModel alloc] init];
         [tempModel parseData:responseObject];
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             //[SVProgressHUD dismiss];
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//收藏列表
+(void)C_GetFavorite_ListSetUid:(NSString *)uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqFavorite_ListUrl]
           withParameters:[TTReqProtocol C_GetFavorite_ListSetUid:uid
                                                        withLimit:limit
                                                         withPage:page
                                                          withMax:max]
                  success:^(id responseObject)
     {
         
         M_CarListModel *model = [M_CarListModel allocInstance];
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         //[SVProgressHUD dismiss];
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];

}

//收藏
+(void)C_PostFavorite_AddSetUid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData: [TTReqUrl C_ReqFavorite_AddUrl]
           withParameters:[TTReqProtocol C_PostFavorite_AddSetUid:uid withCar_id:car_id withCity_id:city_id]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,nil);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}


//取消收藏
+(void)C_PostFavorite_DelSetID:(NSString *)ID Uid:(NSString *)uid withCar_id:(NSString *)car_id withCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqFavorite_DelUrl]
           withParameters:[TTReqProtocol C_PostFavorite_DelSetID:ID
                                                         withUid:uid
                                                      withCar_id:car_id
                                                     withCity_id:city_id ]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,nil);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//浏览过的记录列表

+(void)C_GetView_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqView_ListUrl]
           withParameters:[TTReqProtocol C_GetView_ListSetUid:uid
                                                    withLimit:limit
                                                     withPage:page
                                                      withMax:max]
                  success:^(id responseObject)
     {
         
         M_CarListModel *model = [M_CarListModel allocInstance];
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         

         
//         [SVProgressHUD dismiss];
     } failure:^(NSString *error) {
         
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
         
     }];
}

//删除浏览记录

+(void)C_PostView_ListDelSetID:(NSString *)ID withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqView_ListDelUrl]
           withParameters:[TTReqProtocol C_PostView_ListDelSetID:ID]
                  success:^(id responseObject)
     {
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }

         
         [SVProgressHUD dismiss];
     } failure:^(NSString *error) {
         
         if (block!=nil) {
             block(NO,nil);
         }

         [SVProgressHUD dismissWithError:KERROR_CLEW];
     }];
}


//获取车系列表
+(void)C_GetSeries_ListSetBigbrand_id:(NSString *)bigbrand_id withStatus:(NSString *)status withBlock:(TTBaseModelBlock)block
{
//<<<<<<< .mine
////    [SVProgressHUD showWithStatus:KWAIT_STATUS];
//=======
//    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
//>>>>>>> .r2579
    [DLHttpHelper GetData:[TTReqUrl C_ReqSeries_ListUrl]
           withParameters:[TTReqProtocol C_GetSeries_ListSetBigbrand_id:bigbrand_id withStatus:status]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         
         M_SeriesListModel* tempModel = [M_SeriesListModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}


//询价单列表
+(void)C_GetInquiry_ListSetUid:(NSString *) uid withLimit:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withBlock:(TTBaseModelBlock)block
{
    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper GetData:[TTReqUrl C_ReqInquiry_ListUrl]
           withParameters:[TTReqProtocol C_GetInquiry_ListSetUid:uid withLimit:limit withPage:page withMax:max]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         
         M_MyOrderModel* tempModel = [M_MyOrderModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}



//获取消息列表
+(void)C_GetIm_ListSetUid:(NSString *) uid withTarget_uid:(NSString *)target_uid withInquiry_quoted_id:(NSString *)inquiry_quoted_id withLimit:(NSString *)limit withMin:(NSString *)min withMax:(NSString *)max withBlock:(TTBaseModelBlock)block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqIm_ListUrl]
           withParameters:[TTReqProtocol C_GetIm_ListSetUid:uid
                                             withTarget_uid:target_uid
                                      withInquiry_quoted_id:inquiry_quoted_id
                                                  withLimit:limit
                                                    withMin:min
                                                    withMax:max]
                  success:^(id responseObject)
     {
         //[SVProgressHUD dismiss];
         
         M_CarMessageDetailModel* tempModel = [M_CarMessageDetailModel allocInstance];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}
/**
 *  获取系统消息列表
 *
 *  @param uid   用户id
 *  @param limit 获取条数
 *  @param page  分页页数
 *  @param max   下拉分页最大排序号
 */
+(void)C_PostUser_GetSystemImList:(NSString *)uid andWithLimit:(NSString *)limit andWithpage:(NSString *)page andWithMax:(NSString *)max andWithBlock:(TTBaseModelBlock )block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqIm_SystemUrl ] withParameters:[TTReqProtocol C_GetSystemIM_ListSetUid:uid andWithLimit:limit andWithPage:page andWithMax:max] success:^(id responseObject) {
//        [SVProgressHUD dismiss];
        LL_SystemModelArr * tempModel = [[LL_SystemModelArr alloc]init];;
                               [tempModel parseData:responseObject];
        
                               if (tempModel.run_number == 0) {
        
                                   if (block!=nil) {
                                       block(YES,tempModel);
                                   }
                               }else{
                                   [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                                   if (block!=nil) {
                                       block(NO,nil);
                                   }
                               }
        
    } failure:^(NSString *error) {
        [SVProgressHUD dismissWithError:KERROR_CLEW];
        if (block!=nil) {
            block(NO,nil);
        }
    }];

}
//发送消息
+(void)C_PostIm_SendSetfrom:(NSString *) from
                     withTo:(NSString *)to
      withInquiry_quoted_id:(NSString *)inquiry_quoted_id
                withContent:(NSString *)content
                   withType:(NSString *)type
                  withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqIm_SendUrl]
            withParameters:[TTReqProtocol C_PostIm_SendSetfrom:from
                                                        withTo:to
                                         withInquiry_quoted_id:inquiry_quoted_id
                                                   withContent:content
                                                      withType:type]
                   success:^(id responseObject) {
                       [SVProgressHUD dismiss];
                       
                       DLBaseModel* tempData = [[DLBaseModel alloc]init] ;
                       [tempData parseData:responseObject];

                       if (tempData.run_number == 0) {
                           if (block!=nil) {
                               block(YES,tempData);
                           }
                       }else{
                           [SVProgressHUD showErrorWithStatus:tempData.run_mess];
                           if (block!=nil) {
                               block(NO,nil);
                           }
                       }
                   }
                   failure:^(NSString *error) {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil) {
                           block(NO,nil);
                       }
                   }];

}

//获取消息组列表
+(void)C_GetIm_GrouplistSetUid:(NSString *) uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqIm_GrouplistUrl]
           withParameters:[TTReqProtocol C_GetIm_GrouplistSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
          M_MyMessageModel* tempModel = [M_MyMessageModel allocInstance];
 
          [tempModel parseData:responseObject];
 
          if (tempModel.run_number == 0) {
              if (block!=nil) {
                  block(YES,tempModel);
              }
          }else{
              [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
              if (block!=nil) {
                  block(NO,nil);
              }
          }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//获取试乘试驾列表
+(void)C_GetTrydriving_ListSetUid:(NSString *) uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqTrydriving_List]
           withParameters:[TTReqProtocol C_GetTrydriving_ListSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
                  M_TestDriverModel* tempModel = [M_TestDriverModel allocInstance];
         
                  [tempModel parseData:responseObject];
         
                  if (tempModel.run_number == 0) {
                      if (block!=nil) {
                          block(YES,tempModel);
                      }
                  }else{
                      [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                      if (block!=nil) {
                          block(NO,nil);
                      }
                  }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//添加试乘试驾
+(void)C_PostTrydriving_AddSetUid:(NSString *) uid withCar_id:(NSString *)car_id withDealer_id:(NSString *)dealer_id withPhone:(NSString *)phone withRealname:(NSString *)realname withMem:(NSString *)mem  withTime:(NSString*)time withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqTrydriving_AddUrl]
            withParameters:[TTReqProtocol C_PostTrydriving_AddSetUid:uid
                                                          withCar_id:car_id
                                                       withDealer_id:dealer_id
                                                           withPhone:phone
                                                        withRealname:realname
                                                             withMem:mem
                                                            withTime:time]
                   success:^(id responseObject)
    {
                       [SVProgressHUD dismiss];
        DLBaseModel* tempModel = [[DLBaseModel alloc]init];
        [tempModel parseData:responseObject];
        
        if (tempModel.run_number == 0) {
            if (block!=nil) {
                block(YES,tempModel);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
            if (block!=nil) {
                block(NO,nil);
            }
        }
        
    }
                   failure:^(NSString *error)
    {
                       [SVProgressHUD dismissWithError:KERROR_CLEW];
                       if (block!=nil)
                       {
                           block(NO,nil);
                       }
                   }];

}

//删除试乘试驾
+(void)C_PostTrydriving_DelSetID:(NSString *)ID withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqTrydriving_DelUrl]
            withParameters:[TTReqProtocol C_PostTrydriving_DelSetID:ID]
                   success:^(id responseObject)
     {
         
         
         [SVProgressHUD dismiss];
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }

         
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil)
         {
             block(NO,nil);
         }
     }];

}

//创建询价单
+(void)C_PostInquiry_CreateSetUid:(NSString *) uid
                       withCar_id:(NSString *)car_id
                      withCity_id:(NSString *)city_id
                 withCar_color_id:(NSString *)car_color_id
                   withDealer_ids:(NSString *)dealer_ids
                        withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqInquiry_CreateUrl]
            withParameters:[TTReqProtocol C_PostInquiry_CreateSetUid:uid
                                                          withCar_id:car_id
                                                         withCity_id:city_id
                                                    withCar_color_id:car_color_id
                                                      withDealer_ids:dealer_ids]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_MyOrderTtemModel* tempModel = [[M_MyOrderTtemModel alloc]init];
         [tempModel parseData:responseObject];
         if (tempModel.run_number == 0) {
             if (block!=nil)
             {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil)
             {
                 block(NO,nil);
             }
         }
         
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil)
         {
             block(NO,nil);
         }
     }];
}

//询价单详情
+(void)C_GetInquiry_GetSetUid:(NSString *) uid withID:(NSString *)ID                                   withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqInquiry_GetUrl]
           withParameters:[TTReqProtocol C_GetInquiry_GetSetUid:uid withID:ID]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
          M_MyOrderTtemModel* tempModel = [M_MyOrderTtemModel allocInstance];
 
          [tempModel parseData:responseObject];
 
          if (tempModel.run_number == 0) {
              if (block!=nil) {
                  block(YES,tempModel);
              }
          }else{
              [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
              if (block!=nil) {
                  block(NO,nil);
              }
          }
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//创建订单
+(void)C_PostOrder_CreatePostInquiry_CreateSetUid:(NSString *) uid
                                Inquiry_quoted_id:(NSString *)inquiry_quoted_id
                                             type:(NSString *)type
                                           car_id:(NSString *)car_id
                                        dealer_id:(NSString *)dealer_id
                                          city_id:(NSString *)city_id
                                          earnest:(NSString *)earnest
                                             memo:(NSString *)memo
                                     car_color_id:(NSString *)car_color_id
                                            phone:(NSString *)phone
                                    inviter_phone:(NSString *)inviter_phone
                                         realname:(NSString *)realname
                                      installment:(NSString *)installment
                                        withBlock:(TTBaseModelBlock)block
{
    
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    
    [DLHttpHelper PostData:[TTReqUrl C_ReqOrder_CreateUrl]
            withParameters:[TTReqProtocol C_PostOrder_CreatePostInquiry_CreateSetUid:uid
                                                                   Inquiry_quoted_id:inquiry_quoted_id
                                                                                type:type
                                                                              car_id:car_id
                                                                           dealer_id:dealer_id
                                                                             city_id:city_id
                                                                             earnest:earnest
                                                                                memo:memo
                                                                        car_color_id:car_color_id
                                                                               phone:phone
                                                                       inviter_phone:inviter_phone
                                                                            realname:realname
                                                                         installment:installment]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_MyOrderTtemModel* tempModel = [M_MyOrderTtemModel allocInstance];
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil)
         {
             block(NO,nil);
         }
     }];

}
//签到
+(void)C_GetPoints_SignSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqPoints_SignUrl]
           withParameters:[TTReqProtocol C_GetPoints_SignSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
                  DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
                  [tempModel parseData:responseObject];
         
                  if (tempModel.run_number == 0) {
                      if (block!=nil) {
                          block(YES,tempModel);
                      }
                  }else{
                      [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
                      if (block!=nil) {
                          block(NO,nil);
                      }
                  }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}

//获取已记录保险单列表
+(void)C_GetInsurerrecord_ListSetUid:(NSString *)uid withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqInsurerrecord_ListUrl]
           withParameters:[TTReqProtocol C_GetInsurerrecord_ListSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
    

}

//上传订单完成凭证
+(void)C_PostOrder_Upload_CertificateSetUid:(NSString *)uid
                               withOrder_id:(NSString *)order_id
                                 withImages:(NSString *)images
                                  withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqOrder_Upload_CertificateUrl]
           withParameters:[TTReqProtocol C_PostOrder_Upload_CertificateSetUid:uid
                                                                 withOrder_id:order_id
                                                                   withImages:images]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                  failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//订单支付
+(void)C_PostOrder_PayUid:(NSString*)uid
              withOrderId:(NSString*)orderid
               withStatus:(NSString*)status
                withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqOrder_PayUrl]
            withParameters:[TTReqProtocol C_PostOrder_PayUid:uid withOrderId:orderid withStatus:status]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//订单删除
+(void)C_PostOrder_DeleteUid:(NSString*)uid
                   withOrderId:(NSString*)ID
                     withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqOrder_DeleteUrl]
            withParameters:[TTReqProtocol C_PostOrder_DeleteUid:uid withOrderId:ID]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel* tempModel = [[DLBaseModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}

//第三方用户登录
+(void)C_PostUser_ThirdloginSetSource_from:(NSString *)source_from
                                      withSource_uid:(NSString *)source_uid
                                    withAccess_token:(NSString *)access_token
                                   wtihRefresh_token:(NSString *)refresh_token
                                       witHunique_id:(NSString *)unique_id
                                           withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqUser_ThirdloginUrl]
            withParameters:[TTReqProtocol C_PostUser_ThirdloginSetSource_from:source_from
                                                               withSource_uid:source_uid
                                                             withAccess_token:access_token wtihRefresh_token:refresh_token witHunique_id:unique_id]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_UserInfoModel* tempModel = [[M_UserInfoModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             
             if ([tempModel.user_id notEmpty]) {
                 [DLAppData sharedInstance].myUserKey = tempModel.user_id;
                 [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
             }
             
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];

}

//第三方用户绑定手机
+(void)C_PostUser_BindphoneSetUid:(NSString *)uid
                                  withPhone:(NSString *)phone
                                   withCode:(NSString *)code withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper PostData:[TTReqUrl C_ReqUser_BindphoneUrl]
            withParameters:[TTReqProtocol C_PostUser_BindphoneSetUid:uid
                                                           withPhone:phone
                                                            withCode:code]
                   success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_UserInfoModel* tempModel = [[M_UserInfoModel alloc]init];
         
         [tempModel parseData:responseObject];
         
         if (tempModel.run_number == 0) {
             
//             if ([tempModel.user_id notEmpty]) {
//                 [DLAppData sharedInstance].myUserKey = tempModel.user_id;
//                 [[DLUserDefaults sharedInstance] setObject:[DLAppData sharedInstance].myUserKey forKey:@"uid"];
//             }
             
             if (block!=nil) {
                 block(YES,tempModel);
             }
         }else{
             [SVProgressHUD showErrorWithStatus:tempModel.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     }
                   failure:^(NSString *error)
     {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block!=nil) {
             block(NO,nil);
         }
     }];
}

//秒杀列表
+(void)C_GetSpike_ListSetCity_id:(NSString *)city_id withBlock:(TTBaseModelBlock)block
{
//    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqSpike_ListUrl]
           withParameters:[TTReqProtocol C_GetSpike_ListSetCity_id:city_id]
                  success:^(id responseObject)
     {
//         [SVProgressHUD dismiss];
         
         M_SpikeListModel *model = [M_SpikeListModel allocInstance];
         [model parseData:responseObject];
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD dismiss];
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];

}
//秒杀详情
+(void)C_GetSpike_InfoSetID:(NSString *)ID  withSetUid:(NSString*)uid withBlock:(TTBaseModelBlock)block
{
    
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqSpike_InfoUrl]
           withParameters:[TTReqProtocol C_GetSpike_InfoSetID:ID withSetUid:uid]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         M_SpikeItemModel *model = [M_SpikeItemModel allocInstance];
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
    

}

//参与秒杀
+(void)C_GetSpike_RushSetID:(NSString *)ID
                    withUid:(NSString *)uid
              withTimestamp:(NSString *)timestamp withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqSpike_RushUrl]
           withParameters:[TTReqProtocol C_GetSpike_RushSetID:ID withUid:uid withTimestamp:timestamp]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_SpikeRushModel *model = [[M_SpikeRushModel alloc]init];
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
}

//发送消费码
+(void)C_GetCode_Send:(NSString*)ID withType:(NSString*)type withRelated_id:(NSString*)related_id withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqCode_SendUrl]
           withParameters:[TTReqProtocol C_GetCode_Send:ID withType:type withRelated_id:related_id]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         DLBaseModel *model = [[DLBaseModel alloc]init];
         
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
}

//报价单详情
+(void)C_GetQuoted_Get:(NSString*)ID withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqQuoted_GetUrl]
           withParameters:[TTReqProtocol C_GetQuoted_Get:ID]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         M_QuoteItemModel *model = [[M_QuoteItemModel alloc]init];
         
         [model parseData:responseObject];
         
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
}
+(void)C_GetArticle_List_Get:(NSString *)limit withPage:(NSString *)page withMax:(NSString *)max withCityId:(NSString *)cityId withType:(NSString *)type withBlock :(TTBaseModelBlock)block
{
//<<<<<<< .mine
////    [SVProgressHUD showWithStatus:KWAIT_STATUS];
//=======
//    //[SVProgressHUD showWithStatus:KWAIT_STATUS];
//>>>>>>> .r2579
    [DLHttpHelper GetData:[TTReqUrl C_ReqArticleList_GetUrl]
           withParameters:[TTReqProtocol C_GetArticle_List:limit withPage:page withMax:max withCityId:cityId withType:type]
                  success:^(id responseObject)
     {
//<<<<<<< .mine
////         [SVProgressHUD dismiss];
//=======
//         //[SVProgressHUD dismiss];
//>>>>>>> .r2579
         
         Dh_TitleModel *model = [[Dh_TitleModel alloc]init];
//         
         [model parseData:responseObject];
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
}
+(void)C_GetArticle_Detail_Get:(NSString *)articleId withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqArticleDetail_GetUrl]
           withParameters:[TTReqProtocol C_GetArticle_Detail:articleId]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         
         //         M_QuoteItemModel *model = [[M_QuoteItemModel alloc]init];
         //
         //         [model parseData:responseObject];
         //
         //         if (model.run_number == 0) {
         //             if (block!=nil) {
         //                 block(YES,model);
         //             }
         //         }else
         //         {
         //             [SVProgressHUD showErrorWithStatus:model.run_mess];
         //             if (block!=nil) {
         //                 block(NO,nil);
         //             }
         //         }
         
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];
}
+(void)C_GetScanDetail_Get:(NSString *)scanUrl withBlock:(TTBaseModelBlock)block
{
    [SVProgressHUD showWithStatus:KWAIT_STATUS];
    [DLHttpHelper GetData:[TTReqUrl C_ReqScanDetail_GetUrl]
           withParameters:[TTReqProtocol C_GetScan_Deatil:scanUrl]
                  success:^(id responseObject)
     {
         [SVProgressHUD dismiss];
         LL_GetScanUrlModel *model = [[LL_GetScanUrlModel alloc]init];
         [model parseData:responseObject];
         if (model.run_number == 0) {
             if (block!=nil) {
                 block(YES,model);
             }
         }else
         {
             [SVProgressHUD showErrorWithStatus:model.run_mess];
             if (block!=nil) {
                 block(NO,nil);
             }
         }
         
     } failure:^(NSString *error) {
         [SVProgressHUD dismissWithError:KERROR_CLEW];
         if (block !=nil) {
             block(NO,nil);
         }
     }];

}
@end
