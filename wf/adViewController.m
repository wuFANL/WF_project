//
//  adViewController.m
//  wf
//
//  Created by wf on 2018/4/16.
//  Copyright © 2018年 wf. All rights reserved.
//

#import "adViewController.h"
#import "ViewController1.h"
@interface adViewController ()

@end

@implementation adViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sy:(id)sender {
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //消除黑屏的写法
    
    
    ViewController1 *vc=[story instantiateViewControllerWithIdentifier:@"v11"];

//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
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
