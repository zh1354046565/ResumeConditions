//
//  ZLHHHViewController.m
//  ZLResume
//
//  Created by apple on 2018/11/9.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLHHHViewController.h"
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

@interface ZLHHHViewController ()<UIScrollViewDelegate,ScrollResponder,UIGestureRecognizerDelegate>
@property (nonatomic, strong)ViewControllerOne *oneVC;

@property (nonatomic, strong)ViewControllerTwo *twoVC;

@property (nonatomic, strong)ViewControllerThree *threeVC;

@property (nonatomic, strong)ViewControllerFour *fourVC;
//最底部滚动ScrollView
@property (nonatomic, strong) UIScrollView *bottomScrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentControl;
//头部视图
@property (nonatomic, strong) ZLHeader *zlheaderView;

@property (nonatomic, strong)NSArray <MyResumePreviewSectionsModel *>*dataArr;

@property (nonatomic, strong)BaseTableViewController *baseTableVC;

@property(nonatomic, assign)NSInteger segmentTag;
/**点击手势*/
@property (nonatomic, weak) UITapGestureRecognizer *tapGesture;

/**普通展开时高度*/
@property (nonatomic, assign) CGFloat normalH;
/**切换按钮悬停时高度*/
@property (nonatomic, assign) CGFloat hiddenH;
/**悬停按钮高度*/
@property (nonatomic, assign) CGFloat hoverBarH;


@property (nonatomic, assign)CGPoint panStartPoint;
@end

@implementation ZLHHHViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)){
//        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"改";
    self.view.backgroundColor = [UIColor whiteColor];
    self.normalH = 360.f;  // Default
    self.hoverBarH = 40.f;
    [self parseJsonData];
    
    [self setupChilldController];
    [self.view addSubview:self.zlheaderView];
    [self.view bringSubviewToFront:self.zlheaderView];
    [self.view addSubview:self.segmentControl];
    [self setupTouchEvent];
}

- (void)setupTouchEvent {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRootView:)];
    _tapGesture = tapGesture;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.cancelsTouchesInView = NO;
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)setNormalH:(CGFloat)normalH {
    _normalH = normalH;
    _hiddenH = normalH - _hoverBarH;
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof BaseTableViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isViewLoaded]) {
            obj.tableView.contentInset = UIEdgeInsetsMake(normalH, 0, 0, 0);
        }
    }];
}

#pragma mark -event
- (void)tapRootView:(UITapGestureRecognizer *)gesture {
    if (self.zlheaderView.hidden || self.segmentControl.hidden) {
        return;
    }
    CGPoint tapf = [gesture locationInView:gesture.view];
    CGPoint childP = [gesture.view convertPoint:tapf toView:self.segmentControl];
    if (CGRectContainsPoint(self.segmentControl.bounds, childP)) {
        NSInteger index = [self getSegmentIndex:childP.x];
        [self reloadControllerAtScrollTag:index fromTag:self.segmentTag];
        [self.segmentControl setSelectedSegmentIndex:index animated:YES];
        self.segmentTag = index;
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
    return index;
}

- (void)setupChilldController {
    _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight)];
    _bottomScrollView.delegate = self;
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.bounces = NO;
    _bottomScrollView.contentSize = CGSizeMake(CATEGORY.count * SCREEN_WIDTH, 0.1);
    _bottomScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomScrollView.backgroundColor = [UIColor clearColor];
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bottomScrollView];
    self.oneVC = [[ViewControllerOne alloc]initWithContentsetY:self.normalH];
    _oneVC.scrollResponder = self;
    [self addChildViewController:_oneVC];
    self.oneVC.dataArr = [NSArray arrayWithArray:self.dataArr];
    self.oneVC.DisposeState = 6;
    [_oneVC didMoveToParentViewController:self];
    [self.bottomScrollView addSubview:self.oneVC.view];
    self.oneVC.view.frame = CGRectMake(0, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight);
    
    self.twoVC = [ViewControllerTwo new];
    _twoVC.scrollResponder = self;
    [self addChildViewController:_twoVC];
    [_twoVC didMoveToParentViewController:self];
    
    self.threeVC = [ViewControllerThree new];
    _threeVC.scrollResponder = self;
    [self addChildViewController:_threeVC];
    [_threeVC didMoveToParentViewController:self];

    self.fourVC = [ViewControllerFour new];
    _fourVC.scrollResponder = self;
    [self addChildViewController:_fourVC];
    [_fourVC didMoveToParentViewController:self];
    
    for (int index = 1; index < CATEGORY.count; index++) {
        [self addContainerSubViewsAtScrollTag:index];
    }
    _bottomScrollView.contentInsetAdjustmentBehavior = NO;
    [_bottomScrollView layoutIfNeeded];
    [_bottomScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

#pragma mark -private
- (void)reloadControllerAtScrollTag:(NSInteger)tag fromTag:(NSInteger)fromTag {
    [self addContainerSubViewsAtScrollTag:tag];
    if (tag != fromTag) {
        [self migrateContentOffsertAtScrollTag:tag fromTag:fromTag];
    }
    [self.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * tag, 0) animated:YES];
}

