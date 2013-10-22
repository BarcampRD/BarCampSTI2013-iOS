//
//  BCAppDelegate.h
//  Barcamp STI
//
//  Created by Vin Rosa on 10/19/13.
//  Copyright (c) 2013 Vin Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
