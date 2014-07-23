//
//  Alerts_TableViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 23/07/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"

@class httpInterface;

@interface Alerts_TableViewController : UITableViewController <httpInterfaceDelegate>

@property (retain, nonatomic) UIRefreshControl *refreshControl;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) httpInterface *http1;


@end
