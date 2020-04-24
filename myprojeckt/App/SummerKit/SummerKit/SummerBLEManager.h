//
//  SummerBLEManager.h
//  SummerKit
//
//  Created by Summer on 2020/4/20.
//  Copyright © 2020 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface SummerBLEManager : NSObject
+(instancetype)shareInstance;
-(void)Central;
@end

NS_ASSUME_NONNULL_END
