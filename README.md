# CMRefresh
Some util refresh categories for UIScrollView and it's subclasses, which write in Objective-C, wish you love it, enjoy the code:D

## Installation
### Cocoapods:

1. Add `pod 'CMRefresh', '~> 0.0.1'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import \<CMRefresh.h\>.

### Carthage:

1. Add `github "chucklab/CMRefresh"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<CMRefresh/CMRefresh.h\>.

## Usage

```objc
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
```

## Requirements
This library requires a deployment target of iOS 8.0 or greater.

## License
CMRefresh is provided under the MIT license. See LICENSE file for details.

