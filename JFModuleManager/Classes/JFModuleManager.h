//
//  JFModuleManager.h
//  Pods
//
//  Created by junfeng.li on 2017/6/12.
//
//

#import <Foundation/Foundation.h>

@interface JFModuleManager : NSObject <UIApplicationDelegate>

+ (instancetype)sharedManager;

- (void)registerModulesWithClassNameArray:(NSArray *)moduleClassNameArray;

@end
