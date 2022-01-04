//
//  RefCountTest.m
//  myapp
//
//  Created by caiyongjian on 2021/11/12.
//

#import "RefCountTest.h"

@implementation RefCountTest

+(void)testAlloc {
    id __strong strongOuter;
    id __weak weakOuter;
//
    @autoreleasepool {
        NSError* error = nil;
        NSError* __strong * pError = &error;
        
        NSMutableArray* array = [NSMutableArray array];
//        id __weak arrayWeak = array;
        NSLog(@"RefCountTest.array: %ld", CFGetRetainCount((__bridge CFTypeRef)array));
//        NSLog(@"RefCountTest.test: %d", _objc_rootRetainCount(array));
        
        RefCountTest* test1 = [RefCountTest nGet];
        strongOuter = test1;
        NSLog(@"RefCountTest.test1: %ld", CFGetRetainCount(( __bridge CFTypeRef)test1));
        
        RefCountTest* test = [[RefCountTest alloc]init];
        weakOuter = test;
        NSLog(@"RefCountTest.test: %ld", CFGetRetainCount((__bridge CFTypeRef)test));
//        [test retainCount];
    }
    
    
    NSArray* array = [NSArray array];
    if ([array class] == [NSArray class]) {
        NSLog(@"success");
    }
}

+(RefCountTest*)nGet {
    return [[RefCountTest alloc]init];
}

-(void)dealloc {
    NSLog(@"RefCountTest.dealloc");
}
@end
