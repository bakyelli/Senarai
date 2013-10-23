//
//  PieChart.h
//  Senarai
//
//  Created by Basar Akyelli on 10/22/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XYPieChart.h>

@interface PieChart : UIViewController <XYPieChartDataSource, XYPieChartDelegate>
@property (weak, nonatomic) IBOutlet XYPieChart *pieChart;
@property (weak, nonatomic) NSArray *allTags;
@property (weak, nonatomic) IBOutlet UILabel *lblTagName;


@end
