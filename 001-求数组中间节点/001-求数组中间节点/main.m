//
//  main.m
//  001-求数组中间节点
//
//  Created by Joker on 2019/5/7.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRTimeTool.h"

/*
 来源：极宇舟天软件工程师笔试题
 
 要求给定一个数组，获取数组的一个分界点的下标，使得该分界点的两侧子数组的和相等。如果存在多个分界点，只返回第一个分界点的下标，如果没有则返回-1。
 要求：时间复杂度不得超过O(n)。
 测试用例：
 输入：[-20, 30, 10, 40, 20]
 返回：3
 */

NSInteger middleIndexWithArray(NSArray<NSNumber *> * array) {
    if (array.count < 3) return -1;
    NSInteger leftSum = 0;
    NSInteger rightSum = 0;
    NSInteger allSum = 0;
    // n
    for (NSNumber *sum in array) allSum += sum.integerValue;
    // max: n - 2
    for (NSInteger i = 1; i < array.count - 1; i++) {
        leftSum += array[i - 1].integerValue;
        rightSum = allSum - leftSum - array[i].integerValue;
        if (leftSum == rightSum) return i;
    }
    
    // 复杂度 2n - 2 => O(n)
    

    
    return -1;
}

NSInteger bad_middleIndexWithArray(NSArray<NSNumber *> * array) {
    for (NSInteger i = 1; i < array.count - 1; i++) {
        NSInteger leftSum = 0;
        NSInteger rightSum = 0;
        for (NSInteger j = 0; j < i; j++) {
            leftSum += array[j].intValue;
        }
        for (NSInteger k = i + 1; k < array.count; k++) {
            rightSum += array[k].intValue;
        }
        if (leftSum == rightSum) {
            return i;
        }
    }
    // (n - 2)(n - 1) => O(n^2)
    return -1;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray<NSNumber *> *array = [NSMutableArray array];
        for (int i = 0; i < 20001; i++) {
            if (i < 10000) {
                array[i] = [NSNumber numberWithInt:i];
            } else if (i == 10000) {
                array[i] = [NSNumber numberWithInt:-1];
            } else {
                array[i] = [NSNumber numberWithInt:20000 - i];
            }
        }
        [JKRTimeTool teskCodeWithBlock:^{
            NSLog(@"%ld", (long)middleIndexWithArray(array));
        }];
        
        [JKRTimeTool teskCodeWithBlock:^{
            NSLog(@"%ld", (long)bad_middleIndexWithArray(array));
        }];
    }
    return 0;
}
