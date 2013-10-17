//
//  DetailViewController.h
//  Senarai
//
//  Created by Joe Burgess on 10/3/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailViewController : UIViewController
{
    __weak IBOutlet UILabel *bigLabel;
}

@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, strong) Item *detailItem; 
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
