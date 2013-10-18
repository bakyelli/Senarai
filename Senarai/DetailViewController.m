//
//  DetailViewController.m
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "DetailViewController.h"
#import "TagViewController.h"
#import "Tag.h"

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    bigLabel.text = self.detailItem.content;
    self.navigationItem.title = @"Item Detail";
    
//
//    UITableViewController *tbl = (UITableViewController *)[self.childViewControllers lastObject];
//    UITableView *tableView = (UITableView *)tbl.view;
//    
//    
//    NSLog(@"%i", [tableView numberOfRowsInSection:0]);
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = @"JAMES AND BASAR RULE";
//    //cell.detailTextLabel.text = @"HAHAH";
    

}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = @"HELLO";
//    
//     return cell;
//}
//
//-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1; 
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSLog(@"Prepare for Segue");
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"tagSegue"]) {

        TagViewController *dvc = segue.destinationViewController;
        dvc.item = self.detailItem;
    
    }
}



@end
