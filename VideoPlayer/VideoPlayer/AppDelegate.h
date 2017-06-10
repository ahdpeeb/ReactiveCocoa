//
//  AppDelegate.h
//  VideoPlayer
//
//  Created by iosDeveloper on 6/6/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

