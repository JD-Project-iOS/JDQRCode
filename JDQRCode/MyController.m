//
//  MyController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/12/5.
//  Copyright © 2018 jd. All rights reserved.
//

#import "MyController.h"
#import "JDCommonNavBar.h"
#import "HomeCell.h"

@interface MyController () <JDCommonNavBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *mainCollectionView;
}

@property (strong, nonatomic) JDCommonNavBar *navBar;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation MyController

+ (void)startWithNav:(UINavigationController *)nav
                data:(id)data {
    MyController *vc = [MyController new];
    vc.dataList = data;
    [nav pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCustomNavbar];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)initCustomNavbar {
    JDCommonNavBar *nav = [[JDCommonNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    nav.delegate = self;
    nav.backgroundColor = [UIColor whiteColor];
    [nav initWithLeftButtonImageName:@"icon_back_black_nav"
             andRightButtonImageName:nil
                            andTitle:@"我的二维码"];
    [self.view addSubview:nav];
}

- (void)initSubViews {
    self.view.backgroundColor = COLOR_BG;
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 10);
    //    //该方法也可以设置itemSize
    //    layout.itemSize =CGSizeMake(110, 150);
//    self.data = @[@{@"name":@"基本二维码",@"image":Empty_Image},
//                  @{@"name":@"自定义logo二维码",@"image":Empty_Image},
//                  @{@"name":@"生成彩色二维码",@"image":Empty_Image},
//                  @{@"name":@"生成彩色带logo二维码",@"image":Empty_Image}];

    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, kStatusBarAndNavigationBarHeight, kScreenWidth - 40, self.view.height - kStatusBarAndNavigationBarHeight) collectionViewLayout:layout];
    [self.view addSubview:mainCollectionView];
    mainCollectionView.showsVerticalScrollIndicator = NO;
    mainCollectionView.backgroundColor = [UIColor clearColor];

    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"HomeCell"];

    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
}

#pragma mark - UICollectionViewDataSource

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = (HomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    //    [cell.image setImageWithUrlString:[self.data[indexPath.row] objectForKey:@"cover"]];

    cell.image.image = [UIImage imageWithContentsOfFile:[self.dataList[indexPath.row] objectForKey:@"path"]];
    cell.titleLabel.text = [self.dataList[indexPath.row] objectForKey:@"name"];

    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 40)/2 - 10, (kScreenWidth - 40)/2 - 10);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSDictionary *dic = self.data[indexPath.row];
//    switch (indexPath.row) {
//        case 0:
//            [EditeQRCodeController startWithNav:self.navigationController];
//            break;
//        case 1:
//            [EditeQRCodeController startWithNav:self.navigationController];
//            break;
//        case 2:
//            [EditeQRCodeController startWithNav:self.navigationController];
//            break;
//
//        default:
//            break;
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell *)[mainCollectionView cellForItemAtIndexPath:indexPath];
    cell.topView.hidden = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = (HomeCell *)[mainCollectionView cellForItemAtIndexPath:indexPath];
    cell.topView.hidden = NO;
}

#pragma mark

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark ----------CustomNavBarDelegate

- (void)onJDCommonNavBarLeftButtonTouch:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
