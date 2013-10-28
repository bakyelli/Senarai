//
//  ViewController.h
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import "Tag.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *insertTextField;
    UIButton *cancelButton;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) MMDrawerController *drawerController;
@property BOOL showSelectedTagOnly;
@property (strong, nonatomic) Tag *selectedTag;


- (void) filterTableViewForTagSelection:(Tag *) selectedTag;
- (void) addButtonPressed:(id) sender;
- (IBAction)segmentedControlChanged:(id)sender;


@end
