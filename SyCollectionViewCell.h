//
//  SyCollectionViewCell.h
//  瀑布流
//
//  Created by Shiyu on 16/4/9.
//  Copyright © 2016年 shiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Syshop;
@interface SyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic ,strong) Syshop *shop;
@end
