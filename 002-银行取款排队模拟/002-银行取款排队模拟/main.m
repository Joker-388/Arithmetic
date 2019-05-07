//
//  main.m
//  002-银行取款排队模拟
//
//  Created by Joker on 2019/5/7.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 来源：极宇舟天软件工程师笔试题
 
 某银行有4个柜台，假设某天有若干为客户来办理业务，每个客户到达银行的时间和取款需要的时间分布分别用两个数组arrive_time（已经按到达时间排序）和process_time来描述。
 请写程序计算所有客户的平均等待时间，假设每个客户取取款之前先拿到号排对，然后在任意一个柜台有空闲的时候，号码数最小的客户上去办理，假设所有的客户拿到号码之后不会失去耐心走掉。
 
 测试用例：
 
 NSArray<NSNumber *> *arrive_time = @[@1.0, @2.0, @3.0, @4.0, @4.0, @8.0];
 NSArray<NSNumber *> *process_time = @[@50.0, @20.0, @11.0, @25.0, @30.0, @40.0];
 
 测试输出：
 26.0 / 6 = 4.0
 */

void checkTime(NSArray<NSNumber *> *arrive_time, NSArray<NSNumber *> *process_time) {
    // 被占用的柜台数组
    NSMutableArray<NSNumber *> *servers = [NSMutableArray array];
    // 客户需要等待的总时间
    CGFloat allWaitTime = 0;
    
    // 遍历每一个顾客，计算需要等待的总时间
    for (int i = 0; i < arrive_time.count; i++) {
        // 保存剩余时间最小的柜台的时间
        CGFloat minLast = MAXFLOAT;
        // 保存剩余时间最小的柜台的index
        NSInteger minIndex = 0;
        // 当存在服务中柜台是，需要对柜台剩余时间进行刷新
        if (servers.count > 0) {
            // 保存已经服务完成的柜台，用于后面将他们从servers中移除
            NSMutableArray *removeArray = [NSMutableArray array];
            // 遍历所有服务中的柜台，即servers中的每一个元素
            for (int j = 0; j < servers.count; j++) {
                // 上一个顾客到达的时间
                NSInteger preArriveTime = i > 0 ? arrive_time[i - 1].floatValue : 0;
                // 当前顾客到达的时间就是他距离上一个顾客到达时间的差值
                // 这个差值就是时间线的标准
                CGFloat pastTime = arrive_time[i].floatValue - preArriveTime;
                // 当前柜台剩余的时间就是上一个顾客来的时候，剩余的服务时间减去当前顾客距离上一个到达时间的差值
                CGFloat lastTime = servers[j].floatValue - pastTime;
                // 更新当前柜台的剩余等待时间
                servers[j] = [NSNumber numberWithFloat:lastTime];
                // 计算剩余等待时间最小的柜台
                if (lastTime < minLast) {
                    minLast = lastTime;
                    minIndex = j;
                }
                // 如果剩余时间小于0，它在之后会被从servers中移除
                if (lastTime < 0) [removeArray addObject:servers[j]];
            }
            // 将已经空闲的柜台从servers中移除
            [servers removeObjectsInArray:removeArray];
        }
        // 当前存在空闲的柜台，顾客直接进行取款
        if (servers.count < 4) {
            // 这个柜台被占用，并且需要这个顾客需要的取款时间后才会空闲
            [servers addObject:process_time[i]];
            //            NSLog(@"第 %d 个 顾客不需要等待直接服务", i + 1);
        } else { // 没有空闲的柜台，计算需要等待多久
            //            NSLog(@"第 %d 个 顾客需要等待 %f s", i + 1, servers[minIndex].floatValue);
            allWaitTime += servers[minIndex].floatValue;
            servers[minIndex] = [NSNumber numberWithFloat:(servers[minIndex].floatValue + process_time[i].floatValue)];
        }
    }
    CGFloat res = allWaitTime / arrive_time.count;
    NSLog(@"\n总等待时间 %.1f \n顾客数%zd \n平均等待时间: %.1f\n", allWaitTime, arrive_time.count, res);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray<NSNumber *> *arrive_time = @[@1.0, @2.0, @3.0, @4.0, @4.0, @8.0];
        NSArray<NSNumber *> *process_time = @[@50.0, @20.0, @11.0, @25.0, @30.0, @40.0];
        checkTime(arrive_time, process_time);
    }
    return 0;
}
