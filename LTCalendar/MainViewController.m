//
//  MainViewController.m
//  LTCalendar
//
//  Created by Pavel Razuvaev on 19/04/16.
//  Copyright © 2016 Pavel Razuvaev. All rights reserved.
//

#import "MainViewController.h"
#import "LTCalendarView.h"

@interface MainViewController ()

@property (nonatomic, strong) LTCalendarView *calendarView;

@end

@implementation MainViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    [self setupUI];
}

#pragma mark - SetupUI
- (void)setupNavBar {
    self.title = @"Calendar";
}

- (void)setupUI {
    self.view = self.calendarView;
}

- (LTCalendarView *)calendarView {
    if (!_calendarView) {
        _calendarView = [[LTCalendarView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _calendarView;
}

#pragma mark - Layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_calendarView setFrame:[UIScreen mainScreen].bounds];
}

@end
