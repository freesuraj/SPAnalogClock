//
//  SPViewController.m
//  Clock
//
//  Created by Suraj on 16/8/14.
//  Copyright (c) 2014 Su Media. All rights reserved.
//

#import "SPViewController.h"
#import "SPClockView.h"

#define clockViewTag        12345
#define clockLabelTag       23456
#define digitalClockTag     34567
#define xPadding             20
#define yPadding             10

@interface SPViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SPClockView *clockView;
@property (nonatomic, strong) NSMutableArray *timeZones;
@property (nonatomic, strong) NSArray *allTimeZones;

@property (nonatomic, strong) UITableViewController *timeZoneTableViewVC;

@end

@implementation SPViewController

- (void)loadView
{
    [super loadView];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    _timeZones = [NSMutableArray new];
    // add current time zone
    [_timeZones addObject:[NSTimeZone localTimeZone]];
    
    self.timeZoneTableViewVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.timeZoneTableViewVC.tableView.dataSource = self;
    self.timeZoneTableViewVC.tableView.delegate = self;
    _allTimeZones = [NSTimeZone knownTimeZoneNames];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"SPClockView";
    _tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimeZone:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================
#pragma mark - UI Action
//============================================================================
- (void)addTimeZone:(UIBarButtonItem *)sender{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        UIPopoverController *popVC = [[UIPopoverController alloc] initWithContentViewController:_timeZoneTableViewVC];
        [popVC presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    else {
        [self presentViewController:_timeZoneTableViewVC animated:YES completion:^{
        }];
    }
    [_timeZoneTableViewVC.tableView reloadData];
}

//============================================================================
#pragma mark - UITableViewDataSource, UITableViewDelegate
//============================================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ([tableView isEqual:_tableView]) ? _timeZones.count : _allTimeZones.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:_tableView]){
        NSString *CellIdentifier = @"ClockCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            SPClockView *clockView = [[SPClockView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
            [cell.contentView addSubview:clockView];
            clockView.tag = clockViewTag;
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 50, cell.contentView.frame.size.width, 40)];
            name.backgroundColor = [UIColor clearColor];
            name.textAlignment = NSTextAlignmentCenter;
            name.tag = clockLabelTag;
            [cell.contentView addSubview:name];
            
            SPDigitalClock *digitalClock = [[SPDigitalClock alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, 50)];
            digitalClock.tag = digitalClockTag;
            [cell.contentView addSubview:digitalClock];
        }
        NSTimeZone *tz = [self.timeZones objectAtIndex:indexPath.row];
        SPClockView *clockView = (SPClockView *)[cell.contentView viewWithTag:clockViewTag];
        UILabel *clockNameLabel = (UILabel *)[cell.contentView viewWithTag:clockLabelTag];
        SPDigitalClock *digitalClock = (SPDigitalClock *)[cell.contentView viewWithTag:digitalClockTag];
        if([clockNameLabel isKindOfClass:[UILabel class]]){
            clockNameLabel.text = tz.name;
            clockNameLabel.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, 20);
        }
        if(clockView && [clockView isKindOfClass:[SPClockView class]]){
            [clockView setTimeZone:tz];
            clockView.frame = CGRectMake(CGRectGetMidX(cell.contentView.frame)-CGRectGetWidth(clockView.frame)/2, CGRectGetMaxY(clockNameLabel.frame)+yPadding, clockView.frame.size.width, clockView.frame.size.width);
        }
        if(digitalClock && [digitalClock isKindOfClass:[SPDigitalClock class]]){
            [digitalClock setTimeZone:tz];
            digitalClock.frame = CGRectMake(0, CGRectGetMaxY(clockView.frame)+yPadding, cell.contentView.frame.size.width, 30);
        }
        
        return cell;
    }
    else {
        NSString *CellIdentifier = @"TimeZoneCellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.text = [self.allTimeZones objectAtIndex:indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ([tableView isEqual:_tableView]) ? 220.0 : 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else {
        NSString *tzStr = [self.allTimeZones objectAtIndex:indexPath.row];
        [self.timeZones addObject:[NSTimeZone timeZoneWithName:tzStr]];
        [_tableView reloadData];
        [_timeZoneTableViewVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:_tableView]){
         NSTimeZone *tz = [self.timeZones objectAtIndex:indexPath.row];
        [self.timeZones removeObject:tz];
        [_tableView beginUpdates];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_tableView endUpdates];
    }
}


@end
