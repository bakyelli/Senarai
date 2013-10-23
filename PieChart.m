//
//  PieChart.m
//  Senarai
//
//  Created by Basar Akyelli on 10/22/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "PieChart.h"
#import "Tag.h"
@implementation PieChart

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pieChart setDataSource:self];
    
    [self.pieChart setStartPieAngle:M_PI_2];
    [self.pieChart setAnimationSpeed:1.0];
    [self.pieChart setLabelFont:[UIFont fontWithName:@"Helvetica" size:24]];
    [self.pieChart setLabelRadius:160];
    [self.pieChart setShowPercentage:NO];
    [self.pieChart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieChart setUserInteractionEnabled:YES];
    [self.pieChart setLabelShadowColor:[UIColor blackColor]];
    [self.pieChart setDelegate:self];
    [self.pieChart reloadData];
    
    [self setTitle:@"Tags - Pie Chart"];
}

#pragma mark - XYPieChart stuff

-(NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return [self.allTags count];
    
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index{
    
    Tag *t = [self.allTags objectAtIndex:index];
    return [t.items count];
    

}

- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    Tag *selectedTag = [self.allTags objectAtIndex:index];
    self.lblTagName.text = selectedTag.content;
    

}

@end
