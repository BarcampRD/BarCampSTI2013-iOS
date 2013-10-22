//
//  Speaker+Formatters.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "Speaker+Formatters.h"

@implementation Speaker (Formatters)
-(NSString *)fullName{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}
@end
