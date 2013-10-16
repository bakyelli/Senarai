//
//  myTableCell.m
//  Senarai
//
//  Created by Joe Burgess on 10/15/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "myTableCell.h"

@interface myTableCell ()



- (IBAction)DisableStepper:(id)sender;
- (IBAction)stepperChanged:(id)sender;

@end

@implementation myTableCell

- (IBAction)DisableStepper:(id)sender {
}

- (IBAction)stepperChanged:(id)sender {
    
    NSLog(@"Changed Stepper:%f",self.myStepper.value);
}


@end
