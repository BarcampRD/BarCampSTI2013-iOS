//
//  BCScheduleViewCell.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELL_HEIGHT  130
@interface BCScheduleViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *scheduleTime;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTitle;
@property (strong, nonatomic) IBOutlet UILabel *scheduleDescription;
@property (strong, nonatomic) IBOutlet UILabel *scheduleDate;
@end
