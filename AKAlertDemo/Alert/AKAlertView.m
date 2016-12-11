//
//  AKAlertView.m
//  BaseDemo
//
//  Created by ak on 16/10/28.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "AKAlertView.h"
#import "UIView+AK.h"

#pragma mark - Colors

#define GREENCOLOR  [UIColor colorWithRed:0.443 green:0.765 blue:0.255 alpha:1]
#define REDCOLOR    [UIColor colorWithRed:0.906 green:0.296 blue:0.235 alpha:1]
#define BLUECOLOR  [UIColor colorWithRed:0.203 green:0.596 blue:0.858 alpha:1]


#define KunitTime 0.25


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height



typedef void(^animateBlock)();

@interface AKAlertView()
{

    UIView *contentView;UIView*bgView;
 
    UIImageView *headView;
    
    UILabel *titleLb,*desLb;

    UIButton *sureBtn,*cancelBtn;
    
    //animateBlock Arr
    NSMutableArray * _animateArr;
    
    float kcontentW;
    float headW;
}
@end
@implementation AKAlertView


+(instancetype)alertView:(NSString*)title des:(NSString*)des type:(AKAlert)type effect:(AKAlertEffect)effect sureTitle:(NSString*)sureTitle cancelTitle:(NSString*)cancelTitle{
    
    AKAlertView* view = [[AKAlertView alloc]init];
    view.type=type;
    view.effect=effect;
    view->titleLb.text=title;
    view->desLb.text=des;
    [view->sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    [view->cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    return view;
}

#pragma mark - Life Circle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //default values
        _tintColor=GREENCOLOR;
        
        _animateArr=@[].mutableCopy;
        
        _headImg=[UIImage imageNamed:@"Icon-180"];
        
        kcontentW=(kScreenW*0.8);
        
        headW=80;
        
        self.frame=[[UIScreen mainScreen]bounds];
        
        
         //add blur effect view
        UIView* bgV =nil;
       
        if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
            bgV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
            
        }else{
            UIToolbar *toolBar = [[UIToolbar alloc]init];
            toolBar.barStyle = UIBarStyleBlackOpaque;
            bgV = toolBar;
        }
 
        bgV.frame=self.frame;
        [self addSubview:bgV];
        bgV.userInteractionEnabled=YES;
        UITapGestureRecognizer* tapBg=[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(bgTap)];
        [bgV addGestureRecognizer:tapBg];
        bgView=bgV;
        
        
        UIView *contentV=[UIView new];
        contentV.backgroundColor=[UIColor whiteColor];
        [self addSubview: contentV];
        contentV.layer.cornerRadius=5;
        contentView=contentV;
        
        
        UILabel* tLb = [[UILabel alloc]init];
        tLb.textColor=[UIColor blackColor];
        tLb.font= [UIFont systemFontOfSize:18];
        tLb.numberOfLines=0;
        tLb.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:tLb];
        titleLb = tLb;
        
        UILabel* dLb = [[UILabel alloc]init];
        dLb.textColor=[UIColor blackColor];
        dLb.font= [UIFont systemFontOfSize:15];
        dLb.numberOfLines=0;
        dLb.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:dLb];
        desLb = dLb;
        
        
        UIButton* sureB  = [[UIButton alloc]init];
        sureB.backgroundColor=_tintColor;
        [sureB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureB setTitle:@"sure" forState:UIControlStateNormal];
        sureB.titleLabel.font=[UIFont systemFontOfSize:13];
        sureB.tag=0;
        [sureB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureB setCorner:5];
        [contentView addSubview:sureB];
        sureBtn=sureB;
        
        
        UIButton* cancelB  = [[UIButton alloc]init];
        cancelB.backgroundColor=[UIColor lightGrayColor];
        [cancelB setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelB setTitle:@"cancel" forState:UIControlStateNormal];
        cancelB.titleLabel.font=[UIFont systemFontOfSize:13];
        cancelB.tag=1;
        [cancelB addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelB setCorner:5];
        [contentView addSubview:cancelB];
        cancelBtn=cancelB;
        
        
        UIImageView* headV =[UIImageView new];
        [contentView addSubview:headV];
        headView=headV;
        
        //add shadow
        contentView.layer.shadowColor=[UIColor blackColor].CGColor;
        contentView.layer.shadowOffset=CGSizeZero;
        contentView.layer.shadowRadius=20.f;
        contentView.layer.shadowOpacity=0.4f;
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"layout subviews");
    
    [self setupColorAndImg];
    
    
    float btnW=90,btnH=35,statusBarH=20;
    
    float titleMarginT=headW/2+5,desMarginT=10,btnMarginT=15,btnMarginB=10;
    
    float spaceBtn=20;//space between surebtn and cancelbtn
    
    float titleH=[self getLbSize:titleLb].height;
    
    float desH=[self getLbSize:desLb].height;
    
    
    float contentH = titleMarginT+titleH+desMarginT+desH+btnMarginT+btnH+btnMarginB,contentW=kcontentW;
    
    while((contentH+headW+statusBarH*2)>kScreenH) {
        //adjust the height
        if(titleH>desH)titleH-=10;
        else desH-=10;
 
        contentH = titleMarginT+titleH+desMarginT+desH+btnMarginT+btnH+btnMarginB,contentW=kcontentW;
        
    }
    contentView.t_size=CGSizeMake(contentW, contentH);
    contentView.t_center=self.center;
    
    
    
    [headView setCorner:headW/2];
    headView.frame=CGRectMake((contentW-headW)/2, -headW/2, headW, headW);
    
    
    
    titleLb.frame=CGRectMake(0, titleMarginT, contentW, titleH);
    desLb.frame=CGRectMake(0, CGRectGetMaxY(titleLb.frame)+desMarginT, contentW, desH);
    
    
    
    
    
    float btnY=CGRectGetMaxY(desLb.frame)+btnMarginT ;
    
    if (self.type==AKAlertSuccess||self.type==AKAlertInfo) {
        //show one btn
        sureBtn.frame=CGRectMake((contentW-btnW*2)/2, btnY, btnW*2, btnH);
        cancelBtn.frame=CGRectZero;
    }
    
