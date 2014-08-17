//
//  LoginViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "httpInterface.h"
#import "userDetails.h"


@interface LoginViewController : UIViewController <httpInterfaceDelegate>

@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) IBOutlet UIButton *btnForgotPassword;
@property (nonatomic, retain) IBOutlet UITextField *textUser;
@property (nonatomic, retain) IBOutlet UITextField *textPassword;
@property (nonatomic, retain) IBOutlet UISwitch *switchRememberPassword;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *loginActivity;

-(IBAction) btnLoginPress: (id) sender;
-(IBAction) btnForgotPasswordPress: (id) sender;
-(IBAction) backgroundPress: (id) sender;
-(IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue;


@end
