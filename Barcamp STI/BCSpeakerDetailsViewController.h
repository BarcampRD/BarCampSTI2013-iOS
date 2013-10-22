//
//  BCSpeakerDetailsViewController.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Speaker+Formatters.h"
@interface BCSpeakerDetailsViewController : UITableViewController
@property (strong, nonatomic) Speaker *speaker;
@end
