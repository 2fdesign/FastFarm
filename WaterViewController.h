//
//  WaterViewController.h
//  FastFarm
//
//  Created by Rob Beck on 10/11/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"

@interface WaterViewController : UITableViewController <UITableViewDataSource, httpInterfaceDelegate>

@property (retain, nonatomic) httpInterface *http1;

- (void)refreshTable;

@end
