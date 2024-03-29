//
//  ViewController.m
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Item+Helper.h"
#import "ItemsDataStore.h"
#import "Tag.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>


@interface ViewController ()

@end


@implementation ViewController




- (void)showNavigatonBarButtons
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(addButtonPressed:)];
    
    
    self.navigationItem.rightBarButtonItem = addButton;
  //  self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.navigationItem.titleView setHidden:NO];

    MMDrawerBarButtonItem *drawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(openDrawer:)];
    [self.navigationItem setLeftBarButtonItem:drawerButton];
    
}
- (void)openDrawer:(id)sender
{
    
    MMDrawerController *drawerController = self.mm_drawerController;
    [drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    [self showNavigatonBarButtons];
    [ItemsDataStore sharedStore].tableView = self.tableView;
    
    
    
    
    
    
}

- (void) addButtonPressed:(id)sender {

    
    //Make text field
    CGRect textFieldFrame = CGRectMake(-235.0, 7.0, 230.0, 30.0f);
    insertTextField = [[UITextField alloc]initWithFrame:textFieldFrame];
    
    
    //Format Text field
    insertTextField.placeholder = @"Enter text!";
    insertTextField.backgroundColor = [UIColor whiteColor];
    insertTextField.textColor = [UIColor blackColor];
    insertTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    insertTextField.borderStyle = UITextBorderStyleRoundedRect;
    insertTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    insertTextField.delegate = self;
    insertTextField.returnKeyType = UIReturnKeyGo;
    
    //Make cancel button
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(330, 8.0, 70, 30);
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    //Do something on tap:
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Adding background image
    UIImage *buttonImage = [[UIImage imageNamed:@"CancelButton.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
    
    UIImage *buttonImagePressed = [[UIImage imageNamed:@"CancelButtonPressed.png"] stretchableImageWithLeftCapWidth:5.0 topCapHeight:0.0];
    
    [cancelButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:buttonImagePressed forState:UIControlStateHighlighted];
    
    //Add Cancel button
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationController.navigationBar addSubview:cancelButton];
    
    //Add Insert Text Field
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem.titleView setHidden:YES];
    [self.navigationController.navigationBar addSubview:insertTextField];
    
    [UIView animateWithDuration:0.6 animations:^{
        cancelButton.frame = CGRectMake(243, 8.0, 70, 30);
        insertTextField.frame = CGRectMake(5.0, 7.0, 230.0, 30.0f);
    }];
    
    [insertTextField becomeFirstResponder];
    
//    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"changeTrack" ofType:@"aif"];
//    SystemSoundID soundID;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
//    AudioServicesPlaySystemSound (soundID);
    
    
    
    
    
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
    
    //return [[ItemsDataStore sharedStore] numberOfItemsForSection:section];
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

- (void) filterTableViewForTagSelection:(Tag *) selectedTag
{
    NSLog(@"Do some filterin'");
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY tags == %@",selectedTag];
    [[ItemsDataStore sharedStore] updateFetchedResultsController:predicate];
    [self.tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    Item *object = [[[ItemsDataStore sharedStore] fetchedResultsController] objectAtIndexPath:indexPath];
  
    cell.textLabel.text = object.content;

    cell.detailTextLabel.text = [object returnTagsForItem];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:10]];

    
    NSLog(@"Has Tags: %@", object.hastags);
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
       
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Item *selectedItem = [[[ItemsDataStore sharedStore] fetchedResultsController] objectAtIndexPath:indexPath];
        DetailViewController *dvc = segue.destinationViewController;
        dvc.detailItem = selectedItem;
    }
}
-(void)cancelButtonPressed:(id)sender
{
    [insertTextField endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.6 animations:^
     {
         cancelButton.frame = CGRectMake(330, 8.0, 70, 30);
         textField.frame = CGRectMake(-235.0, 7.0, 230.0, 30.0f);
     }completion:^(BOOL finished)
     {
         [textField removeFromSuperview];
         [cancelButton removeFromSuperview];
         
     }];
    [self showNavigatonBarButtons];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    ItemsDataStore *myStore = [ItemsDataStore sharedStore];
    Item *newItem = [myStore newItem];
    newItem.content = textField.text;
    
    [myStore insertItem:newItem];

    [textField endEditing:YES];
    
       return YES;
}


- (IBAction)segmentedControlChanged:(id)sender {
    
    NSLog(@"Selected: %i", [self.segmentedControl selectedSegmentIndex]);
    NSInteger selectedIndex = [self.segmentedControl selectedSegmentIndex];
    
    NSPredicate *predicate;
    
    if(selectedIndex == 0) // All
    {
    }
    else if(selectedIndex == 1) // With Tags
    {
        predicate = [NSPredicate predicateWithFormat:@"hastags > 0"];
    }
    else if (selectedIndex == 2) // No tags
        
    {
        predicate = [NSPredicate predicateWithFormat:@"hastags = 0"];

    }
    
    [[ItemsDataStore sharedStore] updateFetchedResultsController:predicate];
    [self.tableView reloadData];
    
}
@end
