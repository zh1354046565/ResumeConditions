//
//  ZLHeader.h
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LayerView : UIView

@end


@interface ZLHeader : UIView
- (instancetype)initWithFrame:(CGRect)frame infoArr:(NSArray *)infoArr;
@end
