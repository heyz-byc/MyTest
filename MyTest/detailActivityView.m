//
//  DetailActivityView.m
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "DetailActivityView.h"
#import "ChatContent.h"

@interface DetailActivityView ()


@end

@implementation DetailActivityView
- (IBAction)group:(id)sender {
    ChatContent *chat=[[ChatContent alloc]init];
 [self presentModalViewController:chat animated:YES];
    NSLog(@"ceshi----1");
}

- (void)viewDidLoad {
    [super viewDidLoad];
       }
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)singlechat:(id)sender {
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setImage:(NSInteger)row{
    NSLog(@"%ld------",row);
    _DetailImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)row]];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)GroupChat:(id)sender {
}
@end
