//
//  ViewController.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 12.01.16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "ViewController.h"

#import "LTCalendarView.h"

@interface ViewController ()

@property (nonatomic, strong) LTCalendarView *calendar;

@end

@implementation ViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    self.view = self.calendar;
}

- (LTCalendarView *)calendar {
    if (!_calendar) {
        _calendar = [[LTCalendarView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _calendar;
}

#pragma mark - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_calendar setFrame:[UIScreen mainScreen].bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
