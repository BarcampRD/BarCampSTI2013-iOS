//
//  BCSpeakerDetailsViewController.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCSpeakerDetailsViewController.h"
#import "UITableViewController+Theme.h"
#import "Schedule.h"
#import "BCScheduleViewCell.h"
#import "BCSpeakerCard.h"
#import "UIImageView+WebCache.h"
#import "BCScheduleDetailsViewController.h"

@interface BCSpeakerDetailsViewController ()
@property (strong, nonatomic) BCSpeakerCard *card;
@end

@implementation BCSpeakerDetailsViewController
@synthesize speaker = _speaker;
@synthesize card = _card;
-(BCSpeakerCard *)card{
    if (!_card){
        _card = [[[NSBundle mainBundle] loadNibNamed:@"BCSpeakerCard" owner:self options:nil] lastObject];
    }
    return _card;
}

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
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"BCScheduleViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"ScheduleCell"];
    self.card.speakerName.text = [self.speaker fullName];
    self.card.speakerDescription.text = self.speaker.fdescription;
    self.card.twitterHandler.text = [NSString stringWithFormat:@"/@%@", self.speaker.twitter];
    [self.card.speakerPhoto setImageWithURL:[NSURL URLWithString:self.speaker.photoUrl]
                           placeholderImage:[UIImage imageNamed:@"ic_user.jpg"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.speaker.schedules count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ScheduleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        NSLog(@" nil");
    }
    
    Schedule *schedule = [self.speaker.schedules objectAtIndex:indexPath.row];
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
    
    //Schedule * schedule = [self.speaker.schedules objectAtIndex:indexPath.row];
    //cell.textLabel.text = schedule.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.card;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.card.frame.size.height;
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
            ((BCScheduleDetailsViewController *)segue.destinationViewController).schedule = [self.speaker.schedules objectAtIndex:[sender row]];
        }
    }
}

@end
