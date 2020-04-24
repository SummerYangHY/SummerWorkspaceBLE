//
//  AppDelegate.h
//  SummerProject
//
//  Created by Summer on 2020/4/20.
//  Copyright © 2020 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

