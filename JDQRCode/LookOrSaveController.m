//
//  LookOrSaveController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/12/5.
//  Copyright © 2018 jd. All rights reserved.
//

#import "LookOrSaveController.h"
#import "JDCommonNavBar.h"

@interface LookOrSaveController ()<UIPickerViewDelegate, UIPickerViewDataSource, JDCommonNavBarDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *lookQRCoderImage;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSString *str;
@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) NSArray *sizeArr;

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) UIImage *logo;

@end

@implementation LookOrSaveController

+ (void)startWithNav:(UINavigationController *)nav
                 str:(nonnull NSString *)str
                type:(nonnull NSString *)type
                logo:(nonnull UIImage *)logo {
    LookOrSaveController *vc = [LookOrSaveController new];
    vc.str = str;
    vc.type = type;
    vc.logo = logo;
    [nav pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = COLOR_BG;
    [self initCustomNavbar];
    self.lookQRCoderImage.top  = kStatusBarAndNavigationBarHeight + 50;
    self.saveBtn.top = self.lookQRCoderImage.bottom + 60;
    self.size = CGSizeMake(200, 200);
    self.lookQRCoderImage.size = self.size;
    int i = [_type intValue];
    switch (i) {
        case 0:
            self.lookQRCoderImage.image = [JMGenerateQRCodeUtils jm_generateQRCodeWithString:self.str imageSize:self.size];
            break;
        case 1:
            self.lookQRCoderImage.image = [JMGenerateQRCodeUtils jm_generateQRCodeWithString:self.str imageSize:self.size logoImageName:_logo logoImageSize:CGSizeMake(40, 40)];
            break;
        case 2:
            self.lookQRCoderImage.image = [JMGenerateQRCodeUtils jm_generateColorQRCodeWithString:self.str imageSize:self.size rgbColor:[CIColor colorWithRed:200.0/255.0 green:70.0/255.0 blue:189.0/255.0] backgroundColor:[CIColor colorWithRed:0 green:0 blue:0]];
            break;
        case 3:
            self.lookQRCoderImage.image = [JMGenerateQRCodeUtils jm_generateColorQRCodeWithString:self.str imageSize:self.size rgbColor:[CIColor colorWithRed:200.0/255.0 green:70.0/255.0 blue:189.0/255.0] backgroundColor:[CIColor colorWithRed:1 green:1 blue:1] logoImageName:_logo logoImageSize:CGSizeMake(30, 30)];
            break;

        default:
            break;
    }
    // 初始化pickerView
//    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
//    [self.view addSubview:self.picker];
//
//    //指定数据源和委托
//    self.picker.delegate = self;
//    self.picker.dataSource = self;
}

- (void)initCustomNavbar {
    JDCommonNavBar *nav = [[JDCommonNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    nav.delegate = self;
    nav.backgroundColor = [UIColor whiteColor];
    [nav initWithLeftButtonImageName:@"icon_back_black_nav"
             andRightButtonImageName:nil
                            andTitle:@"保存二维码"];
    [self.view addSubview:nav];
}

- (IBAction)touchSaveBtn:(id)sender {
    [self saveQRCard];
}

- (void)saveQRCard {
    UIImageWriteToSavedPhotosAlbum([self screenShot], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    NSMutableArray *arr = [NSMutableArray array];
    if ([[UserUtil findPath] objectForKey:@"list"]&&[[[UserUtil findPath] objectForKey:@"list"] count] > 0) {
        arr = [[[UserUtil findPath] objectForKey:@"list"] mutableCopy];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"Image%lu.png", (unsigned long)arr.count]];
    [UIImagePNGRepresentation([self screenShot]) writeToFile:filePath atomically:YES];
//    NSArray *textArr = [NSArray array];
//    textArr = @[@{@"path":filePath,@"name":@"测试"}];
    [arr addObject:@{@"path":filePath,@"name":@"测试"}];

    
    [UserUtil saveObject:arr key:@"list"];

//    BOOL result =[UIImagePNGRepresentation([self screenShot])writeToFile:filePath  atomically:YES]; // 保存成功会返回YES

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [MBProgressHUD showSuccess:@"成功保存到相册" toView:self.view];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIImage *)screenShot {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, 0.0);
    [self.lookQRCoderImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenShot;
}

#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//指定每个表盘上有几行数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.sizeArr.count;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    title = self.sizeArr[row];
    return title;
}

@end
