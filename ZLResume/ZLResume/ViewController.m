//
//  ViewController.m
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"
#import "ZLLabelView.h"
#import "ZLViewController.h"
#import "SBESearchConditionStatusModel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    ZLLabelView *viewss = [[ZLLabelView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) titleArr:@[@"前端开发",
//                                                                                   @".net开发",
//                                                                                   @"iOS开发",
//                                                                                   @"Java开发哈哈哈哈哈",
//                                                                                   @"安卓开发哈哈哈",
//                                                                                   @"全栈开发",
//                                                                                    @"Go语言开发",]];
    ZLLabelView *viewss = [[ZLLabelView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    
    viewss.titleArr = @[@"前端开发",
                        @".net开发",
                        @"iOS开发",
                        @"Java开发哈哈哈哈哈",
                        @"安卓开发哈哈哈",
                        @"全栈开发",
                        @"Go语言开发",];
    
    
    [self.view addSubview:viewss];
    
    
//    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 100)];
//    [self.view addSubview:topView];
//    topView.backgroundColor = [UIColor colorWithWhite:255.f/255.0f alpha:0];
    
//    UIView *childView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
////    childView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:1.0f];
//    childView.backgroundColor = [UIColor colorWithWhite:255.f/255.f alpha:0];
//    [topView addSubview:childView];
//
//    UIView *hhhhView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
//    hhhhView.backgroundColor = [[UIColor purpleColor]colorWithAlphaComponent:1.0f];
//    [childView addSubview:hhhhView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSArray *arr = @[@"意向行业",
                     @"意向地区",
                     @"学历要求",
                     @"工作年限",
                     @"年龄要求"];
    NSMutableArray *dataArr = @[].mutableCopy;
    for (NSString *str in arr) {
        SBESearchConditionStatusModel *model = [SBESearchConditionStatusModel new];
        model.statusName = str;
        model.str = @"234";
        [dataArr addObject:model];
    }

    ZLViewController *vc = [ZLViewController new];
    vc.sourceArr = dataArr;
    vc.SBESearchConditionStatusBlock = ^(NSMutableArray<SBESearchConditionStatusModel *> *arr) {
        NSLog(@"--------%@",arr);
    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    Class class = NSClassFromString(@"ZLViewController");
//    Class class = NSClassFromString(@"ZLHHHViewController");
    [self.navigationController pushViewController:[class new] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
