//
//  MainViewController.m
//  VoiceAlarmClock
//
//  Created by Stone on 2018/5/9.
//  Copyright © 2018年 StoneStudio. All rights reserved.
//

#import "MainViewController.h"
#import "SSNavigationTabBar.h"
#import "SSCalendarViewController.h"
#import "SSKitchenClockViewController.h"

@interface MainViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,strong)SSNavigationTabBar *navigationTabBar;
@property(nonatomic,strong)NSArray<UIViewController *> *subViewControllers;
@end

@implementation MainViewController

-(SSNavigationTabBar *)navigationTabBar {
    if (!_navigationTabBar) {
        self.navigationTabBar = [[SSNavigationTabBar alloc] initWithTitles:@[@"万年历",@"厨房闹钟"]];
        __weak typeof(self) weakSelf = self;
        [self.navigationTabBar setDidClickAtIndex:^(NSInteger index){
            [weakSelf navigationDidSelectedControllerIndex:index];
        }];
    }
    return _navigationTabBar;
}

-(NSArray *)subViewControllers {
    if (!_subViewControllers) {
        SSCalendarViewController *vc1 = [[SSCalendarViewController alloc] init];
        vc1.view.backgroundColor = [UIColor magentaColor];
        
        SSKitchenClockViewController *vc2 = [[SSKitchenClockViewController alloc] init];
        vc2.view.backgroundColor = [UIColor blueColor];
        
        self.subViewControllers = @[vc1,vc2];
    }
    return _subViewControllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.navigationTabBar;
    self.delegate = self;
    self.dataSource = self;
    [self setViewControllers:@[self.subViewControllers.firstObject]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

#pragma mark - UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    
    return [self.subViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.subViewControllers indexOfObject:viewController];
    if(index == NSNotFound || index == self.subViewControllers.count - 1) {
        return nil;
    }
    return [self.subViewControllers objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.viewControllers[0];
    NSUInteger index = [self.subViewControllers indexOfObject:viewController];
    [self.navigationTabBar scrollToIndex:index];
    
}


#pragma mark - PrivateMethod
- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    [self setViewControllers:@[[self.subViewControllers objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
