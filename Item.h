//
//  Item.h
//  Senarai
//
//  Created by Basar Akyelli on 10/18/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tag;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSDate * completed;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSSet *tags;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addTagsObject:(Tag *)value;
- (void)removeTagsObject:(Tag *)value;
- (void)addTags:(NSSet *)values;
- (void)removeTags:(NSSet *)values;

@end
