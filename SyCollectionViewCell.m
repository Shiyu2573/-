//
//  SyCollectionViewCell.m
//  瀑布流
//
//  Created by Shiyu on 16/4/9.
//  Copyright © 2016年 shiyu. All rights reserved.
//

#import "SyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Syshop.h"
@implementation SyCollectionViewCell

-(void)setShop:(Syshop *)shop
{
    _shop = shop;
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    self.priceLabel.text = shop.price;

}
@end
