//
//  ViewController.m
//  瀑布流
//
//  Created by Shiyu on 16/4/9.
//  Copyright © 2016年 shiyu. All rights reserved.
//

#import "ViewController.h"
#import "SyWaterLayout.h"
#import "SyCollectionViewCell.h"
#import "MJExtension.h"
#import "Syshop.h"
#import "MJRefresh.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SyWaterLayoutDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *shops;

@end
//注册表格ID
static NSString *const ID = @"shop";
@implementation ViewController

- (NSMutableArray *)shops
{
    if(!_shops)
    {
        self.shops = [[NSMutableArray alloc] init];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *shopAry = [Syshop objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopAry];
    NSLog(@"%@",shopAry);
    SyWaterLayout *layout = [[SyWaterLayout alloc]init];
    layout.delegaet = self;

    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:self.collectionView];
    // 3.增加刷新控件
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreShops)];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shopArray = [Syshop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shopArray];
        [self.collectionView reloadData];
        [self.collectionView footerEndRefreshing];
    });
}
#pragma mark - SyWaterLayoutDelegate;
-(CGFloat)waterflowLayout:(SyWaterLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{

    Syshop *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return  self.shops.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
