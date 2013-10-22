//
//  BCServices.m
//  Barcamp STI
//
//  Created by Vin Rosa on 10/21/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import "BCServices.h"
#import "Speaker.h"
#import "Schedule.h"
#import "BCAppDelegate.h"

@interface BCServices(){
    
}
@property (strong, nonatomic) NSMutableData *data;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(Speaker *)addSpeaker:(NSDictionary *)data;
-(void)addSchedule:(NSDictionary *)data withSpeaker:(Speaker *)speaker;

-(void) deleteObjects:(NSString *) entity;
@end

@implementation BCServices

@synthesize data = _data;
-(NSMutableData *)data{
    if (!_data){
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}


+(BCServices *)instance{
    static BCServices * service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[BCServices alloc] init];
        BCAppDelegate *delegate = [UIApplication sharedApplication].delegate;
        service.managedObjectContext = delegate.managedObjectContext;
    });
    return service;
}

-(void)load{
    [[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://barcamp.vinrosa.com/cms/mobile/info"]] delegate:self] start];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    NSDictionary *data =  [NSJSONSerialization
                           JSONObjectWithData:self.data
                           options:0
                           error:&error];
    
    NSArray *speakers = [[data objectForKey:@"response"] objectForKey:@"speakers"];
    NSArray *schedules = [[data objectForKey:@"response"] objectForKey:@"schedules"];

    NSMutableDictionary * results = [[NSMutableDictionary alloc] init];
    
    
    [self deleteObjects:@"Speaker"];
    for (NSDictionary *dictionary in speakers) {
        Speaker * speaker = [self addSpeaker:[dictionary objectForKey:@"Speaker"]];
        [results setObject:speaker forKey:speaker.identifier];
    }
    
    [self deleteObjects:@"Schedule"];
    for (NSDictionary *dict in schedules) {
        NSDictionary *jschedule = [dict objectForKey:@"Schedule"];
        NSNumber *speakerId = [NSNumber numberWithInteger:[[jschedule objectForKey:@"speaker_id"] integerValue]];
        [self addSchedule:jschedule
              withSpeaker:[results objectForKey:speakerId]
         ];
    }
    
    [self.managedObjectContext save:nil];
}


-(Speaker *)addSpeaker:(NSDictionary *)data {
    Speaker * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Speaker"
                                                       inManagedObjectContext:self.managedObjectContext];
    newEntry.firstName = [data objectForKey:@"first_name"];
    newEntry.lastName = [data objectForKey:@"last_name"];
    newEntry.fdescription = [data objectForKey:@"description"];
    newEntry.identifier = [NSNumber numberWithInt:[[data objectForKey:@"id"] integerValue]];
    newEntry.twitter = [data objectForKey:@"twitter"];
    newEntry.photoUrl = [data objectForKey:@"photo_url"];
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    return newEntry;
}


-(void)addSchedule:(NSDictionary *)data withSpeaker:(Speaker *)speaker{
    Schedule * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Schedule"
                                                        inManagedObjectContext:self.managedObjectContext];
    newEntry.name = [data objectForKey:@"name"];
    newEntry.fdescription = [data objectForKey:@"description"];
    newEntry.identifier = [NSNumber numberWithInt:[[data objectForKey:@"id"] integerValue]];
    newEntry.place = [data objectForKey:@"place"];
    newEntry.schedule = [self parseRFC3339Date:[data objectForKey:@"schedule"]];
    newEntry.speaker = speaker;
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}


- (NSDate *)parseRFC3339Date:(NSString *)dateString
{
    NSDateFormatter *rfc3339TimestampFormatterWithTimeZone = [[NSDateFormatter alloc] init];
    [rfc3339TimestampFormatterWithTimeZone setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [rfc3339TimestampFormatterWithTimeZone setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *theDate = nil;
    NSError *error = nil;
    if (![rfc3339TimestampFormatterWithTimeZone getObjectValue:&theDate forString:dateString range:nil error:&error]) {
        NSLog(@"Date '%@' could not be parsed: %@", dateString, error);
    }
    
    return theDate;
}

        
-(NSArray *)schedules{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Schedule"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

-(NSArray *)speakers{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Speaker"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}

-(void)deleteObjects:(NSString *)entity{
    NSFetchRequest * allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:entity inManagedObjectContext:self.managedObjectContext]];
    [allCars setIncludesPropertyValues:NO]; 
    NSError * error = nil;
    NSArray * cars = [self.managedObjectContext executeFetchRequest:allCars error:&error];
    for (NSManagedObject * car in cars) {
        [self.managedObjectContext deleteObject:car];
    }
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
}

@end
