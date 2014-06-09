//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController //<NSURLSessionDelegate>//, NSURLSessionTaskDelegate>
{
   //NSArray *tanks;
   NSString *encodedLoginData;
   UIRefreshControl *refreshControl;
   NSURLSessionDataTask *dataTask;
   NSURLSession *defaultSession;
   NSURLSessionConfiguration *sessionConfig;
}
//@property (nonatomic, retain) NSArray *tanks;
@property (nonatomic, retain) NSString *encodedLoginData;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
@property (nonatomic, retain) NSURLSessionDataTask *dataTask;
@property (nonatomic, retain) NSURLSession *defaultSession;
@property (nonatomic, retain) NSURLSessionConfiguration *sessionConfig;

- (void) sendHTTPGet;
- (void) saveUserName:(NSString *)userName password:(NSString *)password;
- (NSString *) getUserName;
- (NSString *) getPassword;

@end
