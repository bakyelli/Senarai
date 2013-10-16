//
//  ItemsDataStore.h
//  Senarai
//
//  Created by Joe Burgess on 10/7/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface ItemsDataStore : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) UITableView *tableView;

+ (ItemsDataStore *)sharedStore;

- (Item *)newItem;
- (void) insertItem:(Item *)insertItem;
- (void) deleteItemAtIndexPath: (NSIndexPath *)indexPath;
- (NSInteger) numberOfItemsForSection:(NSInteger)section;
- (Item *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
