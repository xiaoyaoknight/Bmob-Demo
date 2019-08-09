//
//  ViewController.m
//  Bmob-Demo
//
//  Created by 王泽龙 on 2019/8/9.
//  Copyright © 2019 王泽龙. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self add];
    [self get];
//    [self change];
//    [self delete];
    
}

- (void)add {
    //往GameScore表添加一条playerName为小明，分数为78的数据
    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore setObject:@"小明" forKey:@"playerName"];
    [gameScore setObject:@78 forKey:@"score"];
    [gameScore setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
    }];
}

- (void)get {
    //查找GameScore表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"aaa"];
    [bquery whereKey:@"user" equalTo:@"a"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSLog(@"%@", array);
        
        BmobObject *obj = array.lastObject;
        NSLog(@"%@", [obj objectForKey:@"url"]);
        
        
    }];
//    //查找GameScore表里面id为0c6db13c的数据
//    [bquery getObjectInBackgroundWithId:@"9e8ffb8296" block:^(BmobObject *object,NSError *error){
//        if (error){
//            //进行错误处理
//        }else{
//            //表里有id为0c6db13c的数据
//            if (object) {
//                //得到playerName和cheatMode
//                NSString *playerName = [object objectForKey:@"playerName"];
//                BOOL cheatMode = [[object objectForKey:@"cheatMode"] boolValue];
//                NSLog(@"%@----%i",playerName,cheatMode);
//            }
//        }
//    }];
}

- (void)change {
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:@"0c6db13c" block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                [obj1 setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
                //异步更新数据
                [obj1 updateInBackground];
            }
        }else{
            //进行错误处理
        }
    }];
}

- (void)delete {
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    [bquery getObjectInBackgroundWithId:@"0c6db13c" block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackground];
            }
        }
    }];
}
@end
