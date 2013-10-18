//
//  Item+Helper.m
//  Senarai
//
//  Created by Basar Akyelli on 10/18/13.
//  Copyright (c) 2013 Joe Burgess. All rights reserved.
//

#import "Item+Helper.h"
#import "Tag.h"
@implementation Item (Helper)

-(NSMutableString *)returnTagsForItem
{
    
    NSMutableString *tagsString = [[NSMutableString alloc]init];
    for(Tag *t in self.tags)
    {
        [tagsString appendString:@"["];
        [tagsString appendString:t.content];
        [tagsString appendString:@"]"];
        
    }
    return tagsString;
    
}

@end
