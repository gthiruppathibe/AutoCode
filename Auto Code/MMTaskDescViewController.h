//
//  MMTaskDescViewController.h
//  Auto Code
//
//  Created by Thiruppathi Gandhi on 2/10/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMTask;

@interface MMTaskDescViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong) MMTask * task;
@end
