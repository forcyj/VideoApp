//
//  SceneDelegate.m
//  myapp
//
//  Created by caiyongjian on 2021/10/27.
//

#import "SceneDelegate.h"
#import "BGTasks.h"
#import <GLFW/glfw.h>


@interface SceneDelegate ()

@property(atomic) UIBackgroundTaskIdentifier backgroundTaskId;
@property(atomic) long number;
@property(atomic, strong) NSTimer* timer;

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    
    _backgroundTaskId  = [ [UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBack];
    }];

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    self.number = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.number++;
        [UIApplication sharedApplication].applicationIconBadgeNumber = self.number;
        if (self.number == 170) {
            [self.timer invalidate];
        }

        NSLog(@"%@==%ld ",[NSDate date],self.number);
        NSLog(@"%@==%ld ",[NSDate date], [UIApplication sharedApplication].backgroundTimeRemaining);
    }];
    
    [[BGTasks shared] enterBackground];
    
}




-(void)endBack {
    NSLog(@"%@== endBack",[NSDate date]);
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskId];
    _backgroundTaskId = UIBackgroundTaskInvalid;
}


@end
