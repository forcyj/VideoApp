//
//  BGTasks.h
//  myapp
//
//  Created by caiyongjian on 2021/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGTasks : NSObject

+(BGTasks*)shared;

-(void)initInDidFinished;

-(void)enterBackground;

@end

NS_ASSUME_NONNULL_END
