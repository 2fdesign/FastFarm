//
//  MasterViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 23/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "iLevelViewController.h"

@interface iLevelViewController ()
{
   NSMutableArray *_fuelData;
}
@end

@implementation iLevelViewController

#pragma mark - httpInterfaceDelegate Protocol methods

-(void) httpNewData:(NSMutableArray *)data
{
   _fuelData = data;
   NSDictionary *object = _fuelData[0];
   NSString *dateStr = [NSString stringWithFormat:@"%@",[object objectForKey:@"DateTime"]];
   userDetails *user = [userDetails alloc];
   _labelLastUpdate.text = [user humanDateAndTimeFromString:dateStr];
}
-(void) httpFailure:(NSString *)error
{
   UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Connection Failed" message:@"Unable to connect to FastFarm" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   [errorView show];
   //[self.navigationController popToRootViewControllerAnimated:true];
}

-(IBAction) buttonPushing:(id)Sender
{
   UIButton *button = (UIButton*)Sender;
   [button setAlpha:(0.75)];
}

-(IBAction) buttonPushed:(id)Sender
{
   UIButton *button = (UIButton*)Sender;
   [button setAlpha:(1)];
}

- (void)viewWillDisappear:(BOOL)animated
{
   //NSArray *viewControllers = self.tabBarController.viewControllers;
   //[super viewDidDisappear:animated];
   //if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self)
   //{
      // View is disappearing because a new view controller was pushed onto the stack
   //   NSLog(@"New view controller was pushed");
  // }
   //else if ([viewControllers indexOfObject:self] == NSNotFound)
   //{
      // View is disappearing because it was popped from the stack
    //  NSLog(@"View controller was popped");
   //}
   
   //NSLog(@"IndexOfObject %d",[self.navigationController.viewControllers indexOfObject:self]);
   //if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
   //   [self performSegueWithIdentifier:@"unwindToStart" sender:self];
  
}

- (void)awakeFromNib
{
   [super awakeFromNib];
   UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   self.tabBarController.navigationItem.titleView = img;
}

-(void) viewWillAppear:(BOOL)animated
{
   userDetails *user = [userDetails alloc];
   httpInterface *http = [[httpInterface alloc] initWithDelegate:self];
   [http getFuelDataForUser:[user getUserName] password:[user getPassword]];
   
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.navigationItem.titleView = img;
   
   
   [super viewWillAppear:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setUpImageBackButton
{
   UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
   //UIImage *backImage = [[UIImage imageNamed:@"back_button_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12.0f, 0, 12.0f)];
   //[backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
   backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   backButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   [backButton setTitle:@"Logout.." forState:UIControlStateNormal];
   backButton.titleLabel.font = [UIFont systemFontOfSize:12];
   [backButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
   [backButton addTarget:self action:@selector(popCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   self.tabBarController.navigationItem.leftBarButtonItem = backButtonItem;
   
   [self.tabBarController.navigationItem setHidesBackButton:YES animated:NO];
   
}

- (void)popCurrentViewController
{
   [self.navigationController popViewControllerAnimated:YES];
   [self performSegueWithIdentifier:@"unwindToStart" sender:self];
}

- (void)viewDidLoad
{
   // Do any additional setup after loading the view.
   //  self.tabBarController.navigationItem.hidesBackButton=YES;
   [self setUpImageBackButton];
   [super awakeFromNib];
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.tabBarController.navigationItem.titleView = img;
   //[super viewDidLoad];
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
