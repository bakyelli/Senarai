//
//  DetailViewController.m
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    bigLabel.text = self.detailItem.content;
    self.navigationItem.title = @"Item Detail";
   
    //UITableViewCell *myTagCell = (UITableViewCell *)[self.tagTableView viewWithTag:1];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    //UITableViewCell *myTagCell = [self.tagTableView cellForRowAtIndexPath:indexPath];
//    //self.myCell.textLabel.text = @"HELLOOOO";
//    
//   // UITableViewCell *myCell = [self.tagTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    self.myCell.textLabel.text = @"HELLOO";
//   // myTagCell.textLabel.text = @"HELLO WORLD";
    
 //   self.tagTableView.delegate = self;
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
@end
