//
//  BCSpeakerTableViewCell.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCSpeakerTableViewCell.h"

@implementation BCSpeakerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    //self.imageView.frame = CGRectInset(self.imageView.frame, 5, 5);
    
    self.imageView.frame = CGRectMake(10, 10, 67, 67);
    self.imageView.bounds = self.imageView.frame;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    CGRect frame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(87, frame.origin.y, frame.size.width, frame.size.height);
    frame = self.detailTextLabel.frame;
    self.detailTextLabel.frame = CGRectMake(87, frame.origin.y, frame
                                            .size.width, frame.size.height);
    
    self.indentationWidth = 87;
}

@end
