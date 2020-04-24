//
//  ViewController.m
//  SummerProject
//
//  Created by Summer on 2020/4/20.
//  Copyright © 2020 Summer. All rights reserved.
//

#import "ViewController.h"
#import <SummerKit/SummerKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [[SummerBLEManager shareInstance] Central];
}


@end
