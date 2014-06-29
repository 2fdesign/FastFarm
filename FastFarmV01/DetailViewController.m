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
uint16_t x=20,y=80;
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
   [gaugeBase setFrame:CGRectMake(x, y, 125, 125)];
   [self.view addSubview:gaugeBase];
   
   _gaugePointer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GaugePointer250"]];
   [_gaugePointer setFrame:CGRectMake(x, y, 125, 125)];

   [self.view addSubview:_gaugePointer];
   [_gaugePointer.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
   _gaugePointer.transform = CGAffineTransformMakeRotation(deg2Rad(-225));

   [self configureView];
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
   UITextView* level = [[UITextView alloc] initWithFrame:CGRectMake(x+26, y+85, 70, 40)];
   level.font = [UIFont systemFontOfSize:15];
   level.backgroundColor = [UIColor clearColor];
   level.textAlignment = NSTextAlignmentCenter;
   level.text = levelStr;
   self.ltfLabel.text = [NSString stringWithFormat:@"%@ litres",levelStr];
   [self.view addSubview:level];
   l = [levelStr intValue];
   
   
   NSString *capacityStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"Capacity"]];
   UITextView* capacity = [[UITextView alloc] initWithFrame:CGRectMake(x+26, y+75, 70, 40)];
   capacity.font = [UIFont systemFontOfSize:8];
   capacity.backgroundColor = [UIColor clearColor];
   capacity.textAlignment = NSTextAlignmentRight;
   capacity.text = capacityStr;
   self.capacityLabel.text = [NSString stringWithFormat:@"%@ litres",capacityStr];
   [self.view addSubview:capacity];
   c = [capacityStr intValue];
   
   NSString *zeroStr = @"0";
   UITextView* zero = [[UITextView alloc] initWithFrame:CGRectMake(x+31, y+75, 70, 40)];
   zero.font = [UIFont systemFontOfSize:8];
   zero.backgroundColor = [UIColor clearColor];
   zero.textAlignment = NSTextAlignmentLeft;
   zero.text = zeroStr;
   [self.view addSubview:zero];
   
   NSString *fluidStr = @"Diesel";
   UITextView* fluid = [[UITextView alloc] initWithFrame:CGRectMake(x+26, y+18, 70, 40)];
   fluid.font = [UIFont systemFontOfSize:15];
   fluid.backgroundColor = [UIColor clearColor];
   fluid.textAlignment = NSTextAlignmentCenter;
   fluid.text = fluidStr;
   [self.view addSubview:fluid];

   
   NSString *dateStr = [NSString stringWithFormat:@"%@",[_tankData objectForKey:@"DateTime"]];
   userDetails *user = [userDetails alloc];
   //NSArray *dateItems = [dateStr componentsSeparatedByString:@"T"];
   self.dateLabel.text = [user humanDateFromString:dateStr];
   self.timeLabel.text = [user humanTimeFromString:dateStr];

   
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

@end
