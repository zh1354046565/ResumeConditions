//
//  ViewControllerTwo.m
//  ZLResume
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "TwoCell.h"
#import "ZLLabelView.h"
#import "UIButton+ImageTitleSpacing.h"

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

@interface ViewControllerTwo ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UIButton *btn;

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight - 60) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView registerClass:[TwoCell class] forCellReuseIdentifier:@"twocell"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btn];
    [self loadData];
}

- (void)loadData {
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"evaluation" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *dataArr = jsonDic[@"ResultData"][@"lstEvalate"];
    for (NSDictionary *dic in dataArr) {
        ZLTwoModel *model = [ZLTwoModel new];
        [model setValuesForKeysWithDictionary:dic];
        model.labelArr = [model.EvalLable componentsSeparatedByString:@","];
        model.LabelsHeight = [self getLabelsHeight:model.labelArr];
        [self.dataArr addObject:model];
    }
    [self.tableView reloadData];
}

//得到ZLLabelView的高度
- (CGFloat)getLabelsHeight:(NSArray<NSString *>*)arr {
    CGFloat labelWidth = 0;
    CGFloat hSpace = 10;
    CGFloat yLine = 1;//行数
    CGFloat xLine = 0;//横排第几个
    for (NSString *str in arr) {
        CGFloat width = [self sizeForFont:[UIFont fontWithName:@"PingFang-SC-Medium" size:12.f] size:CGSizeMake(MAXFLOAT, 20) mode:NSLineBreakByWordWrapping infoStr:str].width + 20;
        
        labelWidth += width;
        if (labelWidth + 5*(xLine) >= SCREEN_WIDTH-70) {
            xLine = 0;
            yLine++;
            labelWidth = 0;
        }else{
            xLine++;
        }
    }
    CGFloat yHeight = yLine * 20 + (yLine+1) * hSpace;
    
    return yHeight;
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}


- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(hhhh) forControlEvents:UIControlEventTouchUpInside];
        _btn.frame = CGRectMake(0, SCREEN_HEIGHT - kStatusBarHeight - kNavBarHeight - 60, SCREEN_WIDTH, 60);
        [_btn setTitle:@"评价简历" forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [_btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:14 titleFont:14.f];
    }
    return _btn;
}

- (void)hhhh {
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"twocell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLTwoModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h = [self.dataArr[indexPath.row] LabelsHeight];
    if (h) {
        return 60 + h;
    }
    return 70;
}

#pragma mark - 设置tableView分割线宽度
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 60, 0, 0)];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 60, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsMake(0, 60, 0, 0);
    }
}


- (void)reloadDatas {
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.scrollResponder && [self.scrollResponder respondsToSelector:@selector(companyBaseController:scrollViewDidScroll:)]) {
//        [self.scrollResponder companyBaseController:self scrollViewDidScroll:self.tableView];
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (self.scrollResponder && [self.scrollResponder respondsToSelector:@selector(baseTableScrollViewDidEndDecelerating:)]) {
//        [self.scrollResponder baseTableScrollViewDidEndDecelerating:self.tableView];
//    }
//}
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (self.scrollResponder && [self.scrollResponder respondsToSelector:@selector(baseTableScrollerViewWillEndDragging:)]) {
//        [self.scrollResponder baseTableScrollerViewWillEndDragging:self.tableView];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
