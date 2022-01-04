//
//  BGTasks.m
//  myapp
//
//  Created by caiyongjian on 2021/11/9.
//

#import "BGTasks.h"

#import <BackGroundTasks/BGTaskScheduler.h>
#import <BackGroundTasks/BGTask.h>
#import <BackGroundTasks/BGTaskRequest.h>

#import <UIKit/UIApplication.h>

#define BACK_TASK_1 @"com.forcyj.BackgroundTask1"

@interface BGTasks()

@property(atomic) long number;
@property(atomic, strong) NSTimer* timer;

@end

@implementation BGTasks

+(BGTasks*)shared {
    static BGTasks* task;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        task = [[BGTasks alloc]init];
    });
    return task;
}

-(void)initInDidFinished {
    if (@available(iOS 13.0, *)) {
        [[BGTaskScheduler sharedScheduler]registerForTaskWithIdentifier:BACK_TASK_1 usingQueue:nil launchHandler:^(__kindof BGTask * _Nonnull task) {
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 40;

            self.number = 40;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
                self.number++;
                [UIApplication sharedApplication].applicationIconBadgeNumber = self.number;
                if (self.number == 170) {
                    [self.timer invalidate];
                }

                NSLog(@"%@==%ld ",[NSDate date],self.number);
                NSLog(@"%@==%ld ",[NSDate date], [UIApplication sharedApplication].backgroundTimeRemaining);
            }];
            [task setTaskCompletedWithSuccess:YES];
            [self scheduleAppRefresh];
        }];
    }
}

-(void)enterBackground {
    [self scheduleAppRefresh];
}

-(void)scheduleAppRefresh {
    BGProcessingTaskRequest* request = [[BGProcessingTaskRequest alloc]initWithIdentifier:BACK_TASK_1];
    request.earliestBeginDate = [NSDate dateWithTimeIntervalSinceNow:40];
    NSError* error;
    BOOL ret = [[BGTaskScheduler sharedScheduler]submitTaskRequest:request error:&error];
    if (!ret) {
        NSLog(@"%@== submit error %@", [NSDate date], error);
    }
   
}


@end
