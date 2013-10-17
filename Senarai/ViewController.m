//
//  ViewController.m
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Item.h"
#import "ItemsDataStore.h"
#import "Tag.h"

@interface ViewController ()

@end


@implementation ViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addButtonPressed:)];
    
    
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [ItemsDataStore sharedStore].tableView = self.tableView;
//    Tag *newTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:[ItemsDataStore sharedStore].managedObjectContext];
//    
//    newTag.content = @"myTag!";
//   
//    NSArray *items = [ItemsDataStore sharedStore].fetchedResultsController.fetchedObjects;
//    Item *firstItem = [items firstObject];
//    firstItem.tag = newTag;
    
    NSLog(@"I Loaded");
}

- (void) addButtonPressed:(id)sender {
    ItemsDataStore *myStore = [ItemsDataStore sharedStore];
   
    Item *newItem = [myStore newItem];
    newItem.content = @"Helloasdf";
    
    [myStore insertItem:newItem];
    
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[ItemsDataStore sharedStore] numberOfItemsForSection:section];
    
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
        [[ItemsDataStore sharedStore] deleteItemAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Item *object = [[ItemsDataStore sharedStore] itemAtIndexPath:indexPath];
    
    cell.textLabel.text = object.content;
    cell.detailTextLabel.text = object.tag.content;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *selectedItem = [[ItemsDataStore sharedStore] itemAtIndexPath:indexPath];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.detailItem = selectedItem;
    }
}


@end
