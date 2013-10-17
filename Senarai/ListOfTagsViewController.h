//
//  ListOfTagsViewController.h
//  Senarai
//
//  Created by Basar Akyelli on 10/17/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Item.h"

@interface ListOfTagsViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) NSFetchedResultsController *tagsFetchedResultsController;
@property (strong, nonatomic) Item *item;

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath;
@end
