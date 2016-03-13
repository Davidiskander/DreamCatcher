//
//  DetailViewController.m
//  Dream Catcher
//
//  Created by David Iskander on 3/12/16.
//  Copyright © 2016 DIskander. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.descriptionString;
    self.title = self.titleString;
    
}


@end
