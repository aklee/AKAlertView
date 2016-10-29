//
//  AKAlertView.h
//  BaseDemo
//
//  Created by ak on 16/10/28.
//  Copyright © 2016年 AK. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,AKAlert){
    AKAlertSuccess,
    AKAlertFaild,
    AKAlertInfo,
    AKAlertCustom //custom head image
};

typedef NS_ENUM(NSInteger,AKAlertEffect){
    AKAlertEffectDrop,
    AKAlertEffectFade
};


@interface AKAlertView : UIView

+(instancetype)alertView:(NSString*)title des:(NSString*)des type:(AKAlert)type effect:(AKAlertEffect)effect sureTitle:(NSString*)sureTitle cancelTitle:(NSString*)cancelTitle;

-(void)show;

//整体色调 default GREENCOLOR
@property(nonatomic,copy)UIColor *tintColor;

@property(nonatomic,assign)AKAlert type;
@property(nonatomic,assign)AKAlertEffect effect;
@property(nonatomic,copy)UIImage*headImg;

//blocks which is not invoked on main thread
@property(nonatomic,copy)void(^cancelClick)(AKAlertView * view);
@property(nonatomic,copy)void(^sureClick)(AKAlertView * view);
@property(nonatomic,copy)void(^bgClick)(AKAlertView * view);


@property(nonatomic,copy)void(^willAppear)(AKAlertView * view);
@property(nonatomic,copy)void(^didAppear)(AKAlertView * view);
@property(nonatomic,copy)void(^willDisappear)(AKAlertView * view);
@property(nonatomic,copy)void(^didDisappear)(AKAlertView * view);
@end
