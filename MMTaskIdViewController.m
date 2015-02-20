//
//  MMTaskIdViewController.m
//  Auto Code
//
//  Created by Thiruppathi Gandhi on 2/10/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "MMTaskIdViewController.h"
#import "MMTaskList.h"
#import "MMTask.h"
#import "AppDelegate.h"
#import "MMTaskDescViewController.h"
#import "MMTaskList+MMTaskList_Customization.h"

@interface MMTaskIdViewController ()

@property (nonatomic,strong) MMTaskDescViewController *taskDescViewController;
@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;

@end

@implementation MMTaskIdViewController

@synthesize taskList = _taskList;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize taskDescViewController = _taskDescViewController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"List Contents";
    [self createScreen];
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.taskList.tasks.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    // Configure the cell...
    MMTask * currentTask = [[self.taskList sortedTask] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentTask.details;
    
    return cell;
}


- (void) createScreen
{
    // UIBarButtonItem *newListButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:target:self action:@selector(addList:)];
    UIBarButtonItem *newTaskButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask:)];
    
    self.navigationItem.rightBarButtonItem = newTaskButton;
}


- (MMTaskDescViewController*) taskDescViewController
{
    if(!_taskDescViewController){
        
        _taskDescViewController = [[MMTaskDescViewController alloc] init];
    }
    
    return _taskDescViewController;
}

-(void)addTask:(UIBarButtonItem *)sender{
    
    MMTask *newTask = [NSEntityDescription insertNewObjectForEntityForName:@"MMTask" inManagedObjectContext:self.managedObjectContext];
    
    newTask.created = [NSDate date];
    newTask.details = [NSString stringWithFormat:@"Task Id %lu",(unsigned long)self.taskList.tasks.count];
    
    newTask.list = self.taskList;
    
    [self.managedObjectContext save:nil];
    
    [self.tableView reloadData];
    
    //perform your action
    //[self.navigationController pushViewController:self.taskIdViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //perform your action
    
    self.taskDescViewController.task = [[self.taskList sortedTask] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.taskDescViewController animated:YES];
    
}

- (NSManagedObjectContext*) managedObjectContext {
    
    return [(AppDelegate*) [[UIApplication sharedApplication] delegate] managedObjectContext];
    
}

@end
