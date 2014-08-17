//
//  AboutViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 28/07/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *labelVersion;
@property (nonatomic, retain) IBOutlet UILabel *lableLogedInAs;

-(IBAction) btnLogoutPressed;

@end
