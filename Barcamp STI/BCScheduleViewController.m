//
//  BCScheduleViewController.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCScheduleViewController.h"
#import "UITableViewController+Theme.h"
#import "BCServices.h"
#import "BCScheduleViewCell.h"
#import "BCScheduleDetailsViewController.h"

@interface BCScheduleViewController ()
@property (strong, nonatomic) NSArray *schedules;
@end

@implementation BCScheduleViewController
@synthesize schedules = _schedules;

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
    [self loadNavBarLogo];
    self.schedules = [[BCServices instance] schedules];
    
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"BCScheduleViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"ScheduleCell"];
    
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(requestReloadInfo) forControlEvents:UIControlEventValueChanged];
    [control setAttributedTitle:[[NSAttributedString alloc] initWithString:@"Cargando..."]];
    self.refreshControl = control;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadInfo) name:@"InfoUpdated" object:nil];
}

-(void) requestReloadInfo{
    [[BCServices instance] load];
}


-(void) reloadInfo{
    NSLog(@"Reloading Info");
    self.schedules = [[BCServices instance] schedules];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.schedules count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Schedule *schedule = [self.schedules objectAtIndex:indexPath.row];
    
    if([cell isKindOfClass:[BCScheduleViewCell class]]){
        BCScheduleViewCell * ocell = (BCScheduleViewCell *)cell;
        ocell.scheduleTitle.text = schedule.name;
        ocell.scheduleDescription.text = schedule.fdescription;
        
        NSDate* date = schedule.schedule;
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
        formatter.timeZone = destinationTimeZone;
        [formatter setDateStyle:NSDateFormatterLongStyle];
        [formatter setDateFormat:@"hh:mm"];
        
        ocell.scheduleTime.text = [formatter stringFromDate:date];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        ocell.scheduleDate.text = [formatter stringFromDate:date];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ScheduleDetails" sender:indexPath];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"ScheduleDetails"]){
        if ([segue.destinationViewController isKindOfClass:[BCScheduleDetailsViewController class]]) {
            ((BCScheduleDetailsViewController *)segue.destinationViewController).schedule = [self.schedules objectAtIndex:[sender row]];
        }
    }

}



@end
