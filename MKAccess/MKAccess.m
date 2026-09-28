#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__attribute__((constructor))
static void MKAccessInit(void) {
    @autoreleasepool {
        NSLog(@"[MKAccess] runtime bridge loaded");
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        [d setBool:YES forKey:@"MKAccess.RuntimeLoaded"];
        [d synchronize];
    }
}
