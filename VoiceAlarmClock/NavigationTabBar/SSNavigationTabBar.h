//
//  SSNavigationTabBar.h
//  VoiceAlarmClock
//
//  Created by Stone on 2018/5/9.
//  Copyright © 2018年 StoneStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TabBarDidClickAtIndex)(NSInteger buttonIndex);

@interface SSNavigationTabBar : UIView
@property(nonatomic,copy)TabBarDidClickAtIndex didClickAtIndex;
-(instancetype)initWithTitles:(NSArray *)titles;
-(void)scrollToIndex:(NSInteger)index;
@property(nonatomic,strong)UIColor *sliderBackgroundColor;
@property(nonatomic,strong)UIColor *buttonNormalTitleColor;
@property(nonatomic,strong)UIColor *buttonSelectedTileColor;

@end
