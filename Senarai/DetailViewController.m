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
    bigLabel.text = self.contentString;
    self.navigationItem.title = self.contentString;
}
@end
