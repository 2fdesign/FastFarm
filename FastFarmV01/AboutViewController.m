//
//  AboutViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 28/07/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "AboutViewController.h"
#import "userDetails.h"

#define ver @"A0.0.2"

@interface AboutViewController ()

@end

@implementation AboutViewController

-(IBAction)btnLogoutPressed
{
   userDetails *user = [userDetails alloc];
   [user saveUserName:@"" password:@""];
   [self.navigationController popToRootViewControllerAnimated:NO];
   [self performSegueWithIdentifier:@"unwindToStart" sender:self];
}

- (void)awakeFromNib
{
   [super awakeFromNib];
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
   _lableLogedInAs.text = [NSString stringWithFormat:@"You are logged in as %@",[user getUserName]];
   
   NSString *compileDate = [NSString stringWithUTF8String:__DATE__];
   NSString *versioDate = [NSString stringWithFormat:@"Version %@ %@",ver, compileDate];
   _labelVersion.text = versioDate;
   
   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
