//
//  main.m
//  propertyCases
//
//  Created by wangyang on 2020/9/24.
//  Copyright © 2020 动词大词典. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}

@interface WYObject : NSObject
@property (nonatomic, assign) BOOL isHidden;
@property(nonatomic, strong) NSArray *myArray;
@property(nonatomic, strong) NSArray *otherArray;
@end

@implementation WYObject
- (void)setMyArray:(NSArray *)myArray {
    objc_setAssociatedObject(self, @selector(myArray), myArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)myArray {
    NSArray *myArray = objc_getAssociatedObject(self, @selector(myArray));
    return myArray;
}

- (void)setOtherArray:(NSArray *)otherArray {
    objc_setAssociatedObject(self, @selector(otherArray), otherArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)otherArray {
    NSArray *otherArray = objc_getAssociatedObject(self, @selector(otherArray));
    return otherArray;
}



@end
