
//
//  ZLLabelView.m
//  ZLResume
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLLabelView.h"

#define textFont [UIFont fontWithName:@"PingFang-SC-Medium" size:12.f]
#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

@interface ZLLabelView()

@property (nonatomic, strong)UILabel *label;

@end
@implementation ZLLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    
    for (UILabel *zlLabel in self.subviews) {
        [zlLabel removeFromSuperview];
    }
    CGFloat w = 0.0;
    CGFloat yLine = 1;//行数
    CGFloat xLine = 0;//横排第几个
    CGFloat space = 5;
    for (NSString *str in titleArr) {
        CGFloat width = [self sizeForFont:textFont size:CGSizeMake(MAXFLOAT, 20) mode:NSLineBreakByWordWrapping infoStr:str].width + 20;
        CGFloat nnn = SCREEN_WIDTH-70;
        if (w + xLine*space + width>= nnn) {
            xLine = 1;
            yLine++;
            w = 0;
        }else {
            xLine++;
        }
        [self createLabel:str x:w+space*(xLine-1) y:(10*yLine + (yLine - 1)*20)  width:width height:20];
        w += width;
    }
}

- (void)createLabel:(NSString *)title x:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    
    UILabel *label = [UILabel new];
    label.font = textFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(x, y, width, height);
    label.text = title;
    label.backgroundColor = [UIColor whiteColor];
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    label.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    label.layer.borderWidth = 1;
    [self addSubview:label];
}

//该方法多次使用 注意需要--封装
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode infoStr:(NSString *)infoStr{
    CGSize result;
    if (!font) font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15.f];
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = lineBreakMode;
    attr[NSParagraphStyleAttributeName] = paragraphStyle;
    CGRect rect = [infoStr boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attr context:nil];
    result = rect.size;
    return result;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
