//
//  AKOCoreDataManager.m
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  Redistributions of source code must retain the above copyright notice, this list 
//  of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
//  list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  Neither the name of the akosma software nor the names of its contributors may be 
//  used to endorse or promote products derived from this software without specific 
//  prior written permission.
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED 
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AKOCoreDataManager.h"
#import "SynthesizeSingleton.h"
#import "AKOFileSystemManager.h"

@interface AKOCoreDataManager ()

@property (nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation AKOCoreDataManager

SYNTHESIZE_SINGLETON_FOR_CLASS(AKOCoreDataManager)

@synthesize fileName = _fileName;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectContext = _managedObjectContext;

- (id)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(objectChanged:) 
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [_fileName release];

    [super dealloc];
}

#pragma mark - Public methods

- (void)save
{
    if (_managedObjectContext != nil) 
    {
        NSError *error = nil;
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) 
        {
            abort();
        } 
    }
}

- (void)deleteObject:(NSManagedObject *)object
{
    [self.managedObjectContext deleteObject:object];
    [self save];
}

- (id)createObjectOfType:(NSString *)type
{
    NSManagedObject *instance = [NSEntityDescription insertNewObjectForEntityForName:type
                                                              inManagedObjectContext:self.managedObjectContext];

    return instance;
}

- (void)deleteAllObjectsOfType:(NSString *)type
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:type
                                              inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entity];
    NSArray *objects = [self.managedObjectContext executeFetchRequest:request error:nil];
    for (id obj in objects)
    {
        [self.managedObjectContext deleteObject:obj];
    }
}

- (NSFetchRequest *)fetchRequestForType:(NSString *)type
{
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:type
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    return fetchRequest;
}

- (NSFetchedResultsController *)resultsControllerForRequest:(NSFetchRequest *)fetchRequest
{
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *controller = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                                  managedObjectContext:self.managedObjectContext 
                                                                                    sectionNameKeyPath:nil
                                                                                             cacheName:@"Root"] autorelease];
    return controller;
}

#pragma mark - NSNotification handlers

- (void)objectChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSSet *insertedObjects = [userInfo objectForKey:NSInsertedObjectsKey];
    for (id obj in insertedObjects)
    {
        [self objectInserted:obj];
    }
    
    NSSet *updatedObjects = [userInfo objectForKey:NSUpdatedObjectsKey];
    for (id obj in updatedObjects)
    {
        [self objectUpdated:obj];
    }

    NSSet *deletedObjects = [userInfo objectForKey:NSDeletedObjectsKey];
    for (id obj in deletedObjects)
    {
        [self objectDeleted:obj];
    }
}

- (void)objectInserted:(NSManagedObject *)object
{
//    [object setCreationDate:[NSDate date]];
}

- (void)objectUpdated:(NSManagedObject *)object
{
//    [object setModificationDate:[NSDate date]];
}

- (void)objectDeleted:(NSManagedObject *)object
{
}

#pragma mark - Private methods

- (NSManagedObjectContext *)managedObjectContext 
{
    if (_managedObjectContext != nil) 
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) 
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel 
{
    if (_managedObjectModel != nil) 
    {
        return _managedObjectModel;
    }
    
    NSAssert(self.fileName, @"The fileName ivar cannot be nil");

    NSString *modelPath = [[NSBundle mainBundle] pathForResource:self.fileName
                                                          ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
    if (_persistentStoreCoordinator != nil) 
    {
        return _persistentStoreCoordinator;
    }
    
    NSAssert(self.fileName, @"The fileName ivar cannot be nil");

    NSString *docs = [AKOFileSystemManager sharedAKOFileSystemManager].applicationDocumentsDirectory;
    NSString *file = [NSString stringWithFormat:@"%@.sqlite", self.fileName];
    NSString *path = [docs stringByAppendingPathComponent:file];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    
    // Set up automatic migration options
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, 
                             nil];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                                   configuration:nil
                                                             URL:storeURL 
                                                         options:options
                                                           error:&error]) 
    {
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

@end
