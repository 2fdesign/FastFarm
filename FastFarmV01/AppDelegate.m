//
//  AppDelegate.m
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "userDetails.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
   
   NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   destPath = [destPath stringByAppendingPathComponent:@"user.plist"];
   
   // If the file doesn't exist in the Documents Folder, copy it.
   NSFileManager *fileManager = [NSFileManager defaultManager];
   
   if (![fileManager fileExistsAtPath:destPath])
   {
      NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"];
      [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
   }
   
   // Load the Property List.
   //drinkArray = [[NSArray alloc] initWithContentsOfFile:destPath];
   
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
   // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   //userDetails *user = [userDetails alloc];
   //if ([[user isUserRemembered] isEqualToString:@"0"])
   //   [user saveUserName:@"" password:@""];

   // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   //userDetails *user = [userDetails alloc];
   //if ([[user isUserRemembered] isEqualToString:@"0"])
   //   [user saveUserName:@"" password:@""];
      
   // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
