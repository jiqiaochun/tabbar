//
//  JYTabBar.h
//  testJYTabBar
//
//  Created by 姬巧春 on 16/4/22.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JYTabBar;

@protocol JYTabBarDelegate <NSObject>

@optional
- (void)tabBar:(JYTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface JYTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<JYTabBarDelegate> delegate;

@end
