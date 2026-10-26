#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PasswordLockController : UIViewController
@property (nonatomic, strong) UITextField *passwordTextField;
@end

@implementation PasswordLockController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Tạo nền màu đen mờ phủ toàn màn hình
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.95];
    
    // Tiêu đề Thiên Crack
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, self.view.frame.size.width - 40, 40)];
    titleLabel.text = @"🔒 Thiên Crack";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    // Hướng dẫn nhập mật khẩu
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, self.view.frame.size.width - 40, 30)];
    subLabel.text = @"Vui lòng nhập mật khẩu để tiếp tục";
    subLabel.textColor = [UIColor lightGrayColor];
    subLabel.font = [UIFont systemFontOfSize:14];
    subLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:subLabel];
    
    // Ô nhập mật khẩu
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 230, self.view.frame.size.width - 80, 45)];
    self.passwordTextField.placeholder = @"Nhập mật khẩu...";
    self.passwordTextField.textColor = [UIColor whiteColor];
    self.passwordTextField.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.passwordTextField];
    
    // Nút Xác nhận
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(40, 300, self.view.frame.size.width - 80, 50);
    [loginButton setTitle:@"Xác Nhận" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    loginButton.backgroundColor = [UIColor systemBlueColor];
    loginButton.layer.cornerRadius = 8;
    [loginButton addTarget:self action:@selector(verifyPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
}

- (void)verifyPassword {
    NSString *enteredPassword = self.passwordTextField.text;
    if ([enteredPassword isEqualToString:@"Thien@2006"]) {
        // Đóng màn hình khóa khi đúng mật khẩu
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        // Thông báo sai mật khẩu
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thất bại" message:@"Mật khẩu không chính xác!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Thử lại" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end

// Hàm tự động kích hoạt ngay khi game vừa mở lên
__attribute__((constructor)) static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    for (UIWindow *w in scene.windows) {
                        if (w.isKeyWindow) {
                            window = w;
                            break;
                        }
                    }
                }
            }
        }
        if (!window) {
            window = [UIApplication sharedApplication].keyWindow;
        }
        
        if (window && window.rootViewController) {
            PasswordLockController *lockVC = [[PasswordLockController alloc] init];
            lockVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [window.rootViewController presentViewController:lockVC animated:YES completion:nil];
        }
    });
}
