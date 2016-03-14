//
//  ErWeiMa.h
//  e陪诊
//
//  Created by 窦建斌 on 15/9/21.
//  Copyright (c) 2015年 窦建斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErWeiMa : NSObject


+ (UIImage *)ErWeiMaReturn:(CIImage *)image withSize:(CGFloat) size;
+ (CIImage *)createString:(NSString *)String;
+ (UIImage*)ChangeColor:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
