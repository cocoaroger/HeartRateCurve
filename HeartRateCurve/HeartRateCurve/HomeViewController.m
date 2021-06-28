//
//  HomeViewController.m
//  HeartRateCurve
//
//  Created by IOS－001 on 14-4-23.
//  Copyright (c) 2014年 N/A. All rights reserved.
//

#import "HomeViewController.h"
#import "HeartLive.h"
#import "HeartLive2.h"
#import "HeartLive3.h"
#import "HeartLivePointContainer.h"

@interface HomeViewController ()

@property (nonatomic , strong) NSArray *dataSource;
@property (nonatomic , strong) NSMutableArray *showDataSource;
@property (assign, nonatomic) NSInteger currentIndex;

@property (nonatomic , strong) HeartLive *refreshMoniterView;
@property (nonatomic , strong) HeartLive2 *translationMoniterView;
@property (nonatomic , strong) HeartLive3 *monitorView3;
@property (strong, nonatomic) HeartLivePointContainer *pointContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIScrollView *scrollView2;

@end

@implementation HomeViewController

- (HeartLive *)refreshMoniterView
{
    if (!_refreshMoniterView) {
        CGFloat xOffset = 10;
        _refreshMoniterView = [[HeartLive alloc] initWithFrame:CGRectMake(xOffset, 20, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _refreshMoniterView.backgroundColor = [UIColor blackColor];
    }
    return _refreshMoniterView;
}

- (HeartLive2 *)translationMoniterView
{
    if (!_translationMoniterView) {
        CGFloat xOffset = 10;
        _translationMoniterView = [[HeartLive2 alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _translationMoniterView.backgroundColor = [UIColor blackColor];
    }
    return _translationMoniterView;
}

- (HeartLive3 *)monitorView3 {
    if (!_monitorView3) {
        CGFloat xOffset = 10;
        _monitorView3 = [[HeartLive3 alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _monitorView3.backgroundColor = [UIColor blackColor];
    }
    return _monitorView3;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat xOffset = 10;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(xOffset, CGRectGetMaxY(self.refreshMoniterView.frame) + 10, CGRectGetWidth(self.view.frame) - 2 * xOffset, 200)];
        _scrollView.backgroundColor = [UIColor blackColor];
    }
    return _scrollView;
}

- (UIScrollView *)scrollView2
{
    if (!_scrollView2) {
        _scrollView2 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _scrollView2.backgroundColor = [UIColor blackColor];
    }
    return _scrollView2;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"心电图";
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.refreshMoniterView];
    [self.view addSubview:self.scrollView2];
    
    [self.scrollView addSubview:self.translationMoniterView];
    [self.scrollView2 addSubview:self.monitorView3];
    
    self.pointContainer = [HeartLivePointContainer sharedContainer];
    self.showDataSource = [NSMutableArray new];
    
    _scrollView.hidden = YES;
    _refreshMoniterView.hidden = YES;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    void (^createData)(void) = ^{
        NSString *tempString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        
        NSMutableArray *tempData = [[tempString componentsSeparatedByString:@","] mutableCopy];
        [tempData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSNumber *tempDataa = @(-[obj integerValue] + 2048);
            [tempData replaceObjectAtIndex:idx withObject:tempDataa];
        }];
        self.dataSource = tempData;
        [self createWorkDataSourceWithTimeInterval:0.01];
        self.scrollView.contentSize = CGSizeMake(tempData.count, 200);
        [self.translationMoniterView refreshWithDataSoure:tempData];
        [self.monitorView3 refreshWithDataSoure:tempData];
    };
    createData();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 哟

- (void)createWorkDataSourceWithTimeInterval:(NSTimeInterval )timeInterval
{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerRefresnFun) userInfo:nil repeats:YES];
}

//刷新方式绘制
- (void)timerRefresnFun
{
    if (_currentIndex == _dataSource.count) {
        _currentIndex = 0;
    }
    [self.showDataSource addObject:_dataSource[_currentIndex]];
    _currentIndex ++;
    [self.refreshMoniterView refreshWithDataSoure:_showDataSource];
}
@end
