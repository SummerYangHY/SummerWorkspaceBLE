//
//  SummerNetworkRequest.m
//  SummerKit
//
//  Created by Summer on 2020/4/21.
//  Copyright © 2020 Summer. All rights reserved.
//

#import "SummerNetworkRequest.h"

@implementation SummerNetworkRequest
static SummerNetworkRequest * manager = nil;
+(instancetype)shareInstance{
   static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        
    });
    return manager;
}
@end
