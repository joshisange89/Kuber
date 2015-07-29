//
//  FilterTableViewController.m
//  Kuber
//
//  Created by Santa on 7/27/15.
//  Copyright (c) 2015 Kubercube. All rights reserved.
//

#import "FilterTableViewController.h"
#import "Layout.h"
@interface FilterTableViewController ()

@property (strong, nonatomic) NSArray *filterArray;

@end

@implementation FilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title = @"Filter";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    self.tableView.tableFooterView = [UIView new];//To eliminate extra separator below TableView

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(NSArray*)filterArray
{
    if (_filterArray != nil)
        return _filterArray;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Filters"
                                                     ofType:@"plist"];
    _filterArray = [[NSArray alloc]
                          initWithContentsOfFile:path];
    return _filterArray;
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.filterArray objectAtIndex:section] valueForKey:@"FilterType"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.filterArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[self.filterArray objectAtIndex:section] valueForKey:@"Values"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [Layout colorGrey];
    cell.textLabel.text = [[[self.filterArray objectAtIndex:indexPath.section]valueForKey:@"Values"] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
