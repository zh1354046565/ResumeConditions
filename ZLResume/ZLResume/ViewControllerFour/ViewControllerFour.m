//
//  ViewControllerThree.m
//  ZLResume
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ViewControllerFour.h"
#import "FourCell.h"
#import "ZLThreeModel.h"



#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

@interface ViewControllerFour ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy)NSString *stringCell;

@property (nonatomic, strong)NSArray *datasourceArr;

@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation ViewControllerFour

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kStatusBarHeight-kNavBarHeight) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[FourCell class] forCellReuseIdentifier:@"threeCell"];
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

- (void)reloadDatas:(NSString *)indexStr {
    if (self.dataArr.count > 0) {
        [self.tableView reloadData];
    }else {
        [self loadData];
    }
}

- (void)loadData{
    NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"delivery" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    NSArray *dataArr = dataDic[@"ResultData"][@"DeliverInfoList"];
    
    for (NSDictionary *dic in dataArr) {
        ZLThreeModel *model = [ZLThreeModel new];
        [model setValuesForKeysWithDictionary:dic];
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
    [self.tableView reloadData];

}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.dataArr[indexPath.row]];
    return cell;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 70;
//}

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
