//
//  ViewControllerOne.m
//  ZLResume
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ViewControllerOne.h"
#import "MJRefresh.h"
#import "ZLHeaderSectionView.h"
#import "MyResumePreviewSectionsModel.h"
#import "MyResumePreviewDetailModel.h"
#import "MyResumePreviewCell.h"
#import "ResumePreviewDetailTypeView.h"

static NSString* const oneCellID = @"OneCell";
#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

@interface ViewControllerOne ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)CGFloat contentset_top;

@end

@implementation ViewControllerOne


- (instancetype)initWithContentsetY:(CGFloat)top {
    if (self = [super init]) {
        self.contentset_top = top;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(self.contentset_top, 0, 0, 0);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 240.f;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = 0.0001;
    [self configTableView];
    if (self.DisposeState==0 || self.DisposeState == 1 || self.DisposeState == 2 || self.DisposeState == 6 || self.DisposeState == 7) {
        ResumePreviewDetailTypeView *footerView = [[ResumePreviewDetailTypeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55) type:self.DisposeState];
        footerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        footerView.ResumePreviewBlock = ^(NSInteger indextag) {
            self.tableView.tableFooterView = [UIView new];
        };
        self.tableView.tableFooterView = footerView;
    }
    [self.view addSubview:self.tableView];
}

- (void)configTableView {

    NSMutableSet *cellIdentifierSet = [NSMutableSet set];
    [self.dataArr enumerateObjectsUsingBlock:^(MyResumePreviewSectionsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![cellIdentifierSet containsObject:obj.cellIdentifier]) {
            UINib *nib = [UINib nibWithNibName:obj.cellName bundle:nil];
            [self.tableView registerNib:nib forCellReuseIdentifier:obj.cellIdentifier];
        }
    }];
    
}


- (void)addheaderRefresh {
    [self.tableView reloadData];
}

- (void)reloadDatas {
    [self addheaderRefresh];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [ZLHeaderSectionView conifgMyResumePreviewTableHeaderViewWithSectionsModel:self.dataArr[section] forTableView:tableView];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 260;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return MyResumePreviewTableHeaderViewHeight;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return 10;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MyResumePreviewSectionsModel *sectionModel = self.dataArr[section];
    if (sectionModel.shouldHorizontalDisplay) {
        return 1;
    }
    return sectionModel.previewItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:oneCellID];
//    }
//    cell.textLabel.text = @"123456789";
//    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.f];
//    return cell;
    return [MyResumePreviewCell dequeueMyResumePreviewCellWithSectionModel:self.dataArr[indexPath.section] forTableView:tableView rowAtIndexPath:indexPath];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
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
//
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    if (self.scrollResponder && [self.scrollResponder respondsToSelector:@selector(baseTableScrollerViewWillEndDragging:)]) {
//        [self.scrollResponder baseTableScrollerViewWillEndDragging:self.tableView];
//    }
//}


//- (void)parseJsonData {
//    NSString *jsonString = [[NSBundle mainBundle]pathForResource:@"oneData" ofType:@"json"];
//    NSData *jsonData = [NSData dataWithContentsOfFile:jsonString];
//    
//    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
//    if ([dataDic[@"StatusMsg"] isEqualToString:@"查询成功"]) {
//        MyResumePreviewDetailModel *model = [MyResumePreviewDetailModel new];
//        [model setValuesForKeysWithDictionary:dataDic[@"ResultData"]];
//
//        self.dataArr = [MyResumePreviewSectionsModel myResumePreviewSectionsModelCovertFromModel:model];
//        [self configTableView];
//        [self.tableView reloadData];
//    }
//}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self.tableView setContentOffset:scrollView.contentOffset animated:NO];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//     [self.tableView setContentOffset:scrollView.contentOffset animated:NO];
    
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
