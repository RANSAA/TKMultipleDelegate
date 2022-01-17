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


@interface ViewController ()<Protocol_1>
@property(nonatomic, strong) TKMultipleDelegate *delegates;//多代理对象
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

    self.d2 = [DelegateObj2 new];
    self.d3 = [DelegateObj3 new];
    [self.delegates addDelegate:self.d2];
    [self.delegates addDelegate:self.d3];
    [self.delegates addDelegate:self];
    [self.delegates addDelegate:@{}];
}

- (void)btnActionCall
{
    [self.delegates performSelector:@selector(call)];
    [self.delegates performSelector:@selector(call:index:) withObject:@"titlw" withObject:@(22)];
    [self.delegates performSelector:@selector(didReceiveMemoryWarning1)];
}

- (void)btnActionMore
{
    [self.delegates performSelector:@selector(more)];
}

- (void)btnActionRemove
{
    [self.delegates removeAllDelegates];
}

- (void)btnActionReset
{
    self.d2 = [DelegateObj2 new];
    self.d3 = [DelegateObj3 new];
    [self.delegates addDelegate:self.d2];
    [self.delegates addDelegate:self.d3];
    [self.delegates addDelegate:self];
}


- (void)btnActionCount
{
//    self.d2 = nil;
//    self.d3 = nil;
    NSLog(@"delegate count:%ld",self.delegates.count);
    NSLog(@"delegate allObjects:%@",self.delegates.allObjects);
}

- (TKMultipleDelegate*)delegates
{
    if (!_delegates) {
        _delegates = [TKMultipleDelegate new];
    }
    return _delegates;
}

#pragma mark Protocol_1
- (void)call
{
    NSLog(@"VC-Protocol_1 call");
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
