//
//  HomeController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/12/5.
//  Copyright © 2018 jd. All rights reserved.
//

#import "HomeController.h"
#import "JDCommonNavBar.h"
#import "HomeCell.h"
#import "EditeQRCodeController.h"
#import "MyController.h"
#import "JMScanningQRCodeVC.h"
#import "JMQRCode.h"

@interface HomeController () <JDCommonNavBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
    UICollectionView *mainCollectionView;
}

@property (strong, nonatomic) JDCommonNavBar *navBar;
@property (nonatomic, strong) NSArray  *dataList;

//@property (nonatomic, retain) id <IJKMediaPlayback>play;
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UIButton *tipBtn;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCustomNavbar];
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [_tipBtn setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)[self getNewCacheTip].count] forState:UIControlStateNormal];
}

- (void)initCustomNavbar {
    JDCommonNavBar *nav = [[JDCommonNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    nav.delegate = self;
    nav.backgroundColor = [UIColor whiteColor];
    [nav initWithLeftButtonImageName:nil
             andRightButtonImageName:nil
                            andTitle:@"二维码模版"];
    [nav setRightButtonTitle:@"扫描" WithColor:[UIColor blackColor]];
    [nav setLeftButtonTitle:@"清缓" WithColor:[UIColor redColor]];
    [self.view addSubview:nav];
}

- (void)initSubViews {
    self.view.backgroundColor = COLOR_BG;
    [self.view addSubview:self.myView];

    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 10);
    //    //该方法也可以设置itemSize
    //    layout.itemSize =CGSizeMake(110, 150);
    self.data = @[@{@"name":@"基本二维码",@"image":Empty_Image},
                  @{@"name":@"自定义logo二维码",@"image":Empty_Image},
                  @{@"name":@"生成彩色二维码",@"image":Empty_Image},
                  @{@"name":@"生成彩色带logo二维码",@"image":Empty_Image}];

    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, kStatusBarAndNavigationBarHeight + 60, kScreenWidth - 40, self.view.height - kStatusBarAndNavigationBarHeight - 60) collectionViewLayout:layout];
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

- (UIView *)myView {
    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarAndNavigationBarHeight + 10, kScreenWidth, 40)];
        _myView.backgroundColor = [UIColor whiteColor];
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        nameBtn.frame = _myView.bounds;
        [nameBtn addTarget:self action:@selector(touchNameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myView addSubview:nameBtn];

        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
        nameLabel.text = @"我的二维码";

        [_myView addSubview:nameLabel];

        _tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tipBtn.frame = CGRectMake(kScreenWidth - 30, 10, 20, 20);
        [_tipBtn setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)[self getNewCacheTip].count] forState:UIControlStateNormal];
        [_tipBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_tipBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 30)];
        [_tipBtn setImage:[UIImage imageNamed:@"icon_go_gray"] forState:UIControlStateNormal];
        [_tipBtn addTarget:self action:@selector(touchNameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_myView addSubview:_tipBtn];
    }
    return _myView;
}

- (void)touchNameBtn:(id)sender {
    [MyController startWithNav:self.navigationController data:[self getNewCacheTip]];
}

- (NSMutableArray *)getNewCacheTip {
    NSMutableArray *arr = [NSMutableArray array];
    if ([[UserUtil findPath] objectForKey:@"list"]&&[[[UserUtil findPath] objectForKey:@"list"] count] > 0) {
        arr = [[[UserUtil findPath] objectForKey:@"list"] mutableCopy];
    }
    return arr;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = (HomeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
//    [cell.image setImageWithUrlString:[self.data[indexPath.row] objectForKey:@"cover"]];
    switch (indexPath.row) {
        case 0:
            [cell.image setImage:[JMGenerateQRCodeUtils jm_generateQRCodeWithString:@"https://www.baidu.com" imageSize:CGSizeMake(cell.width, cell.height)]];
            break;
        case 1:
            [cell.image setImage:[JMGenerateQRCodeUtils jm_generateQRCodeWithString:@"https://www.baidu.com" imageSize:CGSizeMake(cell.width, cell.height) logoImageName:[UIImage imageNamed:@"icon_logo"] logoImageSize:CGSizeMake(40, 40)]];
            break;
        case 2:
            [cell.image setImage:[JMGenerateQRCodeUtils jm_generateColorQRCodeWithString:@"https://www.baidu.com" imageSize:CGSizeMake(cell.width, cell.height) rgbColor:[CIColor colorWithRed:200.0/255.0 green:70.0/255.0 blue:189.0/255.0] backgroundColor:[CIColor colorWithRed:0 green:0 blue:0]]];
            break;
        case 3:
            [cell.image setImage:[JMGenerateQRCodeUtils jm_generateColorQRCodeWithString:@"https://www.baidu.com" imageSize:CGSizeMake(cell.width, cell.height) rgbColor:[CIColor colorWithRed:200.0/255.0 green:70.0/255.0 blue:189.0/255.0] backgroundColor:[CIColor colorWithRed:1 green:1 blue:1] logoImageName:[UIImage imageNamed:@"icon_logo"] logoImageSize:CGSizeMake(30, 30)]];
            break;
        default:
            break;
    }

    cell.titleLabel.text = [self.data[indexPath.row] objectForKey:@"name"];

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
    switch (indexPath.row) {
        case 0:
            [EditeQRCodeController startWithNav:self.navigationController type:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            break;
        case 1:
            [EditeQRCodeController startWithNav:self.navigationController type:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            break;
        case 2:
            [EditeQRCodeController startWithNav:self.navigationController type:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            break;
        case 3:
            [EditeQRCodeController startWithNav:self.navigationController type:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
            break;

        default:
            break;
    }
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
    [UserUtil clearUserData];
    [MBProgressHUD showSuccess:@"清理成功" toView:nil];
    [_tipBtn setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)[self getNewCacheTip].count] forState:UIControlStateNormal];
}

- (void)onJDCommonNavBarRightButtonTouch:(UIButton *)sender {
    [JMScanningQRCodeUtils jm_cameraAuthStatusWithSuccess:^{
        [self.navigationController pushViewController:[[JMScanningQRCodeVC alloc] init] animated:true];
    } failure:^{

    }];
}

@end
