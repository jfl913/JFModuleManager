//
//  JFModuleManager.m
//  Pods
//
//  Created by junfeng.li on 2017/6/12.
//
//

#import "JFModuleManager.h"

@interface JFModuleManager ()

@property (nonatomic, strong) NSMutableArray<id<UIApplicationDelegate>> *moduleArray;

@end

@implementation JFModuleManager

+ (instancetype)sharedManager {
    static JFModuleManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.moduleArray = @[].mutableCopy;
    });
    return manager;
}

- (void)registerModulesWithClassNameArray:(NSArray *)moduleClassNameArray {
    [self.moduleArray removeAllObjects];
    
    for (NSString *className in moduleClassNameArray) {
        Class class = NSClassFromString(className);
#if DEBUG
        NSAssert(class, @"The %@ class do not exist.", className);
#endif
        if (class) {
            id<UIApplicationDelegate> module = [class new];
            [self.moduleArray addObject:module];
        }
    }
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    for (id<UIApplicationDelegate> module in self.moduleArray) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    return YES;
}

@end
