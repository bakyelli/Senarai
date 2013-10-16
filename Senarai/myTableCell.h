//
//  myTableCell.h
//  Senarai
//
//  Created by Joe Burgess on 10/15/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@end
