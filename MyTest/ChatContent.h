//
//  ChatContent.h
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/13.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloudIM.h>
@interface ChatContent : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,AVIMClientDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tabview;
- (IBAction)sender:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (nonatomic, strong) AVIMClient *client;
@end
