//
//  ViewController.m
//  BaseDemo
//
//  Created by ak on 2016/6/18.
//  Copyright © 2016年 AK. All rights reserved.
//

#import "AlertVC.h"
#import "AKAlertView.h"

@interface AlertVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITableView *tb;
@property(nonatomic,strong)NSMutableArray* titles;
@property(nonatomic,strong)NSMutableArray* vcs;
@end

@implementation AlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"AlertVC";
    
    
    
    self.titles=@[].mutableCopy;
    
    self.vcs=@[].mutableCopy;
    
    
    [self addCell:@"Success Alert"];
    [self addCell:@"Faild Alert"];
    [self addCell:@"Info Alert"];
    [self addCell:@"Custom Alert"];
    
    
    [self addCell:@"Fade Alert"];
    
    
    [self addCell:@"Full Text Alert"];
    
    
    
}
-(void)addCell:(NSString*)title{
    [self.titles addObject:title];
    
}

#pragma mark TableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell*cell= [tableView dequeueReusableCellWithIdentifier:@"maincell"];
    if (!cell) {
        cell=  [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"maincell"];
        cell.backgroundColor=[UIColor clearColor];
    }
    
    NSString*title =self.titles[indexPath.row];
    
    cell.textLabel.text=title;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.imgView.image=[UIImage imageNamed:@"fullSea"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        
        NSInteger row = indexPath.row;
        NSString* title=@"登陆成功",*msg=@"登陆成功了啦",*sureTitle=@"确定啦" , *cancelTitle=@"取消吧";
        AKAlertView* av;
        if (row==0) {
            av= [AKAlertView alertView:title des:msg  type:AKAlertSuccess effect:AKAlertEffectDrop sureTitle:sureTitle cancelTitle:cancelTitle];
        }
        if (row==1) {
            title=@"登陆失败";msg=@"登陆失败了啦!!";
            av= [AKAlertView alertView:title des:msg  type:AKAlertFaild effect:AKAlertEffectDrop sureTitle:sureTitle cancelTitle:cancelTitle];
        }
        if (row==2) {
            av= [AKAlertView alertView:title des:msg  type:AKAlertInfo effect:AKAlertEffectDrop sureTitle:sureTitle cancelTitle:cancelTitle];
        }
        
        if (row==3) {
            av= [AKAlertView alertView:title des:msg  type:AKAlertCustom effect:AKAlertEffectFade sureTitle:sureTitle cancelTitle:cancelTitle];
            
            av.headImg=[UIImage imageNamed:@"head2.jpeg"];
            
        }
        if (row==4) {
            av= [AKAlertView alertView:title des:msg  type:AKAlertInfo effect:AKAlertEffectFade sureTitle:sureTitle cancelTitle:cancelTitle];
        }
        
        if (row==5) {
            av= [AKAlertView alertView:@"兰亭集序" des:@"兰亭集序又名《兰亭宴集序》、《兰亭序》、《临河序》、《禊序》和《禊贴》。东晋穆帝永和九年（公元353年）三月三日，王羲之与谢安、孙绰等四十一位军政高官，在山阴（今浙江绍兴）兰亭“修禊”，会上各人做诗，王羲之为他们的诗写的序文手稿。《兰亭序》中记叙兰亭周围山水之美和聚会的欢乐之情，抒发作者对于生死无常的感慨。永和九年，时在癸丑之年，三月上旬，我们会集在会稽郡山阴城的兰亭，为了做禊事。众多贤才都汇聚到这里，年龄大的小的都聚集在这里。兰亭这个地方有高峻的山峰，茂盛的树林，高高的竹子。又有清澈湍急的溪流，辉映环绕在亭子的四周，我们引溪水作为流觞的曲水，排列坐在曲水旁边，虽然没有演奏音乐的盛况，但喝点酒，作点诗，也足够来畅快叙述幽深内藏的感情了。 这一天，天气晴朗，空气清新，和风温暖，仰首观览到宇宙的浩大，俯看观察大地上众多的万物，用来舒展眼力，开阔胸怀，足够来极尽视听的欢娱，实在很快乐。     人与人相互交往，很快便度过一生。有的人在室内畅谈自己的胸怀抱负；有的人就着自己所爱好的事物，寄托情怀，放纵无羁地生活。虽然各有各的爱好，安静与躁动各不相同，但当他们对所接触的事物感到高兴时，一时感到自得。感到高兴和满足，竟然不知道衰老将要到来。等到对得到或喜爱的东西已经厌倦，感情随着事物的变化而变化，感慨随之产生。过去所喜欢的东西，转瞬间，已经成为旧迹，尚且不能不因为它引发心中的感触，况且寿命长短，听凭造化，最后归结于消灭。古人说：“死生毕竟是件大事啊。”怎么能不让人悲痛呢？   每当看到前人所发感慨的原因，其缘由像一张符契那样相和，总难免要在读前人文章时叹息哀伤，不能明白于心。本来知道把生死等同的说法是不真实的，把长寿和短命等同起来的说法是妄造的。后人看待今人，也就像今人看待前人，可悲呀。所以一个一个记下当时与会的人，录下他们所作的诗篇。纵使时代变了，事情不同了，但触发人们情怀的原因，他们的思想情趣是一样的。后世的读者，也将对这次集会的诗文有所感慨。"  type:AKAlertCustom effect:AKAlertEffectFade sureTitle:@"确定啦" cancelTitle:@"取消吧"];
            
            av.headImg=[UIImage imageNamed:@"head3.jpeg"];
        }
        
        av.sureClick=^(AKAlertView* av){
            NSLog(@"sure clicked");
            
        };
        av.cancelClick=^(AKAlertView* av){
            NSLog(@"cancel clicked");
        };
        av.bgClick=^(AKAlertView* av){
            NSLog(@"bg clicked");
        };
        
        av.willAppear=^(AKAlertView* av){
            NSLog(@"willAppear");
        };
        av.didAppear=^(AKAlertView* av){
            NSLog(@"didAppear");
        };
        av.willDisappear=^(AKAlertView* av){
            NSLog(@"willDisappear");
        };
        av.didDisappear=^(AKAlertView* av){
            NSLog(@"didDisappear");
            self.imgView.image=nil;
        };
        
        [av show];
    });
}


@end
