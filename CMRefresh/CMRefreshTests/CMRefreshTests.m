//
//  CMRefreshTests.m
//  CMRefreshTests
//
//  Created by Chuck MA on 07/26/2017.
//  Copyright © 2017 Chuck Lab. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CMRefresh.h"

@interface CMRefreshTests : XCTestCase

@end

@implementation CMRefreshTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNormal {
    UITableView *tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, 100, 100) style: UITableViewStylePlain];
    XCTAssert(tableView);
    __weak UITableView *weakTableView = tableView;
    [tableView.cm addHeadRefreshWithAnimator: nil handler: ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakTableView.cm endHeaderRefresh];
            [weakTableView.cm resetNoMore];
        });
    }];
    XCTAssert(tableView);
}

@end
