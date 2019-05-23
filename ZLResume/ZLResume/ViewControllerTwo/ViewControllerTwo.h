//
//  ViewControllerTwo.h
//  ZLResume
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

//@protocol TwoDelegate<NSObject>
//
//- (void)baseTableScrollerViewDidScroll:(UIScrollView *)scrollView;
//
//- (void)baseTableScrollViewDidEndDecelerating:(UIScrollView *)scrollView;
//
//@end

@interface ViewControllerTwo : BaseTableViewController


//@property (nonatomic, weak) id<TwoDelegate>delegate;
- (void)reloadDatas;

@end
