//
//  HLMoveItemCollectionViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/22.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLMoveItemCollectionViewController.h"
#import "HLMoveItemCollectionViewController.h"

@interface HLMoveItemCollectionViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *label;
@end

@implementation HLMoveItemCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseIdentifierForHeader = @"reuseIdentifierForHeader";
static NSString * const reuseIdentifierForfooter = @"reuseIdentifierForfooter";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierForHeader];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseIdentifierForfooter];
   
    // Do any additional setup after loading the view.
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.dataSource.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *temArr = self.dataSource[section];
    return temArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",self.dataSource.description);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor randomColor];
    for (UIView *view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
        
    }
    
     NSArray *temArr = self.dataSource[indexPath.section];
    UILabel *label = [[UILabel alloc] init];
    [cell.contentView addSubview:label];
    label.font = [UIFont systemFontOfSize:50];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = temArr[indexPath.item];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell.contentView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)view;
            NSLog(@"%@",label.text);
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *suppliment;
   
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        suppliment = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierForHeader forIndexPath:indexPath];
        //   为了防止重复添加,在添加前先删除
        for (UIView *view in suppliment.subviews) {
            [view removeFromSuperview];
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"我会header";
        label.backgroundColor = [UIColor yellowColor];
        label.frame = CGRectMake(0, 0, kScreenWidth, suppliment.bounds.size.height);
        [suppliment addSubview:label];
    }else {
        
        suppliment = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifierForfooter forIndexPath:indexPath];
        //   为了防止重复添加,在添加前先删除
        for (UIView *view in suppliment.subviews) {
            [view removeFromSuperview];
        }
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
        [btn setTitle:@"我是footer" forState:UIControlStateNormal];
         btn.frame = CGRectMake(0, 0, kScreenWidth, suppliment.bounds.size.height);
        [suppliment addSubview:btn];
    }
    return suppliment;
}


// 设置Header的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 30);
}

//// 设置Footer的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(screenWidth, 50);
}
#pragma mark - 让item能移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -  相同section和不同section元素的移动
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //  如果实在同一个section内移动
    if (sourceIndexPath.section == destinationIndexPath.section) {
    
         NSMutableArray *ActionArr = [NSMutableArray arrayWithArray:self.dataSource[sourceIndexPath.section]];
        
        [ActionArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        
        [self.dataSource replaceObjectAtIndex:sourceIndexPath.section withObject:ActionArr];
    }
    //  如果是在不同的section,那么从sourceIndexPath删除对应的元素,destinationIndexPath增加对应的元素
    if (sourceIndexPath.section != destinationIndexPath.section) {
        NSMutableArray *sortedArr = [NSMutableArray arrayWithArray:self.dataSource];
        //  找出源section中的元素
        NSMutableArray *sourceArr = [NSMutableArray arrayWithArray:sortedArr[sourceIndexPath.section]];
        NSString *source = sourceArr[sourceIndexPath.item];
//        //  找出目标section中的元素
        NSMutableArray *destinationArr = [NSMutableArray arrayWithArray:sortedArr[destinationIndexPath.section]];
//
        [sourceArr removeObjectAtIndex:sourceIndexPath.item];

        [destinationArr insertObject:source atIndex:destinationIndexPath.item ];
        NSLog(@"%ld",sourceIndexPath.section);
        
        
        [sortedArr replaceObjectAtIndex:sourceIndexPath.section withObject:sourceArr];
        [sortedArr replaceObjectAtIndex:destinationIndexPath.section withObject:destinationArr];
        

        self.dataSource = sortedArr.copy;
        NSLog(@"%@",self.dataSource);
    }
    
    [self.collectionView reloadData];
  
    
    
    
    
}


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark - 懒加载数据源
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@[@"0",@"1",@"2",@"3",@"4"],@[@"0",@"1",@"2",@"3",@"4"],@[@"0",@"1",@"2",@"3",@"4"],@[@"0",@"1",@"2",@"3",@"4"]]];
    }
    return _dataSource;
}
@end
