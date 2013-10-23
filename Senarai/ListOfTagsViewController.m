//
//  ListOfTagsViewController.m
//  Senarai
//
//  Created by Basar Akyelli on 10/17/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "ListOfTagsViewController.h"
#import "ItemsDataStore.h"
#import "PieChart.h"

@interface ListOfTagsViewController ()
@end

@implementation ListOfTagsViewController

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
    NSLog(@"MY item is: %@", self.item.content);
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addButtonPressed:)];
    
    
    UIBarButtonItem *tagsChartButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(tagsChartButtonPressed:)];
    
    self.navigationItem.rightBarButtonItems = @[addButton, tagsChartButton];
    
    

    self.tableView.delegate = self;
}

-(void) tagsChartButtonPressed:(id)sender
{
    NSArray *allTags = [self.tagsFetchedResultsController fetchedObjects];
    PieChart *p = [[PieChart alloc]init];
    p.allTags = allTags;
    
    [self.navigationController pushViewController:p animated:YES];
}

- (void) addButtonPressed:(id)sender {
    
    NSLog(@"Add button pressed.");
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Enter Tag Name:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        
          ItemsDataStore *myStore = [ItemsDataStore sharedStore];
         Tag *newTag = [myStore newTag];
        newTag.content = [[alertView textFieldAtIndex:0] text];
         [myStore insertTag:newTag];
    }
    else if(buttonIndex == 0)
    {
    
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Index Path: %i",indexPath.row);
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    Tag *tag = [[self.tagsFetchedResultsController fetchedObjects]objectAtIndex:indexPath.row];

    //NSMutableSet *tagsSet = [self.item.tags mutableCopy];
    
    if(selectedCell.accessoryType == UITableViewCellAccessoryCheckmark)
    {
        //It was already checked. So need to uncheck.
        
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [self.item removeTagsObject:tag];
        
       // [tagsSet removeObject:tag];
        
        
    }
    else if(selectedCell.accessoryType == UITableViewCellAccessoryNone)
    {
        //It wasn't checked, so we need to check.
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [self.item addTagsObject:tag];
        //[tagsSet addObject:tag];
        

    }
    
    
    NSLog(@"%@",tag.content);
    
  //  self.item.tag = (NSSet *)tagsSet;
    
    [[[ItemsDataStore sharedStore] managedObjectContext] save:nil];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    Tag *object = [[self.tagsFetchedResultsController fetchedObjects] objectAtIndex:indexPath.row];
    
    if([self.item.tags containsObject:object])
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
