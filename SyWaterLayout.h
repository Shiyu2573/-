//
//  SyWaterLayout.h
//  瀑布流
//
//  Created by Shiyu on 16/4/9.
//  Copyright © 2016年 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SyWaterLayout;
@protocol SyWaterLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(SyWaterLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end


@interface SyWaterLayout : UICollectionViewLayout
/* 每一列的间距*/
@property (nonatomic ,assign) CGFloat columMargin;

/* 每一行的间距*/
@property (nonatomic ,assign) CGFloat rowMargin;

/* 上下左右的间距  */
@property (nonatomic ,assign) UIEdgeInsets sectionInset;

/* 显示多少列*/
@property (nonatomic ,assign) int columnsCount;

@property (nonatomic ,weak) id<SyWaterLayoutDelegate> delegaet;

@end
