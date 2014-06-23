//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuelViewController : UITableViewController <NSURLConnectionDataDelegate>//, NSURLSessionTaskDelegate>

//@property (nonatomic, retain) NSArray *tanks;
@property (retain, nonatomic) NSString *encodedLoginData;
@property (retain, nonatomic) UIRefreshControl *refreshControl;
//@property (retain, nonatomic) NSURLSessionDataTask *dataTask;
//@property (retain, nonatomic) NSURLSession *defaultSession;
//@property (retain, nonatomic) NSURLSessionConfiguration *sessionConfig;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) NSMutableData *receivedData;

- (void) sendHTTPGetSync;
- (void) sendHTTPGet;
//- (void) sendHTTPGetSession;
- (void) saveUserName:(NSString *)userName password:(NSString *)password;
- (NSString *) getUserName;
- (NSString *) getPassword;

@end
