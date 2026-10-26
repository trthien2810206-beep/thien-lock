#import <UIKit/UIKit.h>

@interface AppPasswordLock : NSObject
+ (void)promptForPassword;
@end

@implementation AppPasswordLock

+ (void)promptForPassword {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = nil;
        for (UIWindow *window in [UIApplication sharedApplication].windows) {
            if (window.isKeyWindow) {
                keyWindow = window;
                break;
            }
        }
        
        UIViewController *rootVC = keyWindow.rootViewController;
        while (rootVC.presentedViewController) {
            rootVC = rootVC.presentedViewController;
        }

        if (!rootVC) return;

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🔒 Thiên Crack"
                                                                        message:@"Vui lòng nhập mật khẩu để mở khóa ứng dụng:"
                                                                 preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Nhập mật khẩu...";
            textField.secureTextEntry = YES;
        }];

        UIAlertAction *submitAction = [UIAlertAction actionWithTitle:@"Xác nhận"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = alert.textFields.firstObject;
            NSString *enteredPassword = textField.text;

            if ([enteredPassword isEqualToString:@"Thien@2006"]) {
                // Đúng mật khẩu -> Vào app bình thường
            } else {
                UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"❌ Thiên Crack"
                                                                                    message:@"Mật khẩu không chính xác. Vui lòng thử lại!"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                
                [errorAlert addAction:[UIAlertAction actionWithTitle:@"Thử lại" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [AppPasswordLock promptForPassword];
                }]];
                
                [rootVC presentViewController:errorAlert animated:YES completion:nil];
            }
        }];

        [alert addAction:submitAction];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

@end

__attribute__((constructor)) static void entry() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AppPasswordLock promptForPassword];
    });
}
