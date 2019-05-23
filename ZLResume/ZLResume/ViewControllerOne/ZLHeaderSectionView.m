//
//  ZLHeaderSectionView.m
//  ZLResume
//
//  Created by apple on 2018/9/11.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLHeaderSectionView.h"
#import "MyResumePreviewSectionsModel.h"
#import "ZLHeaderSectionView.h"

NSString *const MyResumePreviewTableHeaderViewIdentifier = @"MyResumePreviewTableHeaderViewIdentifier";
CGFloat const MyResumePreviewTableHeaderViewHeight = 64.f;

@interface ZLHeaderSectionView()

@property (nonatomic, strong) UIView *leftRedImgeView;

@property (nonatomic, strong) UIView *topSeprateLineView;

@property (nonatomic, strong) UIView *bottomSeprateLineView;

@property (nonatomic, strong) UILabel *sectionDescribleLable;

@end
@implementation ZLHeaderSectionView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:(16.f)];
        _leftRedImgeView = ({
            UIView *leftRedImgeView = [[UIView alloc] init];
            [self.contentView addSubview:leftRedImgeView];
            leftRedImgeView.layer.cornerRadius = 2.f;
            leftRedImgeView.layer.masksToBounds = YES;
            leftRedImgeView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:69.0/255.0 blue:1.0/255.0 alpha:1.0];
            leftRedImgeView;
        });
        
        _topSeprateLineView =  ({
            UIView *seprateLineView = [[UIView alloc] init];
            [self.contentView addSubview:seprateLineView];
            seprateLineView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
            seprateLineView;
        });
        
        _bottomSeprateLineView = ({
            UIView *seprateLineView = [[UIView alloc] init];
            seprateLineView.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
            [self.contentView addSubview:seprateLineView];
            seprateLineView;
        });
        
        _sectionDescribleLable = ({
            UILabel *lable = [[UILabel alloc] init];
            lable.textColor = [UIColor darkTextColor];
            lable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.f];
            lable.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:lable];
            lable;
        });
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.contentView.bounds;
    CGFloat leftMargin = 12.f;
    CGFloat contentW = CGRectGetWidth(rect);
    CGFloat contentH = CGRectGetHeight(rect);
    CGFloat topLineH = 1.f;
    CGFloat redLineH = 16.f;
    
    _topSeprateLineView.frame = CGRectMake(0, 0, contentW, topLineH);
    _leftRedImgeView.frame = CGRectMake(leftMargin, 6 + (contentH - 6 -  redLineH) * 0.5, 4.f, redLineH);
    _bottomSeprateLineView.frame = CGRectMake(leftMargin, 63.5f, contentW - 2 * leftMargin, 0.5f);
    _sectionDescribleLable.center = CGPointMake(CGRectGetMaxX(_leftRedImgeView.frame) + 104.f, _leftRedImgeView.center.y);
    _sectionDescribleLable.bounds = CGRectMake(0, 0, 200.f, 20.f);
}

+ (nullable __kindof UIView *)conifgMyResumePreviewTableHeaderViewWithSectionsModel:(MyResumePreviewSectionsModel *)sectionsModel forTableView:(UITableView *)tableView {
    if (!sectionsModel.title) {
        return nil;
    }
    if (sectionsModel.cellIdentifier == MyResumePreviewUserInfoCellIdentifier) {
        return nil;
    }
    ZLHeaderSectionView *header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:MyResumePreviewTableHeaderViewIdentifier];
    if (nil == header ) {
        header = [[ZLHeaderSectionView alloc] initWithReuseIdentifier:MyResumePreviewTableHeaderViewIdentifier];
    }
    header.sectionDescribleLable.text = sectionsModel.title;
    return header;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
