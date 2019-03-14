//
//  ViewController.m
//  EasyImageLoopDemo
//
//  Created by Sen on 2019/3/14.
//  Copyright © 2019年 Sen. All rights reserved.
//

#import "ViewController.h"
#import "EasyImageLoop.h"

@interface ViewController ()

@property (nonatomic, strong) EasyImageLoop* imgLoop;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    _imgLoop = [[EasyImageLoop alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    [self.view addSubview:_imgLoop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _imgLoop.items = @[[UIImage imageNamed:@"img1.jpg"],
                       [UIImage imageNamed:@"img2.jpg"],
                       [UIImage imageNamed:@"img3.jpg"],
                       [UIImage imageNamed:@"img4.jpg"]];

}


@end
