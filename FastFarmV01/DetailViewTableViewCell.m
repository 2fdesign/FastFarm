//
//  DetailViewTableViewCell.m
//  FastFarmV01
//
//  Created by Rob Beck on 18/08/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "DetailViewTableViewCell.h"

@implementation DetailViewTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
