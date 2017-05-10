//
//  JYTabBarController.m
//  testJYTabBar
//
//  Created by 姬巧春 on 16/4/22.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "JYTabBarController.h"
#import "JYTabBar.h"

#import "testOneViewController.h"
#import "testTwoViewController.h"
#import "testThreeViewController.h"
#import "testFourViewController.h"

@interface JYTabBarController () <JYTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) JYTabBar *customTabBar;

@end

@implementation JYTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    JYTabBar *customTabBar = [[JYTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(JYTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
//    if (self.selectedIndex == to && to == 0 ) {//双击刷新制定页面的列表
//        UINavigationController *nav = self.viewControllers[0];
//        testOneViewController *firstVC = nav.viewControllers[0];
//    }
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.
    testOneViewController *home = [[testOneViewController alloc] init];
    [self setupChildViewController:home title:@"first" imageName:@"first_normal" selectedImageName:@"first_selected"];
    
    // 2.
    testTwoViewController *message = [[testTwoViewController alloc] init];
    [self setupChildViewController:message title:@"second" imageName:@"second_normal" selectedImageName:@"second_selected"];
    
    // 3.
    testThreeViewController *home1 = [[testThreeViewController alloc] init];
    [self setupChildViewController:home1 title:@"third" imageName:@"third_normal" selectedImageName:@"third_selected"];
    
    // 4.
    testFourViewController *message1 = [[testFourViewController alloc] init];
    [self setupChildViewController:message1 title:@"four" imageName:@"third_normal" selectedImageName:@"third_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
