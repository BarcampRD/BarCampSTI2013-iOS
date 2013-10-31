//
//  BCSpeakerCard.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCSpeakerCard.h"

@implementation BCSpeakerCard
@synthesize speaker = _speaker;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)twitterAction:(id)sender {
    //NSLog(@"%@", self.speaker.twitter);
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]){
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", self.speaker.twitter]]];
    }else{
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:[NSString stringWithFormat:@"https://www.twitter.com/#!/%@", self.speaker.twitter]]];
    }
}
@end
