//
//  AlertViewTableCell.m
//  FastFarmV01
//
//  Created by Rob Beck on 16/08/14.
//  Copyright (c) 2014 2fDesign Ltd. All rights reserved.
//

#import "AlertViewTableCell.h"

@implementation AlertViewTableCell

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
