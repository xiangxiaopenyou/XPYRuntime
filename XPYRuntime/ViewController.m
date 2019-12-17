//
//  ViewController.m
//  XPYRuntime
//
//  Created by 项小盆友 on 2019/2/3.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "ViewController.h"
#import "XPYPerson.h"
#import "UIButton+XPYBlockAction.h"
#import "UIButton+XPYImageURL.h"
#import "UIViewController+XPYMethodSwizzling.h"

@interface ViewController ()
@property (nonatomic, weak) NSString *testString1;
@property (nonatomic, weak) NSString *testString2;
@property (nonatomic, weak) NSString *testString3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //动态方法解析（类方法）
    [XPYPerson performSelector:@selector(eat:) withObject:@"food"];
    
    //动态方法解析（实例方法）
    XPYPerson *person = [[XPYPerson alloc] init];
    [person performSelector:@selector(sing:) withObject:@"song"];
    
    //消息接收者重定向
    [self performSelector:@selector(run:) withObject:nil];
    [self performSelector:@selector(work:) withObject:nil];
    
    //消息转发 重定向
    [self performSelector:@selector(jump:) withObject:nil];
    
    //分类添加属性
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 100, 30);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.imageURLString = @"";
    [button removeAssociatedObjects];
    [button addTapAction:^(UIButton * _Nonnull button) {
        NSLog(@"点击了按钮，分类添加属性成功");
    }];
    [self.view addSubview:button];
    
    [self archiveTest];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}


#pragma mark - 消息动态处理
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}
#pragma mark - 消息接收者重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(run:)) {
        //定向到XPYPerson类
        return [XPYPerson class];
    }
    if (aSelector == @selector(work:)) {
        //定向到XPYPerson实例
        return [[XPYPerson alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
#pragma mark - 消息转发 消息重定向
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    XPYPerson *person = [[XPYPerson alloc] init];
    if ([person respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:person];
    } else { //报错
        [self doesNotRecognizeSelector:sel];
    }
}


/// 归档、解档测试
- (void)archiveTest {
    XPYPerson *person = [[XPYPerson alloc] init];
    person.name = @"Apple";
    person.age = 27;
    person.weight = 70;
    
    NSError *error = nil;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person requiringSecureCoding:NO error:&error];
    if (!data || error) {
        NSLog(@"归档失败,error:%@", error);
        return;
    }
    NSLog(@"归档成功");
    NSError *unarchivedError = nil;
    XPYPerson *resultPerson = [NSKeyedUnarchiver unarchivedObjectOfClass:[XPYPerson class] fromData:data error:&unarchivedError];
    if (!resultPerson || unarchivedError) {
        NSLog(@"解档失败，error:%@", unarchivedError);
        return;
    }
    NSLog(@"解档成功，person：%@", resultPerson);
}

@end
