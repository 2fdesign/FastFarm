//
//  MasterViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"
#import "userDetails.h"

@interface iLevelViewController : UIViewController <httpInterfaceDelegate>

@property (nonatomic, retain) IBOutlet UILabel *labelLastUpdate;
-(IBAction) buttonPushing:(id)Sender;
-(IBAction) buttonPushed:(id)Sender;
-(IBAction) buttonExternalAppRequested:(id)Sender;
- (void)setUpImageBackButton;

@end
