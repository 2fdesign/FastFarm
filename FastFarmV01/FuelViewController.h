//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"
#import "FuelViewTableCell.h"

@class httpInterface;

@interface FuelViewController : UITableViewController <httpInterfaceDelegate>//, NSURLSessionTaskDelegate>

@property (retain, nonatomic) UIRefreshControl *refreshControl;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) httpInterface *http1;

@end
