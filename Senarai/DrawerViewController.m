//
//  DrawerViewController.m
//  Senarai
//
//  Created by Basar Akyelli on 10/28/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "DrawerViewController.h"
#import <UIViewController+MMDrawerController.h>
#import <MMDrawerController.h>
#import "ViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Choose Tag";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tag *object = [[self.tagsFetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    MMDrawerController *drawerController = self.mm_drawerController;
    
    UINavigationController *navController = (UINavigationController *) drawerController.centerViewController;
    ViewController *vc = (ViewController *) navController.childViewControllers[0];
    
    [vc filterTableViewForTagSelection:object];
    
    [drawerController closeDrawerAnimated:YES completion:nil];

    
}
#pragma mark - Tags NSFetchedResultsController Stack

- (NSFetchedResultsController *)tagsFetchedResultsController {
    if (_tagsFetchedResultsController != nil) {
        return _tagsFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:[ItemsDataStore sharedStore].managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"content" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    
    NSFetchedResultsController *myFetchedResultsController =
    [[NSFetchedResultsController alloc]
     initWithFetchRequest:fetchRequest
     managedObjectContext:[ItemsDataStore sharedStore].managedObjectContext
     sectionNameKeyPath:nil
     cacheName:@"Tag"];
    
    _tagsFetchedResultsController = myFetchedResultsController;
    _tagsFetchedResultsController.delegate = self;
    [_tagsFetchedResultsController performFetch:nil];
    
    return _tagsFetchedResultsController;
    
}

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"controller will change content");
    [self.tableView beginUpdates];
}

- (void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (type == NSFetchedResultsChangeInsert) {
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (type==NSFetchedResultsChangeMove){
        
    }
}




- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.tagsFetchedResultsController fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Tag *object = [[self.tagsFetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    cell.textLabel.text = object.content;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return  YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"asdf");
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteItemAtIndexPath:indexPath];
    }
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"DeleteItemAtIndexPath");
    NSManagedObjectContext *context = [ItemsDataStore sharedStore].managedObjectContext;
    Tag *itemToBeDeleted = [self.tagsFetchedResultsController objectAtIndexPath:indexPath];
    [context deleteObject:itemToBeDeleted];
    [context save:nil];
    
}


@end
