//
//  MMTaskDescViewController.m
//  Auto Code
//
//  Created by Thiruppathi Gandhi on 2/10/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "MMTaskDescViewController.h"
#import "MMTask.h"
#import "AppDelegate.h"

@interface MMTaskDescViewController ()

@property (readonly) UITextField *taskDescField;
@property (readonly) UIButton *saveButton;
@property (readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation MMTaskDescViewController

@synthesize task = _task;
@synthesize taskDescField = _taskDescField;
@synthesize saveButton = _saveButton;
@synthesize managedObjectContext= _managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Task Description";
    //self.view.backgroundColor = [UIColor blackColor];
    self.taskDescField.text = self.task.details;
    [self createScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
    
    return (YES);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    //[self.loginButton setImage:[UIImage imageNamed:U1C_IMAGE_LOGIN_ACTIVE ] forState: UIControlStateNormal];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing
{
    return (YES);
}

- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or
{
 
}

- (NSManagedObjectContext*) managedObjectContext {
    
    return [(AppDelegate*) [[UIApplication sharedApplication] delegate] managedObjectContext];
    
}

- (void) textFieldDidChange: (id) sender
{
    self.task.details = self.taskDescField.text;
    [self.managedObjectContext save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return TRUE;
}

- (UITextField*) taskDescField {
    
    if(!_taskDescField){
        
        _taskDescField = [[UITextField alloc] init] ;
        
        _taskDescField.borderStyle = UITextBorderStyleRoundedRect;
        _taskDescField.textColor = [UIColor blackColor];
        _taskDescField.backgroundColor = [UIColor clearColor];
        _taskDescField.autocorrectionType = UITextAutocorrectionTypeNo;
        _taskDescField.keyboardType = UIKeyboardTypeDefault;
        _taskDescField.autocapitalizationType = UITextAutocapitalizationTypeNone;
         _taskDescField.returnKeyType = UIReturnKeyDone;
        _taskDescField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _taskDescField.clearButtonMode = UITextFieldViewModeAlways;
       // _taskDescField.placeholder = NSLocalizedString(@"username_watermark", nil) ;
        _taskDescField.delegate = self;
        _taskDescField.userInteractionEnabled = YES;
        [_taskDescField setTranslatesAutoresizingMaskIntoConstraints:NO];
      //  [_taskDescField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _taskDescField;
}

-(UIButton*) saveButton{
    if(!_saveButton){
        _saveButton = [[UIButton alloc] init];
        [_saveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [_saveButton setTitleColor: [UIColor redColor] forState:UIControlStateNormal];
        [_saveButton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchDown];
    }
    return _saveButton;
}


- (void) createScreen
{
    [self.view addSubview:self.taskDescField];
    [self.view addSubview:self.saveButton];
    
    NSDictionary *elementDict = NSDictionaryOfVariableBindings(_taskDescField,_saveButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(<=100)-[_taskDescField(50)]-(50)-[_saveButton]-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:elementDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_taskDescField]-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:elementDict]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_saveButton]-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:elementDict]];
    
}


@end
