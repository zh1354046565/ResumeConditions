//
//  ZLLabelView.h
//  ZLResume
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

@interface ZLLabelView : UIView

//- (instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr;

@property (nonatomic, strong)NSArray *titleArr;

@end
