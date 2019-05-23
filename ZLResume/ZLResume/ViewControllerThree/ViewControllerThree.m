//
//  ViewControllerThree.m
//  ZLResume
//
//  Created by apple on 2018/8/28.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ViewControllerThree.h"
#import "ZLThreeModel.h"
#import "ZLThreeDataModel.h"
#import "ZLThreeCell.h"
#import "MJRefresh.h"
#define TextFont(a) [UIFont fontWithName:@"PingFang-SC-Medium" size:a]
#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define KCellHeight 70
@interface ViewControllerThree ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray <ZLThreeModel *>*dataArr;
@property (nonatomic, strong)NSMutableArray <ContentModel *> *contentArr;
@property (nonatomic, strong)NSMutableArray <ZLThreeDataModel *>*resumeArr;

@property (nonatomic, strong)NSMutableArray <ZLThreeDataModel *>*ZLArr;

@end

@implementation ViewControllerThree
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"ZLThreeCell" bundle:nil] forCellReuseIdentifier:@"threeCell"];
    [self.view addSubview:self.tableView];
    [self addFooterRefresh];
    [self loadData];
}
//优先加载本地数据
- (void)reloadDatas {
    if (self.dataArr.count > 0) {
        [self.tableView reloadData];
    }else {
        [self loadData];
    }
}
//解析数据
- (void)loadData {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"record" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    NSArray *dataArr = jsonDic[@"ResultData"][@"OperaInfoList"];
    NSArray *InfoArr = jsonDic[@"ResultData"][@"InterviewInfo"];
    int indexCount = 0;
    for (NSDictionary *dic in dataArr) {
        ZLThreeModel *model = [ZLThreeModel new];
        ContentModel *contentModel = [ContentModel new];
        
        [model setValuesForKeysWithDictionary:dic];
        if (model.IsInnerView) {
            indexCount = +indexCount;
            [contentModel setValuesForKeysWithDictionary:InfoArr[indexCount]];
            [self.contentArr addObject:contentModel];
        }
        [self.dataArr addObject:model];
    }
    if (self.dataArr.count == 1) {
        ZLThreeModel *model = self.dataArr.firstObject;
        model.first = YES;
        model.last = YES;
    }else if(self.dataArr.count > 1) {
        ZLThreeModel *modelFirst = self.dataArr.firstObject;
        modelFirst.first = YES;
        ZLThreeModel *modelLast = self.dataArr.lastObject;
        modelLast.last = YES;
    }
    self.resumeArr = [ZLThreeDataModel dataArr:self.dataArr contentArr:self.contentArr];
    self.ZLArr = [ZLThreeDataModel dataArr:self.dataArr contentArr:self.contentArr];
    [self.tableView reloadData];
}

-(void)addFooterRefresh{
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [self.resumeArr addObjectsFromArray:self.ZLArr];
    }];
//    [self.tableView.mj_footer beginRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    });
    
}

#pragma mark - lazy
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}
- (NSMutableArray *)contentArr {
    if (!_contentArr) {
        _contentArr = @[].mutableCopy;
    }
    return _contentArr;
}
- (NSMutableArray *)resumeArr {
    if (!_resumeArr) {
        _resumeArr = @[].mutableCopy;
    }
    return _resumeArr;
}

- (NSMutableArray<ZLThreeDataModel *> *)ZLArr {
    if (!_ZLArr) {
        _ZLArr = @[].mutableCopy;
    }
    return _ZLArr;
}
#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resumeArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataM:self.resumeArr[indexPath.row]];
    return cell;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.scrollResponder && [self.scrollResponder respondsToSelector:@selector(companyBaseController:scrollViewDidScroll:)]) {
//        [self.scrollResponder companyBaseController:self scrollViewDidScroll:self.tableView];
//    }
//}
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
