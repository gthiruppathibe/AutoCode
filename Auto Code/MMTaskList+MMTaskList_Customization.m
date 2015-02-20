//
//  MMTaskList+MMTaskList_Customization.m
//  CoreData
//
//  Created by Thiruppathi Gandhi on 2/9/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "MMTaskList+MMTaskList_Customization.h"
#import "MMTask.h"

@implementation MMTaskList (MMTaskList_Customization)

-(NSArray*) sortedTask {
    
    return [self.tasks.allObjects sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[(MMTask*) obj1 created] compare:[(MMTask*) obj2 created]];
    }];
        
}

@end