//    if (self.type==AKAlertFaild||self.type==AKAlertCustom) {
    else{
        //show two btn
        sureBtn.frame=CGRectMake(contentW/2-btnW-spaceBtn/2, btnY, btnW, btnH);
        cancelBtn.frame=CGRectMake(contentW/2+spaceBtn/2, btnY, btnW, btnH);
    }
    
    
    
    
    
    
}

-(CGSize)getLbSize:(UILabel*)lb{
    return [lb.text boundingRectWithSize:CGSizeMake(kcontentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lb.font} context:nil].size;
}



#pragma mark - Property
-(void)setHeadImg:(UIImage *)headImg{
    _headImg=headImg;
    headView.image=headImg;
    
}

-(void)setTintColor:(UIColor *)tintColor{
    
    sureBtn.backgroundColor=tintColor;
    
}
#pragma mark - Animations

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (self.willAppear) {
        self.willAppear(self);
    }
    
    if (self.effect==AKAlertEffectDrop) {
        
        //step1
        animateBlock drop = ^(){
            
            contentView.center=CGPointMake(kScreenW/2, -kScreenH);
            
            headView.alpha=0;
            
            [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                contentView.center=CGPointMake(kScreenW/2, kScreenH/2);
                
                
            } completion:^(BOOL finished) {
                [self removeAni];
            }];
        };
        
        [_animateArr addObject:drop];
        
        
        //step2
        animateBlock smaller = ^(){
            
            [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                
                headView.alpha=1;
                
                headView.transform=CGAffineTransformMakeScale(0.4, 0.4);
                
            } completion:^(BOOL finished) {
                
               [self removeAni];
            }];
        };
        
        [_animateArr addObject:smaller];
        
        
        //step3
        animateBlock bigger = ^(){
            
            [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                headView.transform=CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                 [self removeAni];
                
                if (self.didAppear) {
                    self.didAppear(self);
                }
            }];
        };
        
        [_animateArr addObject:bigger];
        
        
    }
    if (self.effect==AKAlertEffectFade) {
       
       
        animateBlock fadeBG = ^(){
            bgView.alpha=0.5;
            contentView.alpha=0;
            [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                bgView.alpha=1;
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
            }];
        };
        
        [_animateArr addObject:fadeBG];

        animateBlock fade = ^(){
            
            [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                contentView.alpha=1;
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
                
                if (self.didAppear) {
                    self.didAppear(self);
                }
            }];
        };
        
        [_animateArr addObject:fade];

        
    }
    
    [self nextAnimate];
    
    
}

-(void)nextAnimate{
    
    if (_animateArr.count==0) {
        return;
    }
    animateBlock ani= [_animateArr firstObject];
    ani();
    
    
}

-(void)removeAni{
    [_animateArr removeObjectAtIndex:0];
    
    [self nextAnimate];
}


#pragma mark  - user Interaction 

-(void)dismiss{
    
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if (self.willDisappear) {
            self.willDisappear(self);
        }
        [UIView animateWithDuration:KunitTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha=0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.didDisappear) {
                self.didDisappear(self);
            }
        }];
        
    
    });
    
    
}

-(void)btnClick:(UIButton*)btn{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        switch (btn.tag) {
            case 0://sure
                if (self.sureClick) {
                    self.sureClick(self);
                }
                
                
                break;
            case 1://cancel
                
                if (self.cancelClick) {
                    self.cancelClick(self);
                }
                break;
                
                
            default:
                break;
        }

    });
    
    
    [self dismiss];
   

}


-(void)bgTap{
    
    if (self.bgClick) {
        self.bgClick(self);
    }
    

    [self dismiss];
}



-(void)setupColorAndImg{
    
    UIImage* img =nil;
    
    switch (self.type) {
        case AKAlertSuccess:
            img=[self imageWithBgColor:GREENCOLOR logo:[UIImage imageNamed:@"checkMark"]];
            self.tintColor=GREENCOLOR;
            break;
            
        case AKAlertInfo:
            img=[self imageWithBgColor:BLUECOLOR logo:[UIImage imageNamed:@"infoMark"]];
            self.tintColor=BLUECOLOR;
            break;
            
        case AKAlertFaild:
            img=[self imageWithBgColor:REDCOLOR logo:[UIImage imageNamed:@"crossMark"]];
            self.tintColor=REDCOLOR;
            
            break;
        case AKAlertCustom:
            img =self.headImg;
            break;
            
        default:
            break;
    }
    
    headView.image=img;
}

-(UIImage*)imageWithBgColor:(UIColor*)color logo:(UIImage*)logoImg{
    if (!color||!logoImg) {
        return  nil;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(headW, headW), NO, 1);
    
    CGContextRef ctx=  UIGraphicsGetCurrentContext();
    
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, headW/2, headW/2, headW/2, 0, M_PI*2, YES);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
    float logoW=headW*0.3,logoY=(headW-logoW)/2;
    
    [logoImg drawInRect:CGRectMake(logoY, logoY,logoW,logoW)];
    
    UIImage * img =   UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  img ;
}

@end
