//
//  ReportsSearchDisplayController.m
//  Conferences
//
//  Created by k.zinovyev on 16.07.16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "ReportsSearchViewController.h"

@class LecturePlainObject;
@class SpeakerPlainObject;

@interface ReportsSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *reportsListSearchTableView;
@property (weak, nonatomic) IBOutlet UIView *emptyPlaceholderView;
@property (weak, nonatomic) IBOutlet UIView *clearPlaceholderView;

@end

@implementation ReportsSearchViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeClearPlaceholder)];
    [self.clearPlaceholderView addGestureRecognizer:tapGestureRecognizer];
    [self.output setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIScrollView appearance] setBackgroundColor:[UIColor whiteColor]];
    self.reportsListSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - ReportsSearchViewInput

- (void)showClearPlaceholder {
    [self showClearPlaceholderWithAnimation];
}
- (void)setupView {
    [self.reportsListSearchTableView setTableFooterView:[UIView new]];
    
    self.dataDisplayManager.delegate = self;
    
    self.reportsListSearchTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsListSearchTableView];
    self.reportsListSearchTableView.delegate = [self.dataDisplayManager delegateForTableView:self.reportsListSearchTableView withBaseDelegate:nil];
}

- (void)updateViewWithObjectList:(NSArray *)foundObjects searchText:(NSString *)searchText{
    [self.clearPlaceholderView setHidden:YES];
    
    BOOL isEmptyReports = ([foundObjects count] == 0);
    BOOL willHideEmptyPlaceHolder = !isEmptyReports;
    BOOL willHideReportsList = isEmptyReports;
    
    [self.reportsListSearchTableView setHidden:willHideReportsList];
    [self.emptyPlaceholderView setHidden:willHideEmptyPlaceHolder];
    
    searchText = [searchText lowercaseString];
    [self.dataDisplayManager updateTableViewModelWithObjects:foundObjects searchText:(NSString *)searchText];
}

#pragma mark - ReportListDataDisplayManagerDelegate methods

- (void)didUpdateTableViewModel {
    self.reportsListSearchTableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.reportsListSearchTableView];
    [self.reportsListSearchTableView reloadData];
}

- (void)didTapCellWithEvent:(EventPlainObject *)event {
    [self.output didTriggerTapCellWithEvent:event];
}

- (void)didTapCellWithLecture:(LecturePlainObject *)lecture {
    [self.output didTriggerTapCellWithLecture:lecture];
}

- (void)didTapCellWithSpeaker:(SpeakerPlainObject *)speaker {
    [self.output didTriggerTapCellWithSpeaker:speaker];
}

#pragma mark - Animations

- (void)showClearPlaceholderWithAnimation {
    [self.clearPlaceholderView setHidden:NO];
    [self.reportsListSearchTableView setHidden:YES];
    [self.emptyPlaceholderView setHidden:YES];
    
    self.clearPlaceholderView.alpha = 0;

    [UIView animateWithDuration:0.2 animations:^{
        self.clearPlaceholderView.alpha = 0.4;
    }];
}

- (void)closeClearPlaceholder {
    [self closeSearchViewWithAnimation];
}

- (void)closeSearchView {
    [self closeSearchViewWithAnimation];
}

- (void)closeSearchViewWithAnimation {
    if (self.view.alpha != 1) {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.view.alpha = 1;
        [self.reportsListSearchTableView setHidden:YES];
        [self.emptyPlaceholderView setHidden:YES];
        [self.clearPlaceholderView setHidden:YES];
        [self.output didTapClearPlaceholderView];
    }];
}

@end
