//
//  ViewControllerTwo.m
//  ZLResume
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "ZLViewController.h"
#import "TableViewCell.h"
#import "DataHandle.h"
#import "ZLFooterView.h"

#define footHeight 100
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0

@interface ZLViewController ()<UITableViewDelegate,UITableViewDataSource,BtnActionDelegate,ZLFooterViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)ZLFooterView *footerView;
@property (nonatomic, strong)NSDictionary *dic;

@end

@implementation ZLViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = @[@"意向行业",
                            @"意向地区",
                            @"学历要求",
                            @"工作年限",
                            @"年龄要求",
                            @"薪酬范围",
                            @"更新日期",
                            @"毕业院校",
                            @"专业名称",
                            @"性别要求",
                            @"户口所在地",
                            @"当前工作状态",
                            @"婚姻状态",
                            @"民族",
                            @"政治面貌",
                            @"所获证书",
                            @"语言能力",].mutableCopy;
    
    NSMutableArray *dataArr = @[].mutableCopy;
    for (SBESearchConditionStatusModel *model in self.sourceArr) {
        [arr removeObject:model.statusName];
        [dataArr addObject:model.statusName];
    }
    
    _dic = @{@"one":[NSArray arrayWithArray:dataArr],
             @"two":arr
             };
    //进入界面,保存返回的数据(再将tableView添加到self.view)

    [[NSUserDefaults standardUserDefaults] setObject:_dic forKey:@"defaultData"];
    [self.view addSubview:self.tableView];
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-kStatusBarHeight - kNavBarHeight) style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _footerView = [[ZLFooterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, footHeight)];
        _footerView.delegate = self;
        _tableView.tableFooterView = _footerView;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"zlcell"];
        
    }
    return _tableView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 30)];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    NSString *str;
    if ([key isEqualToString:@"one"]) {
        str = [NSString stringWithFormat:@"已添加%ld个搜索条件(最少选6个,最多选9个)",array.count];
        //@"已添加%ld个搜索条件(最少选6个,最多选9个)"
        
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
                NSRange rang = [str rangeOfString:[NSString stringWithFormat:@"%ld",array.count]];
        //        //设置标签文字属性
                [attributeString setAttributes:[NSMutableDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, nil] range:rang];
        
        label.attributedText = attributeString;
        
    }else {
        label.text = @"未添加搜索条件";
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [DataHandle shareDataHandle].allKeysArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zlcell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:indexPath.section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    SBESearchConditionStatusModel *model = array[indexPath.row];
    if ([key isEqualToString:@"one"]) {
        [cell setModel:model indexTag:0 showWhatBtn:ShowWhatBtnDef];
    }else{
        [cell setModel:model indexTag:0 showWhatBtn:ShowWhatBtnNotAdd];
    }
    cell.indexP = indexPath;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:indexPath.section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    for (SBESearchConditionStatusModel *model in array) {
        if (model.is_Select) {
            model.is_Select = NO;
        }
    }
    SBESearchConditionStatusModel *model = array[indexPath.row];
    model.is_Select = YES;
    if ([[DataHandle shareDataHandle].allKeysArray containsObject:@"one"]) {
        [cell setModel:model indexTag:0 showWhatBtn:ShowWhatBtnDef];
    }else{
        [cell setModel:model indexTag:0 showWhatBtn:ShowWhatBtnNotAdd];
    }
    [tableView reloadData];
    
}
#pragma mark - cellDelegate
- (void)minCell:(NSIndexPath *)indexP {
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:indexP.section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    //判断
    if (array.count == 6) {
        [self alertMessage:@"搜索条件最少选6个"];
        return;
    }
    SBESearchConditionStatusModel *model = array[indexP.row];
    model.is_Select = NO;
    [array removeObjectAtIndex:indexP.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:(UITableViewRowAnimationFade)];
    if (![[DataHandle shareDataHandle].allKeysArray containsObject:@"two"]) {
        [[DataHandle shareDataHandle].allKeysArray addObject:@"two"];
        NSMutableArray *array = @[].mutableCopy;
        [array addObject:model];
        [[DataHandle shareDataHandle].allDic setValue:array forKey:@"two"];
        [self.tableView reloadData];
    }else {
        if (array.count == 0) {
            /**删除section*/
            [[DataHandle shareDataHandle].allKeysArray removeObjectAtIndex:indexP.section];
            [[DataHandle shareDataHandle].allDic removeObjectForKey:key];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexP.section] withRowAnimation:(UITableViewRowAnimationFade)];
            /***删除后添加***/
            NSString *addkey = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:0];
            NSMutableArray *addArray = [[DataHandle shareDataHandle].allDic objectForKey:addkey];
            [addArray insertObject:model atIndex:0];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationFade)];
        }else{
            /**为了让区头文字变化***/
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationFade)];
            /**删除后添加**/
            NSString *addkey = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:1];
            NSMutableArray *addArray = [[DataHandle shareDataHandle].allDic objectForKey:addkey];
            [addArray insertObject:model atIndex:0];
            
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
        }
    }
}
- (void)maxCell:(NSIndexPath *)indexP {
    NSString *key = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:indexP.section];
    NSMutableArray *array = [[DataHandle shareDataHandle].allDic objectForKey:key];
    //判断已添加的数组个数
    if (indexP.section == 1) {
        NSString *keyOne = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:0];
        NSMutableArray *judgeArray = [[DataHandle shareDataHandle].allDic objectForKey:keyOne];
        if (judgeArray.count == 9) {
            [self alertMessage:@"搜索条件最多选9个"];
            return;
        }
    }
    SBESearchConditionStatusModel *model = array[indexP.row];
    model.is_Select = NO;
    [array removeObjectAtIndex:indexP.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexP] withRowAnimation:(UITableViewRowAnimationFade)];
    
    if (![[DataHandle shareDataHandle].allKeysArray containsObject:@"one"]) {
        [[DataHandle shareDataHandle].allKeysArray insertObject:@"one" atIndex:0];
        NSMutableArray *array = @[].mutableCopy;
        [array addObject:model];
        [[DataHandle shareDataHandle].allDic setValue:array forKey:@"one"];
        [self.tableView reloadData];
    }else{
        /**删除section**/
        if (array.count == 0) {
            [[DataHandle shareDataHandle].allKeysArray removeObjectAtIndex:indexP.section];
            [[DataHandle shareDataHandle].allDic removeObjectForKey:key];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexP.section] withRowAnimation:(UITableViewRowAnimationFade)];
        }
        /******/
        NSString *addkey = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:0];
        NSMutableArray *addArray = [[DataHandle shareDataHandle].allDic objectForKey:addkey];
        [addArray addObject:model];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationFade)];
    }
}
#pragma mark - footerDelegate
- (void)restoreDefaultOptions {
    //恢复默认数据; 返回一个string(只仅仅为了消除'报黄',无其他作用)
    NSString *str = [DataHandle shareDataHandle].resetInstance;
    NSLog(@"%@",str);
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isDefault"];
    [self.tableView reloadData];
}

