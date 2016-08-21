//
//  RSideController.m
//  LeftSide
//
//  Created by Rockey on 16/8/21.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "RSideController.h"
#import "RSideMenuController.h"
#import "RSideMainController.h"

#define kAppDelegate [[UIApplication sharedApplication] delegate]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kMenuWidth 0.7
#define kMenuTransformWidth 0.4

@interface RSideController ()<RSideMainControllerDelegate>

@property (nonatomic, strong) UINavigationController *mainController;
@property (nonatomic, strong) RSideMenuController *menuController;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation RSideController
- (instancetype)initWithMain:(UINavigationController *)mainController menu:(RSideMenuController *)menuController {
    if (self = [super init]) {
        _mainController = mainController;
        ((RSideMainController *)mainController.topViewController).delegate = self;
        _menuController = menuController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self setupChildControllers];
    [self.mainController.view addGestureRecognizer:self.panGesture];
}

- (void)setupChildControllers {
    
    [self addChildViewController:_menuController];
    [self.view addSubview:_menuController.view];
    
    self.menuController.view.transform = CGAffineTransformMakeTranslation(-kScreenWidth*kMenuTransformWidth, 0);
    
     [self addChildViewController:_mainController];
    [self.view addSubview:_mainController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - RSideMainControllerDelegate
- (void)RSideMainControllerLeftBar:(RSideMainController *)controller toLeft:(BOOL)toLeft {
    [UIView animateWithDuration:0.4 animations:^{
        if (toLeft) {
            CGAffineTransform rightMaxTransform = CGAffineTransformTranslate([kAppDelegate window].transform, kScreenWidth * kMenuWidth, 0);
            self.mainController.view.transform = rightMaxTransform;
            self.menuController.view.transform = CGAffineTransformIdentity;
        } else {
            self.mainController.view.transform = CGAffineTransformIdentity;
            self.menuController.view.transform = CGAffineTransformMakeTranslation(-kScreenWidth*kMenuTransformWidth, 0);
        }
    }];
}

#pragma mark - panGuesture
- (void)cancelDragGuesture {
    self.panGesture.enabled = false;
}

- (void)beginDragGuesture {
    self.panGesture.enabled = true;
}

- (void)panGuestureAction:(UIPanGestureRecognizer *)panGuesture {
    CGPoint senderTransition = [panGuesture translationInView:panGuesture.view];
    
    self.mainController.view.transform = CGAffineTransformTranslate(self.mainController.view.transform, senderTransition.x, 0);
    CGFloat menuTransformX = -kScreenWidth*kMenuTransformWidth + self.mainController.view.transform.tx*kMenuTransformWidth/kMenuWidth;
    self.menuController.view.transform = CGAffineTransformMakeTranslation(menuTransformX, 0);
    [panGuesture setTranslation:CGPointZero inView:panGuesture.view];
    
    CGAffineTransform rightMaxTransform = CGAffineTransformMakeTranslation(kScreenWidth*kMenuWidth, 0);
    if (panGuesture.view.transform.tx > rightMaxTransform.tx) {
        self.mainController.view.transform = rightMaxTransform;
        self.menuController.view.transform = CGAffineTransformIdentity;
    } else if (panGuesture.view.transform.tx < 0) {
        self.mainController.view.transform = CGAffineTransformIdentity;
        self.menuController.view.transform = CGAffineTransformMakeTranslation(-kScreenWidth*kMenuTransformWidth, 0);
    } else {
//        原本放在这里，但是在边界会抖动，原因在于到达边界的时候，依旧会执行这个条件语句；放在上面，边界值会进行重新修正
//        self.mainController.view.transform = CGAffineTransformTranslate(self.mainController.view.transform, senderTransition.x, 0);
//        CGFloat menuTransformX = -kScreenWidth*kMenuTransformWidth + self.mainController.view.transform.tx*kMenuTransformWidth/kMenuWidth;
//        self.menuController.view.transform = CGAffineTransformMakeTranslation(menuTransformX, 0);
//        [panGuesture setTranslation:CGPointZero inView:panGuesture.view];
    }
    
    if (UIGestureRecognizerStateEnded == panGuesture.state) {
        [UIView animateWithDuration:0.2 animations:^{
            if ((panGuesture.view.transform.tx > rightMaxTransform.tx/2) && 
                (panGuesture.view.transform.tx != rightMaxTransform.tx)) {
                
                self.mainController.view.transform = rightMaxTransform;
                self.menuController.view.transform = CGAffineTransformIdentity;
                [((RSideMainController *)self.mainController.topViewController) setRSideToLeft:true];
            } else {
                
                [((RSideMainController *)self.mainController.topViewController) setRSideToLeft:false];
                self.mainController.view.transform = CGAffineTransformIdentity;
                self.menuController.view.transform = CGAffineTransformMakeTranslation(-kScreenWidth*kMenuTransformWidth, 0);
            }
        }];
    }
}

#pragma mark - lazy load
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGuestureAction:)];
    }
    return _panGesture;
}

@end
