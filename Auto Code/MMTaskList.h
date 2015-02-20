//
//  MMTaskList.h
//  CoreData
//
//  Created by Thiruppathi Gandhi on 2/9/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MMTask;

@interface MMTaskList : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface MMTaskList (CoreDataGeneratedAccessors)

- (void)addTasksObject:(MMTask *)value;
- (void)removeTasksObject:(MMTask *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
