//
//  HLCollectionTableViewController.m
//  DemoCollections
//
//  Created by helong on 16/9/8.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLCollectionTableViewController.h"
#import "HLDynamicCollectionViewCell.h"

@interface HLCollectionTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collection;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *perArray;
@end

@implementation HLCollectionTableViewController
static NSString *reusableCell = @"reusableCell";
//static NSString *reusableCell = @"reusableCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArray = @[@[@"1111",@"2222"],@[@"3333"],@[@"4444",@"5555",@"6666"]];
    self.perArray = @[@[@0.3,@0.7],@[@1.0],@[@0.2,@0.3,@0.5]];
    [self configureUI];
}

- (void)configureUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing  = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    self.collection = collection;
    collection.pagingEnabled = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    
    [self.collection registerClass:[HLDynamicCollectionViewCell class] forCellWithReuseIdentifier:reusableCell];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLDynamicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reusableCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    
    cell.titleArray = self.titleArray[indexPath.item];
    cell.perArray = self.perArray[indexPath.item];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
- (NSArray *)perArray {
    if (!_perArray) {
        _perArray = [NSArray array];
    }
    return _perArray;
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
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
