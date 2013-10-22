//
//  BCScheduleDetailsViewController.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCScheduleDetailsViewController.h"
#import "Speaker+Formatters.h"
#import "UITableViewController+Theme.h"
@interface BCScheduleDetailsViewController ()

@end

@implementation BCScheduleDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.scheduleTitle.text = self.schedule.name;
    self.schedulePlace.text = self.schedule.place;
    self.scheduleSpeaker.text = [self.schedule.speaker fullName];
    self.scheduleDescription.text = self.schedule.fdescription;
    
    [self loadNavBarLogo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
