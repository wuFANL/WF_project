//
//  TaBarViewController.m
//  wf
//
//  Created by wf on 2018/4/16.
//  Copyright © 2018年 wf. All rights reserved.
//

#import "TaBarViewController.h"
#import "ViewController1.h"
@interface TaBarViewController ()

@end

@implementation TaBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story=self.storyboard;
    ViewController1 *v1=[story instantiateViewControllerWithIdentifier:@"v11"];
    [self.navigationController pushViewController:v1 animated:YES];
    
    
    // Do any additional setup after loading the view.
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
