//
//  ZLFooterView.h
//  ZLResume
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZLFooterViewDelegate<NSObject>

- (void)restoreDefaultOptions;
@end

@interface ZLFooterView : UIView
@property (nonatomic, assign)id<ZLFooterViewDelegate>delegate;
@end
