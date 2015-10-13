//
//  DetailActivityView.h
//  MyTest
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
///Users/heyz1/Desktop/开发/gaode

#import <UIKit/UIKit.h>
#import <AVOSCloudIM.h>
@interface DetailActivityView : UIViewController<AVIMClientDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *DetailImage;

//@property (weak, nonatomic) IBOutlet MKMapView *map;


-(void)setImage:(NSInteger)row;
@end
