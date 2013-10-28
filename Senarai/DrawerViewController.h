//
//  DrawerViewController.h
//  Senarai
//
//  Created by Basar Akyelli on 10/28/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ItemsDataStore.h"

@interface DrawerViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong,nonatomic) NSFetchedResultsController *tagsFetchedResultsController;


@end
