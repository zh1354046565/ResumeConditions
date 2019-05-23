//
//  MyResumePreviewLanguagesCell.m
//  ZLResume
//
//  Created by apple on 2018/9/13.
//  Copyright © 2018年 张磊. All rights reserved.
//

#import "MyResumePreviewLanguagesCell.h"
#import "MyResumePreviewLanguageItem.h"

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width

static CGFloat const BJXMyResumePreviewLanguagesCellCollectionViewTopMargin = 18.f;

static CGFloat const BJXMyResumePreviewLanguagesCellCollectionViewSideMargin = 12.f;

static CGFloat const BJXMyResumePreviewLanguagesCellCollectionViewMiddleMargin = 6.f;


@interface MyResumePreviewLanguagesCell()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) CGFloat collectionContenSizeHeigth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeigtConstraint;
@end
@implementation MyResumePreviewLanguagesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyResumePreviewLanguageItem" bundle:nil] forCellWithReuseIdentifier:MyResumePreviewLanguageItemIdentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}
#pragma mark ---
- (void)displayCellWithPreviewItems:(NSArray<MyResumePreviewItemModel *> *)previewItems {
    [super displayCellWithPreviewItems:previewItems];
//    _previewItems = previewItems;
    self.collectionViewHeigtConstraint.constant = self.collectionContenSizeHeigth;
    [self.collectionView reloadData];
}

#pragma mark -data source & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.previewItems.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return BJXMyResumePreviewLanguagesCellCollectionViewMiddleMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return BJXMyResumePreviewLanguagesCellCollectionViewMiddleMargin;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyResumePreviewLanguageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:MyResumePreviewLanguageItemIdentifier forIndexPath:indexPath];
    [item configLanguageItemWithModel:self.previewItems[indexPath.item]];
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}

#pragma mark - Getter
- (CGSize)itemSize {
    if (_itemSize.width == 0 || _itemSize.height == 0) {
        //floor 向下取整
        CGFloat width = floor((SCREEN_WIDTH - 2*BJXMyResumePreviewLanguagesCellCollectionViewSideMargin - BJXMyResumePreviewLanguagesCellCollectionViewMiddleMargin)*0.5);
        _itemSize = CGSizeMake(width, MyResumePreviewLanguageItemHeight);
    }
    return _itemSize;
}

- (CGFloat)collectionContenSizeHeigth {
    BOOL minRule = _collectionContenSizeHeigth < ceilf(MyResumePreviewLanguageItemHeight + 2 * BJXMyResumePreviewLanguagesCellCollectionViewTopMargin);
    if (minRule) {
        NSInteger totalCount = self.previewItems.count;
        NSInteger section = totalCount % 2 ? (totalCount/2 + 1):(totalCount/2);
        
        _collectionContenSizeHeigth = ceilf(MyResumePreviewLanguageItemHeight * section + (section - 1)*BJXMyResumePreviewLanguagesCellCollectionViewMiddleMargin);
    }
    return _collectionContenSizeHeigth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
