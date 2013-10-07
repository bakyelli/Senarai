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
    
    [ItemsDataStore sharedStore].tableView = self.tableView;
    [ItemsDataStore sharedStore].fetchedResultsController;
    NSLog(@"I Loaded");
}

- (void) addButtonPressed:(id)sender {
    ItemsDataStore *myStore = [ItemsDataStore sharedStore];
   
    Item *newItem = [myStore newItem];
    newItem.content = @"Hello";
    
    [myStore insertItem:newItem];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[ItemsDataStore sharedStore].fetchedResultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Item *object = [[[ItemsDataStore sharedStore] fetchedResultsController] objectAtIndexPath:indexPath];
                    
    cell.textLabel.text = object.content;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *dvc = segue.destinationViewController;
        
        dvc.contentString = [NSString stringWithFormat:@"%i",indexPath.row];
    }
}



@end
