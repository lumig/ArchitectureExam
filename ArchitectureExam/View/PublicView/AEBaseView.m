//
//  AEBaseView.m
//  ArchitectureExam
//
//  Created by abc on 16/1/6.
//  Copyright © 2016年 longlz. All rights reserved.
//

#import "AEBaseView.h"

@implementation AEBaseView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.deleagate respondsToSelector:@selector(touchBegin)]) {
        [self.deleagate touchBegin];
    }
}


@end