- (void)alertMessage:(NSString *)message{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    [alertC addAction:alertAction];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSMutableArray *StatusListArr = @[].mutableCopy;
    //取出添加的标签
    NSString *oneKey = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:0];
    NSMutableArray <SBESearchConditionStatusModel *>*oneArray = [[DataHandle shareDataHandle].allDic objectForKey:oneKey];
    
    for (SBESearchConditionStatusModel *model in oneArray) {
        NSMutableDictionary *dic = [self getStatusID:model.statusName];
        [dic setObject:@(1) forKey:@"StatusShow"];
        
        model.statusID = [dic[@"StatusID"] integerValue];
        model.isStatusShow = YES;
        
        [StatusListArr addObject:dic];
    }

    //取出未添加的标签
    NSString *twoKey = [[DataHandle shareDataHandle].allKeysArray objectAtIndex:1];
    NSMutableArray <SBESearchConditionStatusModel *>*twoArray = [[DataHandle shareDataHandle].allDic objectForKey:twoKey];
    for (SBESearchConditionStatusModel *model in twoArray) {
        NSMutableDictionary *dic = [self getStatusID:model.statusName];
        [dic setObject:@0 forKey:@"StatusShow"];
        [StatusListArr addObject:dic];
    }
    
    NSMutableDictionary *dataDic = @{}.mutableCopy;
    [dataDic setObject:StatusListArr forKey:@"StatusList"];
    
    /********************************/
    NSMutableArray *dataArr = [NSArray arrayWithArray:oneArray].mutableCopy;
    
    for (SBESearchConditionStatusModel *sourceModel in self.sourceArr) {
        for (int i = 0; i < oneArray.count-1; i++) {
            if ([sourceModel.statusName isEqualToString:[oneArray[i] statusName]]) {
                [dataArr removeObject:oneArray[i]];
                [dataArr insertObject:sourceModel atIndex:i];
                break;
            }
        }
    }
    
    /*************************/
    if (_SBESearchConditionStatusBlock) {
        _SBESearchConditionStatusBlock(dataArr);
    }
    NSString *str = [DataHandle shareDataHandle].resetInstance;
    NSLog(@"%@",str);
    
}


- (NSMutableDictionary *)getStatusID:(NSString *)statusName {
    
    if ([statusName isEqualToString:@"意向行业"]) {
        return @{
                 @"StatusID":@1,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"意向地区"]) {
        return @{
                 @"StatusID":@2,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"学历要求"]) {
        return @{
                 @"StatusID":@3,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"工作年限"]) {
        return @{
                 @"StatusID":@4,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"年龄要求"]) {
        return @{
                 @"StatusID":@5,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"薪酬范围"]) {
        return @{
                 @"StatusID":@6,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"更新日期"]) {
        return @{
                 @"StatusID":@7,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"毕业院校"]) {
        return @{
                 @"StatusID":@8,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"专业名称"]) {
        return @{
                 @"StatusID":@9,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"性别要求"]) {
        return @{
                 @"StatusID":@10,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"户口所在地"]) {
        return @{
                 @"StatusID":@11,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"当前工作状态"]) {
        return @{
                 @"StatusID":@12,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"婚姻状态"]) {
        return @{
                 @"StatusID":@13,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"民族"]) {
        return @{
                 @"StatusID":@14,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"政治面貌"]) {
        return @{
                 @"StatusID":@15,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"所获证书"]) {
        return @{
                 @"StatusID":@16,
                 @"StatusName":statusName
                 }.mutableCopy;
    }else if ([statusName isEqualToString:@"语言能力"]) {
        return @{
                 @"StatusID":@17,
                 @"StatusName":statusName
                 }.mutableCopy;
    }
    
    return 0;
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
