//
//  RSideMainController.h
//  LeftSide
//
//  Created by Rockey on 16/8/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RSideMainController;

@protocol RSideMainControllerDelegate <NSObject>

- (void)RSideMainControllerLeftBar:(RSideMainController *)controller toLeft:(BOOL)toLeft;

@end

@interface RSideMainController : UIViewController

@property (nonatomic, weak) id <RSideMainControllerDelegate> delegate;

/**
 *  设置 ToLeft 标记
 *
 *  @param toLeft;  True：下次展示左侧，False:下次隐藏左侧
 */
- (void)setRSideToLeft:(BOOL)toLeft;

@end

