//
//  UIView+AK.h
//  BaseDemo
//
//  Created by ak on 2016/6/22.
//  Copyright © 2016年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(AK)

@property (assign, nonatomic) CGFloat t_x;
@property (assign, nonatomic) CGFloat t_y;
@property (assign, nonatomic) CGFloat t_width;
@property (assign, nonatomic) CGFloat t_height;
@property (assign, nonatomic) CGSize t_size;
@property (assign,nonatomic)CGPoint t_center;
@property (assign,nonatomic)CGFloat t_centerY;
@property (assign,nonatomic)CGFloat t_centerX;
@property (assign, nonatomic) CGPoint t_origin;

-(void)setCorner:(float)corner;



//动态添加属性
-(NSMutableDictionary*)getRuntimeProperty;

-(void)setRuntimePropertyWithValue:(id)value forKey:(NSString *)key;
@end
