//
//  BCHomeViewController.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCHomeViewController.h"

@interface BCHomeViewController ()

@end

@implementation BCHomeViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openTwitter:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=barcampsti"]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.twitter.com/#!/barcampsti"]];
    }
}

- (IBAction)openFacebook:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/624957794214604"]];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/barcampsti"]];
    }
}

- (IBAction)openGoogleMaps:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://maps.google.com/maps?q=PUCMM%2CSantiago%2CDominican+Republic"]];
}

- (IBAction)openEventbrite:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://barcampsti.eventbrite.com/"]];
}
@end
