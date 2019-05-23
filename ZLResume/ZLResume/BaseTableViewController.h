//
//  BaseTableViewController.h
//  ZLResume
//
//  Created by apple on 2018/8/31.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZLHeader.h"

@protocol ScrollResponder;

@interface BaseTableViewController : UIViewController

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, weak) id<ScrollResponder> scrollResponder;

@end
@protocol ScrollResponder<NSObject>

/** 如果想监听内部视图的滚动，请实现下面的方法 */
- (void)companyBaseController:(BaseTableViewController *)baseController scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)baseTableScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

- (void)baseTableScrollerViewWillEndDragging:(UIScrollView *)scrollerView;


@end
