//
//  AppDelegate.m
//  myapp
//
//  Created by caiyongjian on 2021/10/27.
//

#import "AppDelegate.h"
#import "BGTasks.h"
#import "RefCountTest.h"

@interface AppDelegate ()

@property(atomic) UIBackgroundTaskIdentifier backgroundTaskId;
@property(atomic) long number;
@property(atomic, strong) NSTimer* timer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIUserNotificationSettings* settings  = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    

    [[BGTasks shared]initInDidFinished];
    
    [RefCountTest testAlloc];
    
    // Override point for customization after application launch.
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    _backgroundTaskId  = [application beginBackgroundTaskWithExpirationHandler:^{
        [self endBack];
    }];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
    self.number = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.number++;
        [UIApplication sharedApplication].applicationIconBadgeNumber = self.number;
        if (self.number == 9) {
            [self.timer invalidate];
        }
        
        NSLog(@"%@==%ld ",[NSDate date],self.number);
    }];
}

-(void)endBack {
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskId];
    _backgroundTaskId = UIBackgroundTaskInvalid;
}








#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
