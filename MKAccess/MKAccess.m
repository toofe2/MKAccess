#import <Foundation/Foundation.h>

__attribute__((constructor))
static void MKAccessInit(void) {
    @autoreleasepool {
        NSLog(@"[MKAccess] SAFE runtime bridge loaded");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"MKAccess.SafeRuntimeLoaded"];
        [defaults synchronize];
    }
}
