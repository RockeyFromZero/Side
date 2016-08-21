//
//  RSideController.h
//  LeftSide
//
//  Created by Rockey on 16/8/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSideController : UIViewController

- (instancetype)initWithMain:(UIViewController *)mainController menu:(UIViewController *)menuController;
- (void)cancelDragGuesture;
- (void)beginDragGuesture;

@end
