//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"

@class httpInterface;

@interface FuelViewController : UITableViewController <httpInterfaceDelegate>//, NSURLSessionTaskDelegate>

@property (retain, nonatomic) UIRefreshControl *refreshControl;
@property (retain, nonatomic) UITableView *tableView;

@end
