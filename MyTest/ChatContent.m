//
//  ChatContent.m
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/13.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "ChatContent.h"
#import "MessageFrame.h"
#import "Message.h"
#import "MessageCell.h"
@interface ChatContent () 
{
    AVUser *currentUser;
    NSMutableArray  *_allMessagesFrame;
}

@end

@implementation ChatContent
- (IBAction)backsinge:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _client=[[AVIMClient alloc]init];
    _client.delegate=self;
     currentUser = [AVUser currentUser];
   
    

    self.tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabview.allowsSelection = NO;
    self.tabview.delegate=self;
    self.tabview.dataSource=self;
    self.tabview.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    
    _allMessagesFrame = [NSMutableArray array];
    NSString *previousTime = nil;
    for (NSDictionary *dict in array) {
        
        MessageFrame *messageFrame = [[MessageFrame alloc] init];
        Message *message = [[Message alloc] init];
        message.dict = dict;
        
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        
        messageFrame.message = message;
        
        previousTime = message.time;
        
        [_allMessagesFrame addObject:messageFrame];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    _textfiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _textfiled.leftViewMode = UITextFieldViewModeAlways;
    
    _textfiled.delegate = self;

   

}
-(void)changetext{
    [_tabview reloadData];
}
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
   
    NSLog(@"%@",currentUser.username);

    NSString *strtext=textField.text;
    if ([currentUser.username isEqualToString:@"jack456"]) {
        
        
        [self.client openWithClientId:[NSString stringWithFormat:@"%@",currentUser.username] callback:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"%@",error.description);
            }else{
                [self.client createConversationWithName:@"test" clientIds:@[@"james456"] callback:^(AVIMConversation *conversation, NSError *error) {
                    [conversation sendMessage:[AVIMTextMessage messageWithText:strtext attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"success send JAMES");
                        }
                    }];
                    
                }];
            }
        }];
    }else{
        
        
        [self.client openWithClientId:[NSString stringWithFormat:@"%@",currentUser.username] callback:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSLog(@"%@",error.description);
            }else{
                [self.client createConversationWithName:@"test" clientIds:@[@"jack456"] callback:^(AVIMConversation *conversation, NSError *error) {
                    [conversation sendMessage:[AVIMTextMessage messageWithText:strtext attributes:nil] callback:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            NSLog(@"success send JACK");
                        }
                    }];
                }];
            }
        }];
        
        
        
    }
    
    // 1、增加数据源
    //NSString *content = textField.text;
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    NSDate *date = [NSDate date];
//    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
//    NSString *time = [fmt stringFromDate:date];
    [self addMessageWithContent:strtext  user:@"me"];
    // 2、刷新表格
    [_tabview reloadData];
    // 3、滚动至当前行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
//    [self.tabview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    NSLog(@"%d",_allMessagesFrame.count);
    _textfiled.text = nil;
    return YES;
}
#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(NSString *)content user:(NSString *)use{
    
    MessageFrame *mf = [[MessageFrame alloc] init];
    Message *msg = [[Message alloc] init];
    msg.content = content;
    //msg.time = time;
    if ([use isEqualToString:@"me"]) {
        msg.icon = @"icon01.png";
        msg.type = MessageTypeMe;
        mf.message = msg;
    }else{
    
        msg.icon = @"icon02.png";
        msg.type = MessageTypeOther;
        mf.message = msg;

    
    }
    
   
    
    
    [_allMessagesFrame addObject:mf];
}
-(void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message{
    NSLog(@"SHODAO");
    NSString *str=message.text;
    
    [self addMessageWithContent:str user:@"other"];
    [_tabview reloadData];
    
}
#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight];
}

#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sender:(id)sender {
}
@end
