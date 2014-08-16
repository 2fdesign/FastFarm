//
//  AlertViewTableCell.h
//  FastFarmV01
//
//  Created by Rob Beck on 16/08/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewTableCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelupdateTime;
@property (nonatomic, retain) IBOutlet UILabel *labelAlert;

@end
