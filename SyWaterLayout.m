//
//  SyWaterLayout.m
//  瀑布流
//
//  Created by Shiyu on 16/4/9.
//  Copyright © 2016年 shiyu. All rights reserved.
//

#import "SyWaterLayout.h"


@interface SyWaterLayout()

/* 存储每一列的最大Y值(每一列的高度)*/
@property (nonatomic ,strong) NSMutableDictionary *maxYDict;
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;@end

@implementation SyWaterLayout


#pragma mark - 懒加载
- (NSMutableDictionary *)maxYDict
{
    if(!_maxYDict)
    {
        self.maxYDict = [[NSMutableDictionary alloc] init];
    }
    return _maxYDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

/**
 *   布局初始完毕,默认的列,行间距
 */
-(instancetype)init
{
    if (self = [super init]) {
        self.columMargin = 10;
        self.rowMargin = 10;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;

}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  每次布局前准备
 */
-(void)prepareLayout
{
    //清空最大Y值
    for (int i = 0; i<self.columnsCount; i++) {
        NSString *column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @0;
    }
    //计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
    
}
/**
 *  返回所有的尺寸
 */
-(CGSize)collectionViewContentSize
{
    __block NSString *maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL * stop) {
        
        if ([maxY floatValue]<[self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];


    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue]);

}
/**
 *  返回indexPath这个位置Item的布局属性
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的的那一列是第0列
    __block NSString *minColumn = @"0";
    /* 字典的Key为列号,value是对应那一列的Y值*/
    /* 遍历每个列的最大的Y值*/
    /* 找出最短的那一列*/
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL * stop) {
        
        if ([maxY floatValue]<[self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    //计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columMargin)/self.columnsCount;
    CGFloat height = [self.delegaet waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
    
    //计算位置
    CGFloat x = self.sectionInset.left + (width + self.columMargin) * [minColumn intValue];
    CGFloat y = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    //更新这一列的最大Y值
    self.maxYDict[minColumn] = @(y + height);
    
    //创建属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(x,y, width, height);
    return attributes;
}

/**
 *  返回rect范围内的布局属性
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attrsArray;

}
@end
