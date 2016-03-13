//
//  ViewController.m
//  Dream Catcher
//
//  Created by David Iskander on 3/12/16.
//  Copyright © 2016 DIskander. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *titles;
@property NSMutableArray *descriptons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];
    self.descriptons = [[NSMutableArray alloc]init]; //why did we create an alloc[init] ??

}


// Steup the adding dream pop-up
- (void)presentDreamEntry {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter New Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Title Dream";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Description";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField1 = alertController.textFields.firstObject;
        [self.titles addObject:textField1.text];
        [self.descriptons addObject:alertController.textFields.lastObject.text ];
        [self.tableView reloadData];
    }];
    [alertController addAction:saveAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}



// Setup the format of the row of each dream
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptons objectAtIndex:indexPath.row];
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}


// The (Edit) button
- (IBAction)onEdit:(UIBarButtonItem *)sender {
    if (self.editing == YES){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }
    else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
}

// Method to enable moving rows
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

// Method to move rows around
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *title = [self.titles objectAtIndex:sourceIndexPath.row];
    [self.titles removeObject:title];
    [self.titles insertObject:title atIndex:sourceIndexPath.row];
    NSString *description = [self.descriptons objectAtIndex:sourceIndexPath.row];
    [self.descriptons removeObject:description];
    [self.descriptons insertObject:description atIndex:sourceIndexPath.row];
}

// The (+) button
- (IBAction)onAddPressed:(id)sender {
    [self presentDreamEntry];
}


// Setup the detailed view controller screen
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *dvc = segue.destinationViewController;
    dvc.titleString = [self.titles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    dvc.descriptionString = [self.descriptons objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}


// Deleting a dream from the dream list
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.descriptons removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];

}



@end




















