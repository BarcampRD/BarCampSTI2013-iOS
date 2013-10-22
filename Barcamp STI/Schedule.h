//
//  Schedule.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Speaker;

@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fdescription;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSDate * schedule;
@property (nonatomic, retain) Speaker *speaker;

@end
