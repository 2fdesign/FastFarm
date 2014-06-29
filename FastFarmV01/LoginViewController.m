//
//  LoginViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "userDetails.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)awakeFromNib
{
   [super awakeFromNib];
   UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   self.navigationItem.titleView = img;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
   [super viewDidAppear:animated];
   userDetails *user = [userDetails alloc];
   _textUser.text = [user getUserName];
   _textPassword.text = [user getPassword];
}


-(IBAction) btnLoginPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
   userDetails *user = [userDetails alloc];
   [user saveUserName:_textUser.text password:_textPassword.text];
}

-(IBAction) btnForgotPasswordPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
}

-(IBAction) backgroundPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
