//
//  ARKAppDelegate.h
//  sunriseAppSystem
//
//  Created by Nicholas Piano on 29/03/2014.
//  Copyright (c) 2014 Nicholas Piano. All rights reserved.
//

#import <UIKit/UIKit.h>

//view controllers
#import "ARKMainViewController.h"

@interface ARKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
