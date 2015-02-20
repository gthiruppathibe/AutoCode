//
//  MMTask.h
//  CoreData
//
//  Created by Thiruppathi Gandhi on 2/9/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MMTask : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSManagedObject *list;

@end
