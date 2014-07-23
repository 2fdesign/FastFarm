//
//  DetailViewController.h
//  FastFarmV01
//
//  Created by Rob Beck on 3/06/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
{
}

@property (nonatomic, retain) IBOutlet UITableView *detailTable;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSDictionary *tankData;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *capacityLabel;
@property (nonatomic, retain) IBOutlet UILabel *dteLabel;
@property (nonatomic, retain) IBOutlet UILabel *ltfLabel;
@property (nonatomic, retain) UIImageView* gaugePointer;
@property (nonatomic, retain) NSTimer *gaugeAnimationTimer;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(void)gaugeTimerFire:(NSTimer *)timer;

@end
