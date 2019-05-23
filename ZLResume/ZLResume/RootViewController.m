//
//  RootViewController.m
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "RootViewController.h"
#import "HMSegmentedControl.h"
#import "ZLHeader.h"

#import "ViewControllerOne.h"
#import "ViewControllerTwo.h"
#import "ViewControllerThree.h"
#import "ViewControllerFour.h"
#import "ZLSliderPageReuseManager.h"
#import "BaseTableViewController.h"
#import "MyResumePreviewDetailModel.h"
#import "MyResumePreviewSectionsModel.h"

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

#define headerHeight 320
#define segmentHeight 40

//状态栏与导航栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

#define CATEGORY @[@"简历详情",@"简历评价",@"操作记录",@"投递记录",]

NSString* const oneVIdentifier = @"ViewControllerOne";
NSString* const twoVIdentifier = @"ViewControllerTwo";
NSString* const threeVIdentifier = @"ViewControllerThree";
NSString* const fourVIdentifier = @"ViewControllerFour";

static dispatch_once_t onceToken;
@interface RootViewController ()<UIScrollViewDelegate,ScrollResponder>
//最底部滚动ScrollView
@property (nonatomic, strong) UIScrollView *bottomScrollView;
//添加在tableView上
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
//头部视图
@property (nonatomic, strong) ZLHeader *zlheaderView;
//利用runtime解决segment切换视图刷新
@property (nonatomic, strong) ZLSliderPageReuseManager *reuseManager;
//记录偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;

@property (nonatomic, strong)ViewControllerOne *oneVC;

@property (nonatomic, strong)ViewControllerTwo *twoVC;

@property (nonatomic, strong)ViewControllerThree *threeVC;

@property (nonatomic, strong)ViewControllerFour *fourVC;
//
@property (nonatomic, assign)BOOL isEndDecelerat;

@property (nonatomic, strong)BaseTableViewController *baseTableVC;
//假的
@property (nonatomic, strong)HMSegmentedControl *segmentControl1;

@property (nonatomic, assign)BOOL isScroll;


@property (nonatomic, strong)NSArray <MyResumePreviewSectionsModel *>*dataArr;

@property (nonatomic, assign)NSInteger disposeState;

@property(nonatomic, assign)NSInteger segmentTag;

@end

@implementation RootViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.navigationController.navigationBar.translucent = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _reuseManager = [[ZLSliderPageReuseManager alloc]initWith:CATEGORY.count];
    [_reuseManager registerClass:[ViewControllerOne class] forReuseIdentifier:oneVIdentifier];
    [_reuseManager registerClass:[ViewControllerTwo class] forReuseIdentifier:twoVIdentifier];
    [_reuseManager registerClass:[ViewControllerThree class] forReuseIdentifier:threeVIdentifier];
    [_reuseManager registerClass:[ViewControllerFour class] forReuseIdentifier:fourVIdentifier];
    [self.view addSubview:self.zlheaderView];
    
//    [self.view insertSubview:self.zlheaderView belowSubview:self.bottomScrollView];
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.segmentControl];
    [self parseJsonData];
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //点击次数（默认1）
    topTap.numberOfTapsRequired = 1;
    //手指的个数（默认1）
    topTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:topTap];
}

- (void)tapAction:(UITapGestureRecognizer *)gesture {
    CGPoint tapf = [gesture locationInView:gesture.view];
    CGPoint childP = [gesture.view convertPoint:tapf toView:self.segmentControl];
    if (CGRectContainsPoint(self.segmentControl.bounds, childP)) {
        [self sliderToViewAtIndex:[self getSegmentIndex:childP.x] isFirstLoad:NO];
    }
}

- (NSInteger)getSegmentIndex:(CGFloat)pointX {
    NSInteger index = 0;
    NSInteger count = SCREEN_WIDTH/CATEGORY.count;
    for (int i = 0; i<=CATEGORY.count; i++) {
        if (i*count > pointX) {
            index = i-1;
            break;
        }
    }
//    self.segmentTag = index;
    return index;
}
    

#pragma mark - lazy
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[];
    }
    return _dataArr;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight)];
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.bounces = NO;
        _bottomScrollView.contentSize = CGSizeMake(CATEGORY.count * SCREEN_WIDTH, 0);
        _bottomScrollView.backgroundColor = [UIColor clearColor];
//        _bottomScrollView.scrollEnabled = NO;
    }
    return _bottomScrollView;
}

