//
//  Item.h
//  Senarai
//
//  Created by Joe Burgess on 10/4/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSDate * completed;

@end
