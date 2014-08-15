//
//  FuelViewTableCell.h
//  FastFarmV01
//
//  Created by Rob Beck on 15/08/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuelViewTableCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelupdateTime;
@property (nonatomic, retain) IBOutlet UILabel *labelLitres;
@property (nonatomic, retain) IBOutlet UILabel *labelPercentage;
@property (nonatomic, retain) IBOutlet UIImageView *imageAlert;
@property (nonatomic, retain) IBOutlet UILabel *labelAlert;

@end