-(HMSegmentedControl *)segmentControl{

    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc]init];
        _segmentControl.sectionTitles = CATEGORY;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectionIndicatorHeight = 3;
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentControl.selectionIndicatorColor = [UIColor redColor];
        _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
        [_segmentControl setSelectedTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
        [_segmentControl addTarget:self action:@selector(titleSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (ZLHeader *)zlheaderView{
    if (!_zlheaderView) {
        _zlheaderView = [[ZLHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight) infoArr:@[@"本科",@"五年",@"28岁",@"汉族",@"党员",@"未婚",@"现居住于山东省枣庄市",@"山西省大同市户口"]];
    }
    return _zlheaderView;
}
#pragma mark -private
- (void)reloadControllerAtScrollTag:(NSInteger)tag fromTag:(NSInteger)fromTag {
//    if (tag != fromTag) {
        [self migrateContentOffsertAtScrollTag:tag fromTag:fromTag];
//    }else {
        //do nothing
//    }
}

- (void)migrateContentOffsertAtScrollTag:(NSInteger)tag fromTag:(NSInteger)fromTag {
    BaseTableViewController *nextController = self.childViewControllers[tag];
    BaseTableViewController *fromController = self.childViewControllers[fromTag];
    UITableView *nextTableView = nextController.tableView;
    UITableView *fromTableView = fromController.tableView;
    CGFloat fromOffsetY = fromTableView.contentOffset.y;
    CGFloat nextOffsetY = nextTableView.contentOffset.y;
    if (fromOffsetY >= -segmentHeight) {
        if (nextTableView.contentOffset.y < -segmentHeight) {
            if (nextController.tableView.contentSize.height < (CGRectGetHeight(nextController.tableView.frame) - segmentHeight)) {
                [self companyBaseController:nextController scrollViewDidScroll:nextController.tableView];
                self.segmentControl.frame = CGRectMake(0, nextTableView.contentOffset.y+segmentHeight, SCREEN_WIDTH, segmentHeight);
            } else {
                [nextTableView setContentOffset:CGPointMake(0, -headerHeight-segmentHeight) animated:NO];
//                self.isEndDecelerat = NO;
                self.segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, segmentHeight);
            }
        }
    }else {
        if (nextController.tableView.contentSize.height < (CGRectGetHeight(nextController.tableView.frame) - 40.f)) {
            [self companyBaseController:nextController scrollViewDidScroll:nextController.tableView];
//            self.isEndDecelerat = NO;
        } else {
            [nextTableView setContentOffset:CGPointMake(0, fromOffsetY) animated:NO];
//            self.isEndDecelerat = YES;
            self.segmentControl.frame = CGRectMake(0, -fromOffsetY-segmentHeight, SCREEN_WIDTH, segmentHeight);
        }
    }
}

- (void)sliderToViewAtIndex:(NSInteger)index isFirstLoad:(BOOL)isfirst{
    
//    self.indexStr =  [NSString stringWithFormat:@"%ld",index];
    NSInteger categoryId = index;
    
    if (index == 0) {
        self.oneVC = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:oneVIdentifier forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        self.oneVC.scrollResponder = self;
        self.oneVC.dataArr = [NSArray arrayWithArray:self.dataArr];
//        self.oneVC.DisposeState = self.disposeState;
        self.oneVC.DisposeState = 6;
        _baseTableVC = self.oneVC;
    }else if (index == 1) {
        self.twoVC = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:twoVIdentifier forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        self.twoVC.scrollResponder = self;
        _baseTableVC = self.twoVC;
    }else if (index == 2) {
        self.threeVC = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:threeVIdentifier forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        self.threeVC.scrollResponder = self;
        _baseTableVC = self.threeVC;
    }else if (index == 3) {
        self.fourVC = [self.reuseManager dequeueReuseableViewControllerWithIdentifier:fourVIdentifier forKey:[NSString stringWithFormat:@"%@",@(categoryId)]];
        self.fourVC.scrollResponder = self;
        _baseTableVC = self.fourVC;
    }
//    self.isScroll = NO;
    [self addChildViewController:_baseTableVC];
    [_bottomScrollView addSubview:_baseTableVC.view];
    _baseTableVC.view.frame = CGRectMake(SCREEN_WIDTH * index, 0, SCREEN_WIDTH, CGRectGetHeight(_bottomScrollView.frame));
    _baseTableVC.tableView.showsVerticalScrollIndicator = NO;
    _baseTableVC.tableView.showsHorizontalScrollIndicator = NO;
    if (!isfirst) {
        [self reloadControllerAtScrollTag:index fromTag:self.segmentTag];
    }else {
        
    }
    _baseTableVC.tableView.contentInset = UIEdgeInsetsMake(segmentHeight+headerHeight, 0, 0, 0);
    //    [_bottomScrollView insertSubview:_baseTableVC.view atIndex:0];
    

    /***/
    if (self.segmentControl.selectedSegmentIndex != index) {
        [self.segmentControl setSelectedSegmentIndex:index animated:YES];
        [self.segmentControl1 setSelectedSegmentIndex:index animated:YES];
    }
    _bottomScrollView.contentInsetAdjustmentBehavior = NO;
    [_bottomScrollView layoutIfNeeded];
    [_bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0)];
}
#pragma mark ----
- (void)setIsEndDecelerat:(BOOL)isEndDecelerat {
    if (isEndDecelerat) {
        __weak typeof(self) weakSelf = self;
        dispatch_once(&onceToken, ^{
            weakSelf.segmentControl1 = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, segmentHeight)];
            weakSelf.segmentControl1.sectionTitles = CATEGORY;
            weakSelf.segmentControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
            weakSelf.segmentControl1.selectionIndicatorHeight = 3;
            weakSelf.segmentControl1.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
            weakSelf.segmentControl1.selectionIndicatorColor = [UIColor redColor];
            weakSelf.segmentControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 15, 0, 15);
            [weakSelf.segmentControl1 setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
            [weakSelf.segmentControl1 setSelectedTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
            [weakSelf.segmentControl1 addTarget:self action:@selector(titleSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
            [weakSelf.view addSubview:weakSelf.segmentControl1];
        });
        self.segmentControl1.hidden = NO;
    }else {
        self.segmentControl1.hidden = YES;
    }
}

- (void)dealloc {
    onceToken = 0;
    self.oneVC.scrollResponder = nil;
    self.twoVC.scrollResponder = nil;
    self.threeVC.scrollResponder = nil;
    self.fourVC.scrollResponder = nil;
}

#pragma mark - 点击选项卡方法
-(void)titleSegmentControlChanged:(HMSegmentedControl *)segmentedControl{
//    if (self.isScroll) {
//        return;
//    }
    [self sliderToViewAtIndex:segmentedControl.selectedSegmentIndex isFirstLoad:NO];
    self.segmentTag = segmentedControl.selectedSegmentIndex;
}
#pragma mark - scrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double dindex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger index = (NSInteger)(dindex+0.5);
    if (index == self.segmentControl.selectedSegmentIndex) {
        return;
    }
    [self sliderToViewAtIndex:index isFirstLoad:NO];
    self.segmentTag = index;
    
}

#pragma mark - ScrollResponder
- (void)companyBaseController:(BaseTableViewController *)baseController scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.segmentTag != scrollView.tag) {
//        return;
//    }
//    self.isScroll = YES;
    self.lastTableViewOffsetY = scrollView.contentOffset.y;
    if (self.lastTableViewOffsetY >= -segmentHeight){
//        self.isEndDecelerat = YES;
    }else {
//        self.isEndDecelerat = NO;
    }
    if (self.lastTableViewOffsetY >= -segmentHeight) {
//        [self.segmentControl bringSubviewToFront:self.bottomScrollView];
        self.zlheaderView.frame = CGRectMake(0, -headerHeight, SCREEN_WIDTH, headerHeight);
        self.segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, segmentHeight);
    }else if (self.lastTableViewOffsetY >= -headerHeight - segmentHeight && self.lastTableViewOffsetY < -segmentHeight) {
        self.zlheaderView.frame = CGRectMake(0, -self.lastTableViewOffsetY-segmentHeight-headerHeight, SCREEN_WIDTH, headerHeight);
        self.segmentControl.frame = CGRectMake(0, -self.lastTableViewOffsetY-segmentHeight, SCREEN_WIDTH, segmentHeight);
    }else {
        self.zlheaderView.frame = CGRectMake(0, -self.lastTableViewOffsetY-segmentHeight-headerHeight, SCREEN_WIDTH, headerHeight);
        self.segmentControl.frame = CGRectMake(0, -self.lastTableViewOffsetY-segmentHeight, SCREEN_WIDTH, segmentHeight);
    }
}

- (void)baseTableScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    self.isScroll = NO;
    [_baseTableVC.tableView setContentOffset:scrollView.contentOffset animated:NO];
}

- (void)baseTableScrollerViewWillEndDragging:(UIScrollView *)scrollerView {
//    self.isScroll = NO;
}

#pragma mark ----请求数据部分
//进入该界面 请求个人简历数据(应该是该界面的数据)(包括header,简历详情,简历评价,操作记录,投递记录;)
- (void)parseJsonData {
    NSString *jsonString = [[NSBundle mainBundle]pathForResource:@"oneData" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonString];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([dataDic[@"StatusMsg"] isEqualToString:@"查询成功"]) {
        MyResumePreviewDetailModel *model = [MyResumePreviewDetailModel new];
        [model setValuesForKeysWithDictionary:dataDic[@"ResultData"]];
        self.disposeState = model.infoModel.DisposeState;
        self.dataArr = [MyResumePreviewSectionsModel myResumePreviewSectionsModelCovertFromModel:model];
        [self sliderToViewAtIndex:0 isFirstLoad:YES];
        self.segmentTag = 0;
    }
}

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
