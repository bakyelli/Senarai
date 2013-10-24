//
//  ViewController.h
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    UITextField *insertTextField;
    UIButton *cancelButton;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (void) addButtonPressed:(id) sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedControlChanged:(id)sender;


@end
