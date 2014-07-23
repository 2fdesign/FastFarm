//
//  DetailViewController.m
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import "userDetails.h"


#define deg2Rad(x) (M_PI * x / 180.0)
uint16_t x=70,y=70;
int c,l,animation_l,stepChange;

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController
@synthesize tankData = _tankData;
@synthesize gaugePointer = _gaugePointer;
@synthesize gaugeAnimationTimer = _gaugeAnimationTimer;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem)
    {
        _detailItem = newDetailItem;
       _tankData = (NSDictionary *)(_detailItem);
       NSLog(@"Detail Item %@:",_tankData);
        // Update the view.
      //  [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

//   if (self.detailItem) {
//       self.detailDescriptionLabel.text = [self.detailItem description];
//   }
}

- (void)viewDidLoad
{
   
   [super viewDidLoad];
   //UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   //self.navigationItem.titleView = img;
   
   UIImageView* gaugeBase = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GaugeBase250"]];
   [gaugeBase setFrame:CGRectMake(x, y, 180, 180)];
   [self.view addSubview:gaugeBase];
   
   _gaugePointer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GaugePointer250"]];
   [_gaugePointer setFrame:CGRectMake(x, y, 180, 180)];

   [self.view addSubview:_gaugePointer];
   [_gaugePointer.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
   _gaugePointer.transform = CGAffineTransformMakeRotation(deg2Rad(-225));

   [self.view setBackgroundColor:[UIColor whiteColor]];
   
   
   UIButton *orderButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
   [orderButton setTitle:@"Order" forState:UIControlStateNormal];
   [orderButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
   [orderButton setTitleColor:[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.2] forState:UIControlStateHighlighted];
   [orderButton addTarget:self action:@selector(orderFuel) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *ButtonItem = [[UIBarButtonItem alloc] initWithCustomView:orderButton];
   
   self.navigationItem.rightBarButtonItem = ButtonItem;
   
   //[self.navigationItem setHidesBackButton:YES animated:NO];
   
   [self configureView];
   
}

-(void)orderFuel
{
   if ([MFMailComposeViewController canSendMail])
   {
      MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
      
      mailer.mailComposeDelegate = self;
      
      [mailer setSubject:[NSString stringWithFormat:@"Fuel Order for %@",[_tankData objectForKey:@"TankName"]]];
      
      NSArray *toRecipients = [NSArray arrayWithObjects:@"info@2fdesign.co.nz", nil];
      [mailer setToRecipients:toRecipients];
      
      //UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
      //NSData *imageData = UIImagePNGRepresentation(myImage);
      //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
      
      NSString *emailBody = [NSString stringWithFormat:@"Fule Order Requested for %@ %@\n Current Level %@ liters\n Capacity %@ liters\n LTF %@ liters\n",
                              [_tankData objectForKey:@"TankID"],[_tankData objectForKey:@"TankName"],[_tankData objectForKey:@"Level"],[_tankData objectForKey:@"Capacity"],[_tankData objectForKey:@"LTF"]];
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

-(void)setGaugeLevel
{
   animation_l = 0;
   float levelNormalised = ((float)(animation_l)/(float)(c) * 270) - 225;
   NSLog(@"lN %f",levelNormalised);
   
   stepChange = l/100;
   
   _gaugePointer.transform = CGAffineTransformMakeRotation(deg2Rad(levelNormalised));
   [self.view bringSubviewToFront:_gaugePointer];
   _gaugeAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(gaugeTimerFire:) userInfo:nil repeats:YES];
}

-(void)gaugeTimerFire:(NSTimer *)timer
{
   if ((l - animation_l) < (l / 25))
      animation_l += stepChange / 6;
   else if ((l - animation_l) < (l / 10))
      animation_l += stepChange / 2;
   else
      animation_l += stepChange;
   if (animation_l >= l)
      [timer invalidate];
   else
   {
      float levelNormalised = ((float)(animation_l)/(float)(c) * 270) - 225;
      _gaugePointer.transform = CGAffineTransformMakeRotation(deg2Rad(levelNormalised));
   }
   
}

-(void)viewDidAppear:(BOOL)animated
{
   
   NSString *titleString = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"TankName"]];
   self.title = titleString;
   
   NSString *levelStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"Level"]];
   UITextView* level = [[UITextView alloc] initWithFrame:CGRectMake(x+55, y+100, 70, 40)];
   level.font = [UIFont systemFontOfSize:15];
   level.backgroundColor = [UIColor clearColor];
   level.textAlignment = NSTextAlignmentCenter;
   level.text = levelStr;
   self.ltfLabel.text = [NSString stringWithFormat:@"%@ litres",levelStr];
   [self.view addSubview:level];
   l = [levelStr intValue];
   
   
   NSString *capacityStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"Capacity"]];
   UITextView* capacity = [[UITextView alloc] initWithFrame:CGRectMake(x+66, y+120, 70, 40)];
   capacity.font = [UIFont systemFontOfSize:10];
   capacity.backgroundColor = [UIColor clearColor];
   capacity.textAlignment = NSTextAlignmentRight;
   capacity.text = capacityStr;
   self.capacityLabel.text = [NSString stringWithFormat:@"%@ litres",capacityStr];
   [self.view addSubview:capacity];
   c = [capacityStr intValue];
   
   NSString *zeroStr = @"0";
   UITextView* zero = [[UITextView alloc] initWithFrame:CGRectMake(x+50, y+120, 70, 40)];
   zero.font = [UIFont systemFontOfSize:10];
   zero.backgroundColor = [UIColor clearColor];
   zero.textAlignment = NSTextAlignmentLeft;
   zero.text = zeroStr;
   [self.view addSubview:zero];
   
   NSString *fluidStr = @"Diesel";
   UITextView* fluid = [[UITextView alloc] initWithFrame:CGRectMake(x+55, y+28, 70, 40)];
   fluid.font = [UIFont systemFontOfSize:15];
   fluid.backgroundColor = [UIColor clearColor];
   fluid.textAlignment = NSTextAlignmentCenter;
   fluid.text = fluidStr;
   [self.view addSubview:fluid];

   
   //NSString *dateStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"DateTime"]];
   //userDetails *user = [userDetails alloc];
   //self.dateLabel.text = [user humanDateFromString:dateStr];
   //self.timeLabel.text = [user humanTimeFromString:dateStr];
   
   //[UIView beginAnimations:nil context:NULL];
   //[UIView setAnimationDuration:2];
   //[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
   //[UIView setAnimationBeginsFromCurrentState:YES];
   
   //CGAffineTransform transform = CGAffineTransformMakeRotation(deg2Rad(200));
   //_gaugePointer.transform = transform;
   //[UIView commitAnimations];
   [self setGaugeLevel];
   
   [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib
{
   [super awakeFromNib];
   UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBarLogo"]];
   self.navigationItem.titleView = img;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
   
   if (indexPath.row == 0)
   {
      cell.textLabel.text = @"Last Updated";
      NSString *dateStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"DateTime"]];
      userDetails *user = [userDetails alloc];
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[user humanDateFromString:dateStr],[user humanTimeFromString:dateStr]];
   }
   else if (indexPath.row == 1)
   {
      cell.textLabel.text = @"Tank Capacity";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Liters",[_tankData objectForKey:@"Capacity"]];
   }
   else if (indexPath.row == 2)
   {
      cell.textLabel.text = @"Current Level";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Liters",[_tankData objectForKey:@"Level"]];
   }
   else if (indexPath.row == 3)
   {
      cell.textLabel.text = @"LTF";
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ Liters",[_tankData objectForKey:@"LTF"]];
   }
   else if (indexPath.row == 4)
   {
      cell.textLabel.text = @"Alert Status";
      NSString *alertStatus = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"IsActiveAlerts"]];
      if ([alertStatus isEqualToString:@"0"])
         cell.detailTextLabel.text = @"None";
      else
         cell.detailTextLabel.text = @"ALERT Active";
   }
   return cell;
}

@end
