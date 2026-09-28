#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static void MKShowLoadedBanner(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (scene.activationState != UISceneActivationStateForegroundActive ||
                ![scene isKindOfClass:UIWindowScene.class]) continue;
            for (UIWindow *candidate in ((UIWindowScene *)scene).windows) {
                if (candidate.isKeyWindow) { window = candidate; break; }
            }
            if (window) break;
        }
        if (!window) return;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = @"MKAccess Loaded ✓";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.whiteColor;
        label.backgroundColor = [UIColor colorWithWhite:0.05 alpha:0.92];
        label.font = [UIFont boldSystemFontOfSize:15.0];
        label.layer.cornerRadius = 12.0;
        label.layer.masksToBounds = YES;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [window addSubview:label];

        [NSLayoutConstraint activateConstraints:@[
            [label.centerXAnchor constraintEqualToAnchor:window.centerXAnchor],
            [label.topAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.topAnchor constant:12.0],
            [label.widthAnchor constraintGreaterThanOrEqualToConstant:190.0],
            [label.heightAnchor constraintEqualToConstant:42.0]
        ]];

        label.alpha = 0.0;
        [UIView animateWithDuration:0.25 animations:^{ label.alpha = 1.0; }
                         completion:^(__unused BOOL finished) {
            [UIView animateWithDuration:0.25 delay:2.5 options:0 animations:^{
                label.alpha = 0.0;
            } completion:^(__unused BOOL done) {
                [label removeFromSuperview];
            }];
        }];
    });
}

__attribute__((constructor))
static void MKAccessInit(void) {
    @autoreleasepool {
        NSLog(@"[MKAccess] runtime bridge loaded");
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        [d setBool:YES forKey:@"MKAccess.RuntimeLoaded"];
        [d synchronize];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
            MKShowLoadedBanner();
        });
    }
}
