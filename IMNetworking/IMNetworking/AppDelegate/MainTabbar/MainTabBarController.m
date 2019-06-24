//
//  MainTabBarController.m
//  MedicineStore
//
//  Created by  zhanglixiang on 16/5/18.
//  Copyright © 2016年 zhanglixiang. All rights reserved.
//

#import "MainTabBarController.h"
#import "MLCompatibleAlert.h"
#import "AppDelegate.h"
@interface MainTabBarController ()
@property(nonatomic,copy)NSString *downLoadStr;
@end

@implementation MainTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
}
// 定制tabBar
- (void)createTabBar
{
//    BikeTabBar *tabBr = [[BikeTabBar alloc] init];
//    tabBr.delegate = self;
//    [self setValue:tabBr forKeyPath:@"tabBar"];
}


/**
 设置标签
 
 @param vcsArray 对应的viewController数组
 @param vcTitleArray 对应标题名称
 @param defaultImageArray 默认显示图片数组
 @param selectImageArray 选中图片数组
 */
-(void)setViewControllers:(NSArray *)vcsArray
     viewControllerTitleS:(NSArray *)vcTitleArray
            defaultImages:(NSArray *)defaultImageArray
           selectedImages:(NSArray *)selectImageArray{
   
    NSMutableArray *navControllers = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < vcsArray.count; i++) {
         UIViewController *vcItem = vcsArray[i];
        UINavigationController *navigationVC = [[UINavigationController alloc]initWithRootViewController:vcItem];
         navigationVC.view.backgroundColor = [UIColor whiteColor];
        vcItem.title = vcTitleArray[i];
        UIImage *normalImage=[[UIImage imageNamed:defaultImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage =[[UIImage imageNamed:selectImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:vcTitleArray[i] image:normalImage selectedImage:selectImage];
//        tabBarItem.imageInsets = UIEdgeInsetsMake(4, 0, -4,0);
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        tabBarItem.tag = i;
        navigationVC.tabBarItem = tabBarItem;
//        [self addChildViewController:navigationVC];
        [navControllers addObject:navigationVC];
    }
    //添加到TabBar上
    [self setViewControllers:navControllers animated:YES];
}


+(void)configTabbar:(NSInteger)tabbarIndex ItemNumber:(NSInteger)itemNumber{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate.window.rootViewController isKindOfClass:[MainTabBarController class]]) {
        MainTabBarController *tabViewController = (MainTabBarController *) appDelegate.window.rootViewController;
        UITabBarItem * item = [tabViewController.tabBar.items objectAtIndex:tabbarIndex];
        if (itemNumber > 0) {
            item.badgeValue = [NSString stringWithFormat:@"%ld",itemNumber];
        }else{
            item.badgeValue = nil;
        }
    }
    
}
//解决iPhoneX tabbar位置下移问题
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    frame.size.height = YTabBarHeight;
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    self.tabBar.frame = frame;
//    self.tabBar.backgroundColor = [UIColor blackColor];
    self.tabBar.barStyle = UIBarStyleDefault;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self checkNewVersion];
    
}
//-(void)checkNewVersion
//{
//    YXKJBaseParameter * parameter = [YXKJBaseParameter parameter:nil apiName:@"/mobile/app/getNewAppVersionIOS"];
//    WeakSelf(weakSelf);
//    __block void (^finishRequstingBlock)(id response,NSError *error) = ^(id response,NSError *error) {
//        if (YXKJRequestSucessful(response))
//        {
//            NSString *app_build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//            if (![response[@"appVersion"] isEqualToString:app_build]) {
//                NSString * str;
//                self.downLoadStr = response[@"appDownload"];
//                ([response[@"buttionNum"] isEqual:@"2"])?(str=@"取消"):(str=nil);
//
//                MLCompatibleAlert *alert = [[MLCompatibleAlert alloc]
//                                            initWithPreferredStyle: MLAlertStyleAlert
//                                            title:@"更新提示"
//                                            message: [[response[@"updateText"] componentsSeparatedByString:@" "] componentsJoinedByString:@"\n"]
//                                            delegate: weakSelf
//                                            cancelButtonTitle:@"确定"
//                                            destructiveButtonTitle:nil
//                                            otherButtonTitles:str,nil];
//                [alert showAlertWithParent:self];
//            }
//        }else{
//            [YWindow showXJToast:response ? response[@"message"] :  @"网络错误，请稍后重试"];
//        }
//    };
//    [[YXKJRequestManager shareInstance]GET:parameter success:^(id response) {
//        finishRequstingBlock(response,nil);
//    } failure:^(NSError *error) {
//        finishRequstingBlock(nil,error);
//    }];
//}

//- (void)compatibleAlert:(MLCompatibleAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downLoadStr]];
//        exit(0);
//    }
//}

@end
