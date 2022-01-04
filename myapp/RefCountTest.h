//
//  RefCountTest.h
//  myapp
//
//  Created by caiyongjian on 2021/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefCountTest : NSObject

+(void)testAlloc;

+(RefCountTest*)nGet;

@property(null_resettable, assign) NSString* simple;

@end

NS_ASSUME_NONNULL_END
