//
//  LoginViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "userDetails.h"
#import "iLevelViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - httpInterfaceDelegate Protocol methods

-(void) httpNewData:(NSMutableArray *)data
{
   [_loginActivity stopAnimating];
   [self performSegueWithIdentifier: @"LoginSegue" sender: self];
}

-(void) httpFailure:(NSString *)error
{
   [_loginActivity stopAnimating];
   //iLevelViewController *vc = [[iLevelViewController alloc] initWithNibName:@"iLevelViewController" bundle:nil];
   //[[self navigationController] pushViewController:vc animated:YES];
   UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Unable to connect to FastFarm" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   [errorView show];
}

- (void)awakeFromNib
{
   //[super awakeFromNib];
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.navigationItem.titleView = img;
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
    userDetails *user = [userDetails alloc];
    _textUser.text = [user getUserName];
    _textPassword.text = [user getPassword];
    //NSLog(@"Length: %d",userName.length);
    //if ([[user isUserRemembered] isEqualToString:@"0"])
    //   [_switchRememberPassword setOn:FALSE];
    //else
    //   [_switchRememberPassword setOn:TRUE];
   
   [_textPassword addTarget:self
                     action:@selector(textFieldDone:)
           forControlEvents:UIControlEventEditingDidEndOnExit];
   [_textUser addTarget:self
                 action:@selector(textFieldDone:)
       forControlEvents:UIControlEventEditingDidEndOnExit];
   
    if ((_textUser.text.length > 0) && (_textPassword.text.length > 0))
    {
       [self btnLoginPress:NULL];
    }
}

- (IBAction)textFieldDone:(id)sender
{
   [sender resignFirstResponder];
   [self btnLoginPress:nil];
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

-(void)viewDidDisappear:(BOOL)animated
{
   [_loginActivity stopAnimating];
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
   NSLog(@"Rolled back");
   userDetails *user = [userDetails alloc];
   [user saveUserName:@"" password:@""];
}

-(IBAction) btnLoginPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
   userDetails *user = [userDetails alloc];
   [user saveUserName:_textUser.text password:_textPassword.text];

   httpInterface *http = [[httpInterface alloc] initWithDelegate:self];
   [http getFuelDataForUser:[user getUserName] password:[user getPassword]];
   
   [_loginActivity startAnimating];
   
}

-(IBAction) btnForgotPasswordPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
   //[self performSegueWithIdentifier: @"LoginSegue" sender: self];  // Temp until Sever fixed
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.fastfarm.co.nz/account/forgotpassword"]];
}

-(IBAction) backgroundPress: (id) sender
{
   [_textUser resignFirstResponder];
   [_textPassword resignFirstResponder];
}

-(IBAction) switchRemember: (id) sender
{
   userDetails *user = [userDetails alloc];
   if (_switchRememberPassword.on)
      [user saveIsUserRemembered:@"1"];
   else
      [user saveIsUserRemembered:@"0"];
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
