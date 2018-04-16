//
//  ViewController1.m
//  wf
//
//  Created by wf on 2017/7/18.
//  Copyright © 2017年 wf. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController1.h"
#define kCount 6//照片张数
static long step=0;//记录时钟动画调用次数
@interface ViewController2 ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_currentView;
    UIImageView *_nextImageView;
    UIImageView *_preiousView;//上一个视图
    CADisplayLink *_timer;
    BOOL _isDraging;//是否拖拽
}
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ViewController2
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer setPaused:YES];
    [_timer invalidate];
    _timer=nil;
    [self.deleget viewcontroller1:self diddisapear:self.textfield.text];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textfield.delegate=self;
    
    CGFloat width=self.view.bounds.size.width;
    CGFloat height=self.view.bounds.size.height;
    _scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.contentSize=CGSizeMake(3*width, 0);
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.bounces=NO;
    _scrollView.contentOffset=CGPointMake(width, 0);
    [self.imageview addSubview:_scrollView];
    _currentView=[[UIImageView alloc]init];
    _currentView.image=[UIImage imageNamed:@"001.jpg"];
    _currentView.frame=CGRectMake(width, 0, width, height);
    _currentView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_currentView];
    
    _nextImageView=[[UIImageView alloc]init];
    _nextImageView.image=[UIImage imageNamed:@"002.jpg"];
    _nextImageView.frame=CGRectMake(width*2, 0, width, height);
    _nextImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_nextImageView];
    
    
    _preiousView=[[UIImageView alloc]init];
    _preiousView.image=[UIImage imageNamed:@"006.jpg"];
    _preiousView.frame=CGRectMake(0, 0, width, height);
    
    _preiousView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_preiousView];
    
    _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(updates:)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//     self.view.backgroundColor=[UIColor blackColor];
 
    
    // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    [self.textfield isFirstResponder];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_timer setPaused:YES];
//    [_timer invalidate];
    [self.textfield isFirstResponder];
}


-(void)updates:(CADisplayLink *)timer{
    step++;
    if ((step%120!=0)||_isDraging) {
        return;
    }
    NSLog(@"------step:%ld",step);
    CGPoint offest=_scrollView.contentOffset;
    NSLog(@"-------offest:%f",offest.x);
    CGFloat width=self.view.bounds.size.width;
      NSLog(@"-------width:%f",width);
    offest.x+=width;
    if (offest.x>2*width) {
        offest.x=width;
    }
    
    [_scrollView setContentOffset:offest animated:YES];
    
    
}
#pragma mark--代理方法
//准备开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDraging=YES;
}
//停止滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDraging=NO;
    step=0;
}
//已经拖动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static int i=1;
    float offset=scrollView.contentOffset.x;
    if (_nextImageView.image==nil||_preiousView.image==nil) {
        NSString *imageName1=[NSString stringWithFormat:@"00%d.jpg",i==kCount?1:i+1];
        _nextImageView.image=[UIImage imageNamed:imageName1];
        NSString *imageName2=[NSString stringWithFormat:@"00%d.jpg",i==1?kCount:i-1];
        _preiousView.image=[UIImage imageNamed:imageName2];
        
        
    }
    if (offset==0) {
        _currentView.image=_preiousView.image;
        scrollView.contentOffset=CGPointMake(scrollView.bounds.size.width, 0);
        _preiousView.image=nil;
        if (i==1) {
            i=kCount;
        }else{
            i-=1;
        }
    }
    if (offset==scrollView.bounds.size.width*2) {
        _currentView.image=_nextImageView.image;
        scrollView.contentOffset=CGPointMake(scrollView.bounds.size.width, 0);
        _nextImageView.image=nil;
        if (i==kCount) {
            i=1;
        }else{
            i+=1;
        }
    }
}

@end

