//
//  ViewController.m
//  TKMultiDelegateDemo
//
//  Created by PC on 2022/1/17.
//

#import "ViewController.h"
#import "TKMultipleDelegate.h"
#import "MuProtocol.h"
#import "DelegateObj2.h"
#import "DelegateObj3.h"


@interface ViewController ()<Protocol1>
@property(nonatomic, strong) TKMultipleDelegate<Protocol1,Protocol2,Protocol3> *delegates;//Multiple Delegate
@property(nonatomic, strong) DelegateObj2 *d2;
@property(nonatomic, strong) DelegateObj3 *d3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    UIButton *btnCall = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCall.frame = CGRectMake(100, 100, 180, 40);
    btnCall.backgroundColor = UIColor.grayColor;
    [btnCall setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnCall setTitle:@"Action call" forState:UIControlStateNormal];
    [btnCall addTarget:self action:@selector(btnActionCall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCall];

    UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeSystem];
    btnMore.frame = CGRectMake(100, 160, 180, 40);
    btnMore.backgroundColor = UIColor.grayColor;
    [btnMore setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnMore setTitle:@"Action More" forState:UIControlStateNormal];
    [btnMore addTarget:self action:@selector(btnActionMore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMore];

    UIButton *btnRemove = [UIButton buttonWithType:UIButtonTypeSystem];
    btnRemove.frame = CGRectMake(100, 220, 180, 40);
    btnRemove.backgroundColor = UIColor.grayColor;
    [btnRemove setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnRemove setTitle:@"Remove MultiDelegate" forState:UIControlStateNormal];
    [btnRemove addTarget:self action:@selector(btnActionRemove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRemove];

    UIButton *btnReset = [UIButton buttonWithType:UIButtonTypeSystem];
    btnReset.frame = CGRectMake(100, 280, 180, 40);
    btnReset.backgroundColor = UIColor.grayColor;
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnReset setTitle:@"reset MultiDelegate" forState:UIControlStateNormal];
    [btnReset addTarget:self action:@selector(btnActionReset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReset];

    UIButton *btnCount = [UIButton buttonWithType:UIButtonTypeSystem];
    btnCount.frame = CGRectMake(100, 340, 180, 40);
    btnCount.backgroundColor = UIColor.grayColor;
    [btnCount setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnCount setTitle:@"MultiDelegate count" forState:UIControlStateNormal];
    [btnCount addTarget:self action:@selector(btnActionCount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCount];

    UIButton *btnVC = [UIButton buttonWithType:UIButtonTypeSystem];
    btnVC.frame = CGRectMake(100, 400, 180, 40);
    btnVC.backgroundColor = UIColor.grayColor;
    [btnVC setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnVC setTitle:@"New VC" forState:UIControlStateNormal];
    [btnVC addTarget:self action:@selector(btnActionNewVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnVC];

    self.d2 = [DelegateObj2 new];
    self.d3 = [DelegateObj3 new];
    [self.delegates addDelegate:self.d2];
    [self.delegates addDelegate:self.d3];
    [self.delegates addDelegate:self];
    [self.delegates addDelegate:@{}];
    self.delegates.isAbort = NO;
}

- (void)btnActionCall
{
    //可以直接使用performSelector调用方法
    //[self.delegates performSelector:@selector(call)];

    if ([self.delegates respondsToSelector:@selector(call)]) {
        NSString *re = [self.delegates call];
        NSLog(@"re:%@",re);
    }

    if ([self.delegates respondsToSelector:@selector(callRe)]) {
        CGFloat callRe = [self.delegates callRe];
        NSLog(@"callRe:%f",callRe);
    }
}

- (void)btnActionMore
{
    if ([self.delegates respondsToSelector:@selector(more)]) {
        [self.delegates more];
    }
}

- (void)btnActionRemove
{
    [self.delegates removeAllDelegates];
}

- (void)btnActionReset
{
    self.d2 = [DelegateObj2 new];
    self.d3 = [DelegateObj3 new];
    [self.delegates addDelegate:self];
    [self.delegates addDelegate:self.d2];
    [self.delegates addDelegate:self.d3];
}


- (void)btnActionCount
{
//    self.d2 = nil;
//    self.d3 = nil;
    NSLog(@"delegate count:%ld",self.delegates.count);
    NSLog(@"delegate allObjects:%@",self.delegates.allObjects);
}

- (void)btnActionNewVC
{
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = UIColor.systemGray6Color;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"viewController dealloc...");
}


- (TKMultipleDelegate*)delegates
{
    if (!_delegates) {
        _delegates = [[TKMultipleDelegate<Protocol1,Protocol2,Protocol3> alloc] init];
    }
    return _delegates;
}

#pragma mark Protocol_1
- (NSString *)call
{
    NSLog(@"VC-Protocol_1 call");

    return @"VC-Call";
}

- (CGFloat)callRe
{
    return 10.0;
}

- (void)call:(NSString *)title index:(NSNumber *)index
{
    NSLog(@"VC-Protocol_1 call:%@   index:%ld",title,index.integerValue);
}

- (void)more
{
    NSLog(@"VC-Protocol_1 more");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"vc func didReceiveMemoryWarning");
}



@end
