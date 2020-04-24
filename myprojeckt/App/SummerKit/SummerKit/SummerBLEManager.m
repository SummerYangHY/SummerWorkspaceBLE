//
//  SummerBLEManager.m
//  SummerKit
//
//  Created by Summer on 2020/4/20.
//  Copyright © 2020 Summer. All rights reserved.
//

#import "SummerBLEManager.h"

@interface SummerBLEManager()<CBCentralManagerDelegate,CBPeripheralDelegate>
//手机设备
@property (nonatomic, strong) CBCentralManager *MyCentral;
//外设设备
@property (nonatomic, strong) CBPeripheral *MyPeripheral;
@end
@implementation SummerBLEManager
static SummerBLEManager * manager = nil;
+(instancetype)shareInstance{
    static dispatch_once_t oncetoken ;
    dispatch_once(&oncetoken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}
-(void)Central{
    self.MyCentral = [[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue() options:nil];
}


#pragma marl_______centralDeleateuu________
- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    NSLog(@"dsfdf");
    switch (central.state) {
        case CBManagerStatePoweredOn:
            [self.MyCentral scanForPeripheralsWithServices:nil options:nil];
            break;
            
        default:
            break;
    }
}
//扫描外设
- (void)centralManager:(CBCentralManager *)central // 中心管理者
didDiscoverPeripheral:(CBPeripheral *)peripheral // 外设
    advertisementData:(NSDictionary *)advertisementData // 外设携带的数据
                  RSSI:(NSNumber *)RSSI {

    NSLog(@"扫描s到设备%@——————————%@",peripheral.name, peripheral.identifier);
    if ([peripheral.name isEqualToString:@"Hud_dj06"]|| [peripheral.name isEqualToString:@"FMC BTLE"]) {
        self.MyPeripheral = peripheral;
        self.MyPeripheral.delegate = self;
        [self.MyCentral connectPeripheral:peripheral options:nil];
    }
}


//中心管理者连接外设成功
- (void)centralManager:(CBCentralManager *)central // 中心管理者
  didConnectPeripheral:(CBPeripheral *)peripheral // 外设
{
    NSLog(@"设备连接成功，设备名：%@", peripheral.name);
    //7、外设发现服务,传nil代表不过滤
    [self.MyPeripheral discoverServices:nil];
}
 
// 外设连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备连接失败，设备名：%@", peripheral.name);
}
 
// 丢失连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"设备丢失连接，设备名：%@", peripheral.name);
}


#pragma marl_______peripheralDeleate________
//发现外设的服务后调用的方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 是否获取失败
    if (error) {
        NSLog(@"设备获取服务失败，设备名：%@", peripheral.name);
        return;
    }
//    for (CBService *service in peripheral.services) {
//        self.mService = service;
//        NSLog(@"设备获取服务成功，服务名：%@，服务UUID：%@，服务数量：%lu",service,service.UUID,peripheral.services.count);
//        //外设发现特征
//        [peripheral discoverCharacteristics:nil forService:service];
//    }
}
//发发现f服务下的characterristics
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error) {
        return;
    }
    for (CBCharacteristic * charact in service.characteristics) {
        [peripheral discoverDescriptorsForCharacteristic:charact];
    }
   
}
//发现外设的特征的描述键值对
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
    
}

//读取某个特征后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
}
//通知状态改变时调用
-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
}

//写入数据
-(void)sendDataToCharacteristic:(NSString *)data{
    NSData* Data = [data dataUsingEncoding:NSUTF8StringEncoding];
   // [self.MyPeripheral writeValue:myData // 写入的数据 forCharacteristic: Characteristic // 写给哪个特征 type:CBCharacteristicWriteWithResponse];// 通过此响应记录是否成功写入
}
//写入后的回调
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
}
@end
