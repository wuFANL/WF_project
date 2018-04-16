//
//  ViewController.m
//  wf
//
//  Created by wf on 2017/7/18.
//  Copyright © 2017年 wf. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "adViewController.h"
@interface ViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property UIPageControl *pageControl;
@property dispatch_source_t timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor blackColor];
    // Do any additional setup after loading the view.
//    [self.navigationController.navigationBar isHidden];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
  
    
    
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    scrollView.delegate=self;
    scrollView.frame=self.view.bounds;
    [self.view addSubview:scrollView];
    scrollView.bounces=NO;
    scrollView.pagingEnabled=YES;
    scrollView.showsHorizontalScrollIndicator=NO; scrollView.contentSize=CGSizeMake(4*scrollView.frame.size.width, 0);
    for (NSInteger i=0; i<4; i++) {
        UIImageView *image=[[UIImageView alloc]init];
        NSString *imageName=[NSString stringWithFormat:@"welcome%ld.PNG",i+1];
        NSLog(@"%@",imageName);
        image.image=[UIImage imageNamed:imageName];
        image.frame=CGRectMake(i*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:image];
        
    }
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    self.pageControl=pageControl;
    pageControl.frame=CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 40);
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.numberOfPages=4;
    pageControl.userInteractionEnabled=NO;
    [self.view addSubview:pageControl];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offest=scrollView.contentOffset;
    double i=offest.x/scrollView.frame.size.width;
    self.pageControl.currentPage=round(i);
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     double i=scrollView.contentOffset.x/scrollView.frame.size.width;
    
    
    
    if (round(i)>=3) {
        [scrollView removeFromSuperview];
        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"welcome4.PNG"]];
        image.frame=self.view.bounds;
       
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-70,50, 50, 30)];
        [btn setTitle:@"跳过" forState:UIControlStateNormal];
        [btn setAdjustsImageWhenDisabled:YES];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn addTarget:self action:@selector(push2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:image];
        
        [self.view addSubview:btn];
        
        UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(push3)];
//        gesture.numberOfTapsRequired=1;
//        gesture.delegate=self;
//        [gesture setEnabled:YES];
//        [gesture delaysTouchesBegan];
//        [gesture cancelsTouchesInView];
         [self.view addGestureRecognizer:gesture];
        
        
        
        

        __block int timeout=5;
        dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        //timer一定要是成员变量 否则就会被立即释放
         _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            
            
            
            if (timeout<=0) {
                NSLog(@"跳转到首页");
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSelector:@selector(push) withObject:nil afterDelay:0.f];
                });
                
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
                });
                timeout--;
                
                
                
                
                NSLog(@"_________%d",timeout);
            }
            
            
        });
        dispatch_resume(_timer);
 
    }
    
    
}
-(void)push3{
    
    dispatch_source_cancel(_timer);
    
    UIStoryboard *story=self.storyboard;
    
    adViewController *advc=[[adViewController alloc]init];
//    [self presentViewController:advc animated:YES completion:nil];
    
//    [self.navigationController addChildViewController:advc];
    
    
    [self.navigationController pushViewController:advc animated:YES];
  
    
    
    
   
    
    NSLog(@"33333");
    
}
-(void)push2{
    NSLog(@"22222");
     dispatch_source_cancel(_timer);
    
    UIStoryboard *story=self.storyboard;
    ViewController1 *v1=[story instantiateViewControllerWithIdentifier:@"v11"];
    [self.navigationController pushViewController:v1 animated:YES];
    
    
    
}
-(void)push{
   
 
    
    UIStoryboard *story=self.storyboard;
    ViewController1 *v1=[story instantiateViewControllerWithIdentifier:@"v11"];
    [self.navigationController pushViewController:v1 animated:YES];
    
    

}
- (IBAction)goto:(id)sender {
    UIStoryboard *storyd=self.storyboard;
    ViewController1 *v1=[storyd instantiateViewControllerWithIdentifier:@"v11"];
    [self.navigationController pushViewController:v1 animated:YES];
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
