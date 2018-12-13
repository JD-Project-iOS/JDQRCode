//
//  EditeQRCodeController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/12/5.
//  Copyright © 2018 jd. All rights reserved.
//

#import "EditeQRCodeController.h"
#import "LookOrSaveController.h"
#import "JDCommonNavBar.h"

@interface EditeQRCodeController ()<JDCommonNavBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UITextField *strTxf;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *logoImage;
@end

@implementation EditeQRCodeController

+ (void)startWithNav:(UINavigationController *)nav
                type:(nonnull NSString *)type {
    EditeQRCodeController *vc = [EditeQRCodeController new];
    vc.type = type;
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
                            andTitle:@"制作二维码"];
//    [nav setRightButtonTitle:@"选logo" WithColor:[UIColor blackColor]];
    [self.view addSubview:nav];
}

- (void)initSubViews {
    self.view.backgroundColor = COLOR_BG;
    self.bgView.top = kStatusBarAndNavigationBarHeight;
}

- (IBAction)touchGoBtn:(id)sender {
    [LookOrSaveController startWithNav:self.navigationController str:self.strTxf.text type:self.type logo:self.logoImage];
}

- (IBAction)touchSelectBtn:(id)sender {
    [self handleRightBarButtonAction];
}

#pragma mark - 相册
- (void)handleRightBarButtonAction {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePicker
                                                                                 animated:YES
                                                                               completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        self.logoImage = info[UIImagePickerControllerOriginalImage];
        [self.selectBtn setTitle:@"" forState:UIControlStateNormal];
        [self.selectBtn setImage:self.logoImage forState:UIControlStateNormal];
    }];
}

#pragma mark ----------CustomNavBarDelegate

- (void)onJDCommonNavBarRightButtonTouch:(UIButton *)sender {
    [self handleRightBarButtonAction];
}



@end
