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
#import <MessageUI/MessageUI.h>

@interface iLevelViewController : UIViewController <httpInterfaceDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTile1Height;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTile2Height;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTile3Height;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTile4Height;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cIcon3VerticalPosition;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cIcon4VerticalPosition;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTitle3VerticalPosition;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cTitle4VerticalPosition;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cSubTitle3VerticalPosition;
@property (nonatomic, retain) IBOutlet NSLayoutConstraint *cSubTitle4VerticalPosition;


@property (nonatomic, retain) IBOutlet UILabel *labelLastUpdate;
-(IBAction) buttonPushing:(id)Sender;
-(IBAction) buttonPushed:(id)Sender;
-(IBAction) buttonExternalAppRequested:(id)Sender;
- (void)setUpImageBackButton;

@end
