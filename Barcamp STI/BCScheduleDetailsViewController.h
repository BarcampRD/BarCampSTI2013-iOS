//
//  BCScheduleDetailsViewController.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"

@interface BCScheduleDetailsViewController : UITableViewController

@property (strong, nonatomic) Schedule *schedule;
@property (strong, nonatomic) IBOutlet UILabel *scheduleTitle;
@property (strong, nonatomic) IBOutlet UILabel *schedulePlace;
@property (strong, nonatomic) IBOutlet UILabel *scheduleSpeaker;
@property (strong, nonatomic) IBOutlet UITextView *scheduleDescription;

@end
