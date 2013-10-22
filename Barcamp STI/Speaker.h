//
//  Speaker.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/22/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Schedule;

@interface Speaker : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * fdescription;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSOrderedSet *schedules;
@end

@interface Speaker (CoreDataGeneratedAccessors)

- (void)insertObject:(Schedule *)value inSchedulesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSchedulesAtIndex:(NSUInteger)idx;
- (void)insertSchedules:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSchedulesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSchedulesAtIndex:(NSUInteger)idx withObject:(Schedule *)value;
- (void)replaceSchedulesAtIndexes:(NSIndexSet *)indexes withSchedules:(NSArray *)values;
- (void)addSchedulesObject:(Schedule *)value;
- (void)removeSchedulesObject:(Schedule *)value;
- (void)addSchedules:(NSOrderedSet *)values;
- (void)removeSchedules:(NSOrderedSet *)values;
@end
