//
//  SPViewController.m
//  Clock
//
//  Created by Suraj on 16/8/14.
//  Copyright (c) 2014 Su Media. All rights reserved.
//

#import "SPViewController.h"
#import "SPClockView.h"

@interface SPViewController ()

@property (nonatomic, strong) SPClockView *clockView;

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
	_clockView = [[SPClockView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:_clockView];
    _clockView.center = self.view.center;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
