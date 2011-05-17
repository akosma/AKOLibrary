//
//  AKOCoreDataManager.h
//  AKOLibrary
//
//  Created by Adrian on 4/15/11.
//  Copyright (c) 2009, 2010, 2011, Adrian Kosmaczewski & akosma software
//  All rights reserved.
//  
//  Use in source and/or binary forms without modification is permitted following the
//  instructions in the LICENSE file.
//  
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

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 Encapsulates all interactions with the local Core Data store.
 This singleton class provides a unique interface to modify
 the SQLite data store where all the objects retrieved from the network are stored
 for offline consumption.
 */
@interface AKOCoreDataManager : NSObject 

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, copy) NSString *fileName;

/**
 Returns a pointer to the singleton instance of this class.
 */
+ (AKOCoreDataManager *)sharedAKOCoreDataManager;

/**
 Saves the whole data graph in memory to the SQLite store.
 This method is typically called from the application delegate
 when the application is terminated or sent to the background. It is also called
 repeatedly by the SWDataManager singleton, every time a new object is created.
 */
- (void)save;

/**
 Removes an instance from the data store.
 @param object The object to delete.
 */
- (void)deleteObject:(NSManagedObject *)object;

/**
 Removes all the objects of a specific type.
 @param type The type of objects to delete.
 */
- (void)deleteAllObjectsOfType:(NSString *)type;

/**
 Creates an new instance of the type passed in parameter.
 @param type The type of the new instance.
 @return A new object belonging to the current managed object context.
 */
- (id)createObjectOfType:(NSString *)type;

/**
 Returns a fetch request for the requested type.
 Returns an autoreleased fetch request ready to use, attached
 to the current managed object context.
 @param type The type of the objects researched.
 @return An autoreleased fetch request object.
 */
- (NSFetchRequest *)fetchRequestForType:(NSString *)type;

/**
 Returns a fetched results controller for the fetch request passed as parameter.
 Returns a fetched results controller that can be used to
 drive the contents of a table view.
 @param fetchRequest The fetch request that will be used as a basis for the contents.
 @return An autoreleased fetched results controller.
 */
- (NSFetchedResultsController *)resultsControllerForRequest:(NSFetchRequest *)fetchRequest;

/**
 Callback method to initialize objects when they are inserted.
 This method can be overridden by subclasses to perform individual
 initialization of object when they are inserted in the managed context.
 */
- (void)objectInserted:(NSManagedObject *)object;

/**
 Callback method called when an object is updated.
 This method can be overridden by subclasses to perform individual
 operations on an object when they are updated in the managed context.
 */
- (void)objectUpdated:(NSManagedObject *)object;

/**
 Callback method called when an object is deleted.
 This method can be overridden by subclasses to perform individual
 operations on an object when they are deleted from the managed context.
 */
- (void)objectDeleted:(NSManagedObject *)object;

@end
