//
//  ViewController.m
//  JumpAppStore
//
//  Created by csq on 2017/1/25.
//  Copyright © 2017年 csq. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface ViewController () <SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 直接跳转
    UIButton *directButton = [[UIButton alloc] initWithFrame:CGRectMake(70, [UIScreen mainScreen].bounds.size.width/2 - 40, 80, 44)];
    [directButton setTitle:@"直接跳转" forState:UIControlStateNormal];
    directButton.tag = 1;
    [directButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [directButton addTarget:self action:@selector(jumpButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:directButton];

    // 应用内容跳转
    UIButton *internalButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 300, 100, 44)];
    internalButton.tag = 2;
    [internalButton addTarget:self action:@selector(jumpButton:) forControlEvents:UIControlEventTouchUpInside];
    [internalButton setTitle:@"应用内跳转" forState:UIControlStateNormal];
    [internalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:internalButton];

}

#pragma mark appstore界面的跳转
- (void) jumpButton:(UIButton *)button {

    NSURL *url = [NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/you-zan-pi-fa/id1041302121?mt=8"];
    if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        SKStoreProductViewController *appStore = [[SKStoreProductViewController alloc] init];
        appStore.delegate = self;
        // 借鉴了新浪微博的跳转做法，先去跳转再去加载页面，体验感方面会好很多
        [self presentViewController:appStore animated:YES completion:nil];
        [appStore loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"1041302121"} completionBlock:^(BOOL result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"错误 %@",error);
            } else {
            }
        }];
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


