//
//  CMRamotionAnimatorViewController.m
//  CMRefreshExample
//
//  Created by Chuck MA on 07/11/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <Masonry.h>
#import <MCCommonTableView.h>

#import "CMCommon.h"
#import "CMRamotionAnimatorViewController.h"
#import "CMRefresh.h"

@interface CMRamotionAnimatorViewController ()

@property (nonatomic, strong) MCCommonTableView *tableView;

@end

@implementation CMRamotionAnimatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CMRamotionAnimator";
    
    MCCommonTableView *tableView = [MCCommonTableView tableViewWithFrame:CGRectMake(0, 0, 1, 1)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(self.view);
    }];
//    tableView.dataMap = @{
//                          @"1. Day One" : @{
//                                  @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
//                                  @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
//                                  @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
//                                  @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
//                                  @"5. No message" : ^(){ DLog(@"No, tapped."); }
//                                  },
//                          @"2. Day two" : @{
//                                  @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
//                                  @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
//                                  @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
//                                  @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
//                                  @"5. No message" : ^(){ DLog(@"No, tapped."); }
//                                  },
//                          @"3. Day three" : @{
//                                  @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
//                                  @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
//                                  @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
//                                  @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
//                                  @"5. No message" : ^(){ DLog(@"No, tapped."); }
//                                  },
//                          };
    
    __weak typeof(self) weakSelf = self;
    [tableView.cm addHeadRefreshWithAnimator: nil handler: ^{
        //DLog(@"Refresh handler");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.tableView.dataMap = @{
                                           @"1. Day One" : @{
                                                   @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                   @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                   @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                   @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                   @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                   },
                                           @"2. Day two" : @{
                                                   @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                   @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                   @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                   @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                   @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                   },
                                           @"3. Day three" : @{
                                                   @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                   @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                   @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                   @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                   @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                   },
                                           };
            [weakSelf.tableView.cm endHeaderRefresh];
            [weakSelf.tableView.cm resetNoMore];
        });
    }];
    
    [tableView.cm beginHeaderRefresh];
    
    [tableView.cm addFootRefreshWithAnimator: nil handler: ^{
        //DLog(@"Footer Handler...");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.tableView.dataMap.count <= 3) {
                weakSelf.tableView.dataMap = @{
                                               @"1. Day One" : @{
                                                       @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                       @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                       @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                       @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                       @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                       },
                                               @"2. Day two" : @{
                                                       @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                       @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                       @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                       @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                       @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                       },
                                               @"3. Day three" : @{
                                                       @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                       @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                       @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                       @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                       @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                       },
                                               @"4. Day four" : @{
                                                       @"1. Normal" : ^(){ DLog(@"Normal, tapped."); },
                                                       @"2. Multi lines" : ^(){ DLog(@"Multi, tapped."); },
                                                       @"3. Long single line" : ^(){ DLog(@"Long, tapped."); },
                                                       @"4. Very long text" : ^(){ DLog(@"Very, tapped."); },
                                                       @"5. No message" : ^(){ DLog(@"No, tapped."); }
                                                       },
                                               };
                [weakSelf.tableView.cm endLoadingMore];
            } else {
                [weakSelf.tableView.cm noticeNoMoreData];
            }
        });
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"End" style:UIBarButtonItemStylePlain target:self action:@selector(endRefresh)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MLog(@"[CMRamotionAnimatorViewController] --> dealloc");
}

#pragma mark - Actions
- (void)endRefresh {
    [self.tableView.cm endHeaderRefresh];
    
    [self.tableView.cm noticeNoMoreData];
    
}

@end
