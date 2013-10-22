//
//  BCSpeakersViewController.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCSpeakersViewController.h"
#import "BCSpeakerDetailsViewController.h"
#import "UITableViewController+Theme.h"
#import "UIImageView+WebCache.h"

#import "BCServices.h"

@interface BCSpeakersViewController ()
@property (strong, nonatomic) NSArray *speakers;
@end

@implementation BCSpeakersViewController

@synthesize  speakers = _speakers;

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
    
    self.speakers = [[BCServices instance] speakers];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];

    
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
    return [self.speakers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeakerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Speaker *speaker = [self.speakers objectAtIndex:indexPath.row];
    cell.textLabel.text = speaker.fullName;
    cell.detailTextLabel.text = speaker.fdescription;
    cell.detailTextLabel.numberOfLines = 3;
    cell.indentationWidth = 10;
    [cell.imageView setImageWithURL:[NSURL URLWithString:speaker.photoUrl] placeholderImage:[UIImage imageNamed:@"ic_user.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"SpeakerDetails" sender:indexPath];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SpeakerDetails"]){
        if ([segue.destinationViewController isKindOfClass:[BCSpeakerDetailsViewController class]]) {
            ((BCSpeakerDetailsViewController *)segue.destinationViewController).speaker = [self.speakers objectAtIndex:[sender row]];
        }
    }
}



@end
