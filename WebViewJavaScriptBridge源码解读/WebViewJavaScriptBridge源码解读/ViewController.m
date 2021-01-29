//
//  ViewController.m
//  WebViewJavaScriptBridge源码解读
//
//  Created by Chiu Young on 2021/1/29.
//

#import "ViewController.h"
#import "WebViewJavascriptBrigeController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    WebViewJavascriptBrigeController * vc = [[WebViewJavascriptBrigeController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
