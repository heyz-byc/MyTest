//
//  PersonView.m
//  TestDemo
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "PersonView.h"
#import "ChatContent.h"
@interface PersonView ()

@end

@implementation PersonView

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn2 setFrame:CGRectMake(200, 100, 100, 100)];
    [btn2 setTitle:@"单聊" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(singechat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view addSubview:btn2];
}
-(void)singechat{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changetext" object:nil];
    ChatContent *chat=[[ChatContent alloc]init];
    [self presentModalViewController:chat animated:YES];

}
-(void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message{
    NSString *str=message.text;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"消息" message: str delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

-(void)loginout{

    [AVUser logOut];
    AVUser *currentuser = [AVUser currentUser];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
