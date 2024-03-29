//
//  ItemsDataStore.h
//  Senarai
//
//  Created by Joe Burgess on 10/7/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Tag.h"

@class Item;

@interface ItemsDataStore : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//- (NSFetchedResultsController *)fetchedResultsController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
-(void)updateFetchedResultsController:(NSPredicate *)predicate;

@property (strong, nonatomic) NSFetchedResultsController *tagsFetchedResultsController;
@property (strong, nonatomic) UITableView *tableView;

+ (ItemsDataStore *)sharedStore;

@property (strong,nonatomic) NSPredicate *myPredicate;

- (Item *)newItem;
- (Tag *)newTag;
- (void) insertItem:(Item *)insertItem;
- (void)insertTag:(Tag *)insertItem; 
- (void) deleteItemAtIndexPath: (NSIndexPath *)indexPath;
- (NSInteger) numberOfItemsForSection:(NSInteger)section;
- (Item *)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
