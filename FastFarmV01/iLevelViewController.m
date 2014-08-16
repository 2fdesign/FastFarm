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
   long fuelSum = 0;
   _fuelData = data;
   if ([_fuelData count] == 1)
   {
      NSDictionary *object = _fuelData[0];
      NSString *fuelLevelStr = [NSString stringWithFormat:@"Tank Level: %@ Liters",[object objectForKey:@"Level"]];
      //NSString *dateStr = [NSString stringWithFormat:@"%@",[object objectForKey:@"DateTime"]];
      //userDetails *user = [userDetails alloc];
      _labelLastUpdate.text = fuelLevelStr;
   }
   else if ([_fuelData count] > 1)
   {
      for (int x=0; x<[_fuelData count]; x++)
      {
         NSDictionary *object = _fuelData[x];
         fuelSum += [[object objectForKey:@"Level"] longValue];
      }
      fuelSum /= [_fuelData count];
      NSString *fuelLevelStr = [NSString stringWithFormat:@"Avg Level: %ld Liters",fuelSum];
      _labelLastUpdate.text = fuelLevelStr;
   }
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

-(IBAction) buttonExternalAppRequested:(id)Sender
{
   UIButton *button = (UIButton*)Sender;
   if (button.tag == 1)  // Weather
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://m.metservice.com"]];
   if (button.tag == 2)  // Sports
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.stuff.co.nz/sport"]];
   if (button.tag == 3)  // Email
   {
      if ([MFMailComposeViewController canSendMail])
      {
         MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
         
         mailer.mailComposeDelegate = self;
         
         [mailer setSubject:[NSString stringWithFormat:@"Fuel Order Requested"]];
         
         NSArray *toRecipients = [NSArray arrayWithObjects:@"info@2fdesign.co.nz", nil];
         [mailer setToRecipients:toRecipients];
         
         //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
         //NSData *imageData = UIImagePNGRepresentation(myImage);
         //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
         
         NSString *emailBody = @"Fuel Order Requested for [please fill in details here]";
                                
         [mailer setMessageBody:emailBody isHTML:NO];
         
         [self presentViewController:mailer animated:YES completion:nil];
      }
      else
      {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                         message:@"Your device isn't setup to send email"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
         [alert show];
      }
   }
}

- (void)awakeFromNib
{
   [super awakeFromNib];
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.navigationItem.titleView = img;
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
   [backButton setTitle:@"Logout" forState:UIControlStateNormal];
   backButton.titleLabel.font = [UIFont systemFontOfSize:12];
   [backButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
   [backButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.2] forState:UIControlStateHighlighted];
   [backButton addTarget:self action:@selector(popCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
   
   self.navigationItem.leftBarButtonItem = backButtonItem;
   
   [self.navigationItem setHidesBackButton:YES animated:NO];
   
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
   switch (result)
   {
      case MFMailComposeResultCancelled:
         NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
         break;
      case MFMailComposeResultSaved:
         NSLog(@"Mail saved: you saved the email message in the drafts folder.");
         break;
      case MFMailComposeResultSent:
         NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
         break;
      case MFMailComposeResultFailed:
         NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
         break;
      default:
         NSLog(@"Mail not sent.");
         break;
   }
   
   // Remove the mail view
   [self dismissViewControllerAnimated:YES completion:nil];
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
   //[super awakeFromNib];
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.tabBarController.navigationItem.titleView = img;
   [super viewDidLoad];
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
