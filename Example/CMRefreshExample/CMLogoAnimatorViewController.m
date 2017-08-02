//
//  CMLogoAnimatorViewController.m
//  CMRefreshExample
//
//  Created by Chuck MA on 08/01/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <Masonry.h>
#import <MCCommonTableView.h>

#import "CMLogoAnimatorViewController.h"
#import "CMCommon.h"
#import "CMRefresh.h"
#import "CMLogoAnimator.h"

@interface CMLogoAnimatorViewController ()

@property (nonatomic, strong) MCCommonTableView *tableView;

@end

@implementation CMLogoAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"CMLogoAnimator";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MLog(@"[CMLogoAnimatorViewController] --> dealloc");
}

@end
