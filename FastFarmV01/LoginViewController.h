//
//  LoginViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) IBOutlet UIButton *btnForgotPassword;
@property (nonatomic, retain) IBOutlet UITextField *textUser;
@property (nonatomic, retain) IBOutlet UITextField *textPassword;
@property (nonatomic, retain) IBOutlet UISwitch *switchRembmberPassword;

-(IBAction) btnLoginPress: (id) sender;
-(IBAction) btnForgotPasswordPress: (id) sender;
-(IBAction) backgroundPress: (id) sender;


@end
