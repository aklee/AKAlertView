# AKAlertView
Alert View


<br /><br />

####.效果图片<br />
![image](./AKAlertDemo.gif)<br /><br />

<br />
####特性：<br />
>1.适配屏幕宽高度，自动计算高度内容<br />
>2.使用系统高斯模糊特效

<br />
####用法：<br />



```objective-c

#import "AKAlertView.h"


AKAlertView* alertView= [AKAlertView alertView:@"title" des:@"description"  type:AKAlertSuccess effect:AKAlertEffectDrop sureTitle:sureTitle cancelTitle:cancelTitle];
            
[alertView show];
```


```
typedef NS_ENUM(NSInteger,AKAlert){
    AKAlertSuccess,   //success style
    AKAlertFaild,     //faild style
    AKAlertInfo,      //info style
    AKAlertCustom //custom head image
};



typedef NS_ENUM(NSInteger,AKAlertEffect){
    AKAlertEffectDrop, //alertView droping on the screen
    AKAlertEffectFade  //alertView Fading on the screen
};

```
