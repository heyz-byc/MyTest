//
//  ActivityView.m
//  TestDemo
//
//  Created by Heyz赫兹 on 15/10/12.
//  Copyright © 2015年 Heyz赫兹. All rights reserved.
//

#import "ActivityView.h"
#import "mycell.h"
#import "DetailActivityView.h"
#define screenHeight [[UIScreen mainScreen]bounds].size.height //屏幕高度
#define screenWidth [[UIScreen mainScreen]bounds].size.width   //屏幕宽度
#define colletionCell 2
@interface ActivityView ()
{
    NSMutableArray *hrr;
    UIScrollView *sc;
    UISegmentedControl *seg;
}
@end

@implementation ActivityView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //scrollview 下面
   sc=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, screenWidth, screenHeight-60)];
    sc.delegate=self;
    sc.showsHorizontalScrollIndicator=NO;
    sc.showsVerticalScrollIndicator=NO;
    sc.pagingEnabled=YES;
    sc.contentSize=CGSizeMake(screenWidth*3, screenHeight-60);
    [self.view addSubview:sc];
    
    hrr=[[NSMutableArray alloc]init];
    //self.view.backgroundColor=[UIColor greenColor];
    UICollectionViewFlowLayout *flowout=[[UICollectionViewFlowLayout alloc]init];
    UICollectionView *cv=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-60) collectionViewLayout:flowout];
    cv.backgroundColor=[UIColor whiteColor];
    cv.dataSource=self;
    cv.delegate=self;
    [sc addSubview:cv];
    [cv registerNib:[UINib nibWithNibName:@"mycell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    NSArray *arr=@[@"附近",@"热点",@"其他"];
    seg=[[UISegmentedControl alloc]initWithItems:arr];
    [seg setFrame:CGRectMake(0, 0, screenWidth, 60)];
    seg.selectedSegmentIndex=0;
    [seg addTarget:self action:@selector(ChangePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
}
-(void)ChangePage:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [sc setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            [sc setContentOffset:CGPointMake(screenWidth, 0) animated:YES];
            break;
 
        default:
       
            [sc setContentOffset:CGPointMake(screenWidth*2, 0) animated:YES];
            break;

            
    }



}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height=80+(arc4random()%120);
    //[hrr addObject:[NSString stringWithFormat:@"%f",height]];
    return  CGSizeMake(screenWidth/colletionCell-8, height);  //设置cell宽高
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //static NSString *cellin=@"cell";
    mycell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((20 * indexPath.row) / 255.0) green:((50 * indexPath.row)/255.0) blue:((70 * indexPath.row)/255.0) alpha:1.0f];
    
    cell.imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    DetailActivityView *DView=[[DetailActivityView alloc]init];
    [self presentModalViewController:DView animated:YES];
    [DView setImage:indexPath.row];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (sc==scrollView) {
        int page=sc.contentOffset.x/screenWidth;
        seg.selectedSegmentIndex=page;
    }


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
