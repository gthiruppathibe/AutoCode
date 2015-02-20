//
//  MMTaskListViewController.m
//  Auto Code
//
//  Created by Thiruppathi Gandhi on 2/10/15.
//  Copyright (c) 2015 Mutual Mobile. All rights reserved.
//

#import "MMTaskListViewController.h"
#import "MMTaskIdViewController.h"
#import "AppDelegate.h"
#import "MMTaskList.h"

@interface MMTaskListViewController ()

@property (nonatomic,strong) MMTaskIdViewController *taskIdViewController;
@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) NSArray *lists;

@end

@implementation MMTaskListViewController

//@synthesize taskListTableView =_taskListTableView;
@synthesize taskIdViewController = _taskIdViewController;
@synthesize lists = _lists;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Task List";
    [self createScreen];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MMTaskList"];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
    
    NSString *firstName = @"Task List 0";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"title like %@",firstName];
    [fetchRequest setPredicate:predicate];
   
    
    self.lists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext*) managedObjectContext {
    
    return [(AppDelegate*) [[UIApplication sharedApplication] delegate] managedObjectContext];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    // Configure the cell...
    MMTaskList * currentList = [self.lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentList.title;
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.managedObjectContext deleteObject:[self.lists objectAtIndex:indexPath.row]];
        [self.managedObjectContext save:nil];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MMTaskList"];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
        
        self.lists = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //perform your action
    self.taskIdViewController.taskList = [self.lists objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.taskIdViewController animated:YES];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

- (void) createScreen
{
   // UIBarButtonItem *newListButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:target:self action:@selector(addList:)];
    UIBarButtonItem *newListButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addList:)];

    self.navigationItem.rightBarButtonItem = newListButton;
}

- (MMTaskIdViewController*) taskIdViewController{
    
    if(!_taskIdViewController)
    {
        _taskIdViewController = [[MMTaskIdViewController alloc] init];
    }
    return _taskIdViewController;
}

-(void)addList:(UIBarButtonItem *)sender{
    
    MMTaskList *newList = [NSEntityDescription insertNewObjectForEntityForName:@"MMTaskList" inManagedObjectContext:self.managedObjectContext];
    
    newList.created = [NSDate date];
    newList.title = [NSString stringWithFormat:@"Task List %lu",(unsigned long)self.lists.count];
    
    [self.managedObjectContext save:nil];
    
    self.lists = [self.lists arrayByAddingObject:newList];
    
    [self.tableView reloadData];
    
    //perform your action
    //[self.navigationController pushViewController:self.taskIdViewController animated:YES];
    
}


@end
