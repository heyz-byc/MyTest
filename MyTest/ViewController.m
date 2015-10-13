//
//  ViewController.m
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/10.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "ActivityView.h"
#import "ChatView.h"
#import "ScheduleView.h"
#import "MessageVIew.h"
#import "PersonView.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passname;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *get=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changetext)];
    [self.view addGestureRecognizer:get];
    
}
-(void)changetext{
    [_rename resignFirstResponder];
    [_reemail resignFirstResponder];
    [_reword resignFirstResponder];
    [_lopassword resignFirstResponder];
    [_loname resignFirstResponder];

}
- (IBAction)login:(id)sender {
    [AVUser logInWithUsernameInBackground:_loname.text password:_lopassword.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            [self showAlert:@"登录成功"];
            ActivityView *av = [[ActivityView alloc]init];
            av.tabBarItem.title=@"活动";
            ChatView *cv = [[ChatView alloc]init];
            cv.tabBarItem.title=@"聊天";
            cv.tabBarItem.badgeValue=@"3";
            ScheduleView *sv = [[ScheduleView alloc]init];
            sv.tabBarItem.title=@"日程";
            MessageVIew *mv = [[MessageVIew alloc]init];
            mv.tabBarItem.title=@"d";
            mv.tabBarItem.badgeValue=@"3";
            PersonView *pv = [[PersonView alloc]init];
            pv.tabBarItem.title=@"个人";
            UITabBarController *tab = [[UITabBarController alloc]init];
            tab.viewControllers=@[av,cv,sv,mv,pv];
            self.view.window.rootViewController=tab;

        }else{
            
            [self showAlert:@"登录failed"];
        }
    }];


}
- (IBAction)otherlogin:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"其他方式" delegate:self cancelButtonTitle:@"ok" destructiveButtonTitle:nil otherButtonTitles:@"腾讯QQ",@"新浪微博",@"微信", nil];
    [sheet showInView:self.view];
}
- (IBAction)quelogin:(id)sender {
    AVUser *user = [AVUser user];
    user.username = _rename.text;
    user.password = _reword.text;
    user.email = _reemail.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            
            [self showAlert:@"注册成功"];
            
        }else{
            
            [self showAlert:@"注册failed"];
            NSLog(@"%@",error.description);
            
            
        }
    }];
     }
- (void)showAlert:(NSString *)msg{
         
         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
         [alert show];
         
         
     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
