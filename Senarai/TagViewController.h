//
//  TagViewController.h
//  Senarai
//
//  Created by Basar Akyelli on 10/17/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
@interface TagViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *myCell;
@property (strong,nonatomic) NSString *tagName;
@property (strong,nonatomic) Item *item;
@end