- (void)addContainerSubViewsAtScrollTag:(NSInteger)tag {
    BaseTableViewController *baseTableView = self.childViewControllers[tag];
    if (![baseTableView isViewLoaded]) {
        baseTableView.tableView.tag = tag;
        [self.bottomScrollView addSubview:baseTableView.view];
        
        baseTableView.view.frame = CGRectMake(SCREEN_WIDTH * tag, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight);
        baseTableView.tableView.contentInset = UIEdgeInsetsMake(segmentHeight + headerHeight, 0, 0, 0);
    }
}

- (void)migrateContentOffsertAtScrollTag:(NSInteger)tag fromTag:(NSInteger)fromTag {
    BaseTableViewController *nextController = self.childViewControllers[tag];
    BaseTableViewController *fromContrller = self.childViewControllers[fromTag];
    UITableView *nextCollectionView = nextController.tableView;
    UITableView *fromCollectionView = fromContrller.tableView;
    CGFloat fromOffsetY = fromCollectionView.contentOffset.y;
    if (fromOffsetY >= -40.0) {
        if (nextCollectionView.contentOffset.y < -40.0) {
            if (nextController.tableView.contentSize.height < (CGRectGetHeight(nextController.tableView.frame) - 40.f)) {
                [self companyBaseController:nextController scrollViewDidScroll:nextController.tableView];
            } else {
                [nextCollectionView setContentOffset:CGPointMake(0, -40.0) animated:NO];
            }
        }
    }else {
        if (nextController.tableView.contentSize.height < (CGRectGetHeight(nextController.tableView.frame) - 40.f)) {
            [self companyBaseController:nextController scrollViewDidScroll:nextController.tableView];
        } else {
            [nextCollectionView setContentOffset:CGPointMake(0, fromOffsetY) animated:NO];
        }
    }
}

#pragma mark - 点击选项卡方法
-(void)titleSegmentControlChanged:(HMSegmentedControl *)segmentedControl{
    [self reloadControllerAtScrollTag:segmentedControl.selectedSegmentIndex fromTag:self.segmentTag];
    self.segmentTag = segmentedControl.selectedSegmentIndex;
}
#pragma mark - scrollDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double dindex = scrollView.contentOffset.x/SCREEN_WIDTH;
    NSInteger index = (NSInteger)(dindex+0.5);
    if (index == self.segmentControl.selectedSegmentIndex) {
        return;
    }
    [self reloadControllerAtScrollTag:index fromTag:self.segmentTag];
    [self.segmentControl setSelectedSegmentIndex:index animated:YES];
    self.segmentTag = index;
}
#pragma mark - scrollResponder Delegate
- (void)baseTableScrollViewDidEndDecelerating:(UIScrollView *)scrollView {
}

- (void)baseTableScrollerViewWillEndDragging:(UIScrollView *)scrollerView {
}

- (void)companyBaseController:(BaseTableViewController *)baseController scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.segmentTag != self.segmentControl.selectedSegmentIndex) {
        return;
    }
    CGFloat detaY = (scrollView.contentOffset.y + self.normalH);
    if (detaY >= headerHeight) {
        self.zlheaderView.frame = CGRectMake(0, -headerHeight, SCREEN_WIDTH, headerHeight);
        self.segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, segmentHeight);
    }else {
        self.zlheaderView.frame = CGRectMake(0, -detaY, SCREEN_WIDTH, headerHeight);
        self.segmentControl.frame = CGRectMake(0, headerHeight-detaY, SCREEN_WIDTH, segmentHeight);
    }
}

#pragma mark - lazy
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[];
    }
    return _dataArr;
}

-(HMSegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, headerHeight, SCREEN_WIDTH, segmentHeight)];
        _segmentControl.sectionTitles = CATEGORY;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectionIndicatorHeight = 3;
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentControl.selectionIndicatorColor = [UIColor redColor];
        _segmentControl.segmentEdgeInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
        [_segmentControl setSelectedTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
        [_segmentControl addTarget:self action:@selector(titleSegmentControlChanged:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.userInteractionEnabled = NO;
        _segmentControl.multipleTouchEnabled = YES;
        _segmentControl.exclusiveTouch = NO;
    }
    return _segmentControl;
}

- (ZLHeader *)zlheaderView{
    if (!_zlheaderView) {
        _zlheaderView = [[ZLHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight) infoArr:@[@"本科",@"五年",@"28岁",@"汉族",@"党员",@"未婚",@"现居住于山东省枣庄市",@"山西省大同市户口"]];
        _zlheaderView.userInteractionEnabled = NO;
        _zlheaderView.multipleTouchEnabled = YES;
//        _zlheaderView.exclusiveTouch = YES;
    }
    return _zlheaderView;
}

- (void)parseJsonData {
    NSString *jsonString = [[NSBundle mainBundle]pathForResource:@"oneData" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonString];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    if ([dataDic[@"StatusMsg"] isEqualToString:@"查询成功"]) {
        MyResumePreviewDetailModel *model = [MyResumePreviewDetailModel new];
        [model setValuesForKeysWithDictionary:dataDic[@"ResultData"]];
        //self.disposeState = model.infoModel.DisposeState;
        self.dataArr = [MyResumePreviewSectionsModel myResumePreviewSectionsModelCovertFromModel:model];
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
