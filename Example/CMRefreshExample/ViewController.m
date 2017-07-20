//
//  ViewController.m
//  CMRefreshExample
//
//  Created by Chuck MA on 07/10/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <Masonry.h>
#import <MCCommonTableView.h>

#import "CMCommon.h"
#import "ViewController.h"
#import "CMRamotionAnimatorViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CMRefreshExample";
    
    MCCommonTableView *tableView = [MCCommonTableView tableViewWithFrame:CGRectMake(0, 0, 1, 1)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
    tableView.dataMap = @{
                          @"Day One" : @{
                                  @"1. CMRamotionAnimator" : ^(){
                                      CMRamotionAnimatorViewController *vc = [[CMRamotionAnimatorViewController alloc] init];
                                      [self.navigationController pushViewController: vc animated: YES];
                                  },
//                                  @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
//                                  @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
//                                  @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
//                                  @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                  },
//                          @"Day two" : @{
//                                  @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
//                                  @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
//                                  @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
//                                  @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
//                                  @"5. No message" : ^(){ DLog(@"No, tapped."); }
//                                  }
                          };
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"End" style:UIBarButtonItemStylePlain target:self action:@selector(endRefresh)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)endRefresh {
}

@end
