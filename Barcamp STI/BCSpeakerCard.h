//
//  BCSpeakerCard.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Speaker.h"

@interface BCSpeakerCard : UIView

@property (strong, nonatomic) Speaker *speaker;
@property (strong, nonatomic) IBOutlet UIImageView *speakerPhoto;
@property (strong, nonatomic) IBOutlet UILabel *speakerName;

@property (strong, nonatomic) IBOutlet UILabel *twitterHandler;
@property (strong, nonatomic) IBOutlet UITextView *speakerDescription;
- (IBAction)twitterAction:(id)sender;
@end
