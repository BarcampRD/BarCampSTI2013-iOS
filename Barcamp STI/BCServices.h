//
//  BCServices.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Speaker.h"
#import "Schedule.h"
#import "Speaker+Formatters.h"

@interface BCServices : NSObject<NSURLConnectionDataDelegate>

+(BCServices *) instance;

-(void) load;
-(NSArray *) speakers;
-(NSArray *) schedules;
@end
