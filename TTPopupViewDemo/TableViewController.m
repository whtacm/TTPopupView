//
//  TableViewController.m
//  TTPopView
//
//  Created by Haitao-Wong on 8/10/16.
//  Copyright © 2016 Haitao-Wong. All rights reserved.
//

#import "TableViewController.h"
#import "TTPopupView.h"
@interface TableViewController ()<TTPopupViewDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titles = [[NSArray alloc]initWithObjects:@"拍照",@"从手机相册选择",@"保存图片", nil];
    NSArray *shareIcons = @[@"evernote_128px",@"qq_128px",@"wechat_128px",@"weibo_128px",@"google_picasa_128px",@"youtube_128px",@"chrome_128px",@"cnn_128px",@"angrybirds_128px"];
    NSArray *shareTitles = @[@"印象笔记",@"QQ",@"微信",@"微博",@"Picasa",@"Youtube",@"Chrome",@"CNN",@"AngryBirds"];
    NSArray *funsIcons = @[@"zhihu_72px",@"qq",@"qzone_72px",@"traffic_sign_forbidden_72px",@"alert_72px"];
    NSArray *funsTitles = @[@"复制链接",@"刷新",@"调整字体",@"投诉",@"查看信息"];
    TTPopupView *popup;
    
    if(indexPath.row == 0) {
        popup = [[TTPopupView alloc]initWithPopupTitle:nil funsTitles:titles click:^(NSInteger buttonIndex) {
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Message"
                                                  message:[NSString stringWithFormat:@"You share to %@", titles[buttonIndex]]
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     
                                 }];
            
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }];
        //                [popup setPopupTitle:@"查看"];
        [popup setPopupTitleTextFont:[UIFont systemFontOfSize:15]];
        [popup setPopupTitleTextColor:TTColor(45, 56, 67)];
        [popup setContentTextFont:[UIFont systemFontOfSize:15]];
        [popup setContentTextColor:TTColor(0, 0, 0)];
        [popup setCancelTextColor:TTColor(255, 0, 30)];
    }
    if(indexPath.row == 1) {
        popup = [[TTPopupView alloc]initWithStyle:TTPopupViewNormal popupTitle:nil share2Icons:shareIcons share2Titles:shareTitles funsIcons:funsIcons funsTitles:funsTitles click:^(NSInteger buttonIndex) {
            //NSLog(@"%@-->>%ld",self,(long)buttonIndex);
            
            NSString *msg = nil;
            if(buttonIndex<2000){
                msg = [NSString stringWithFormat:@"You share to %@", shareTitles[buttonIndex-1000]];
            }else{
                msg = [NSString stringWithFormat:@"You share to %@", funsTitles[buttonIndex-2000]];
            }
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Message"
                                                  message:msg
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     
                                 }];
            
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];
        
        [popup setPopupTitleTextFont:[UIFont systemFontOfSize:15]];
        [popup setPopupTitleTextColor:TTColor(45, 56, 67)];
        [popup setContentTextFont:[UIFont systemFontOfSize:12]];
        [popup setContentTextColor:[UIColor grayColor]];
        [popup setCancelTextColor:[UIColor blackColor]];
    }
    
    if(indexPath.row == 2) {
        popup = [[TTPopupView alloc]initWithStyle:TTPopupViewNormalWithCircle popupTitle:@"分享文章" share2Icons:shareIcons share2Titles:shareTitles funsIcons:funsIcons funsTitles:funsTitles click:^(NSInteger buttonIndex) {
            //NSLog(@"%@-->>%ld",self,(long)buttonIndex);
            
            NSString *msg = nil;
            if(buttonIndex<2000){
                msg = [NSString stringWithFormat:@"You share to %@", shareTitles[buttonIndex-1000]];
            }else{
                msg = [NSString stringWithFormat:@"You share to %@", funsTitles[buttonIndex-2000]];
            }
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Message"
                                                  message:msg
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     
                                 }];
            
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];
        
        [popup setPopupTitleTextFont:[UIFont systemFontOfSize:15]];
        [popup setPopupTitleTextColor:TTColor(45, 56, 67)];
        [popup setContentTextFont:[UIFont systemFontOfSize:12]];
        [popup setContentTextColor:[UIColor grayColor]];
        [popup setCancelTextColor:[UIColor blackColor]];
    }
    
    if(indexPath.row == 3) {
        popup = [[TTPopupView alloc]initWithStyle:TTPopupViewWithPageControl popupTitle:@"分享文章" share2Icons:shareIcons share2Titles:shareTitles funsIcons:funsIcons funsTitles:funsTitles click:^(NSInteger buttonIndex) {
            //NSLog(@"%@-->>%ld",self,(long)buttonIndex);
            
            NSString *msg = nil;
            if(buttonIndex<2000){
                msg = [NSString stringWithFormat:@"You share to %@", shareTitles[buttonIndex-1000]];
            }else{
                msg = [NSString stringWithFormat:@"You share to %@", funsTitles[buttonIndex-2000]];
            }
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Message"
                                                  message:msg
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     
                                 }];
            
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];
        
        [popup setPopupTitleTextFont:[UIFont systemFontOfSize:15]];
        [popup setPopupTitleTextColor:TTColor(45, 56, 67)];
        [popup setContentTextFont:[UIFont systemFontOfSize:12]];
        [popup setContentTextColor:[UIColor grayColor]];
        [popup setCancelTextColor:[UIColor blackColor]];
    }
    
    if(indexPath.row == 4) {
        popup = [[TTPopupView alloc]initWithStyle:TTPopupViewWithPageControlWithCircle popupTitle:@"分享文章" share2Icons:shareIcons share2Titles:shareTitles funsIcons:funsIcons funsTitles:funsTitles click:^(NSInteger buttonIndex) {
            //NSLog(@"%@-->>%ld",self,(long)buttonIndex);
            
            NSString *msg = nil;
            if(buttonIndex<2000){
                msg = [NSString stringWithFormat:@"You share to %@", shareTitles[buttonIndex-1000]];
            }else{
                msg = [NSString stringWithFormat:@"You share to %@", funsTitles[buttonIndex-2000]];
            }
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Message"
                                                  message:msg
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action){
                                     
                                 }];
            
            [alertController addAction:ok];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }];
        
        [popup setPopupTitleTextFont:[UIFont systemFontOfSize:15]];
        [popup setPopupTitleTextColor:TTColor(45, 56, 67)];
        [popup setContentTextFont:[UIFont systemFontOfSize:12]];
        [popup setContentTextColor:[UIColor grayColor]];
        [popup setCancelTextColor:[UIColor blackColor]];
        
        [popup setRadius:8];
    }
    
    
    [popup show];
}

#pragma mark - ttpopup

-(void)popupView:(TTPopupView *)popup onClick:(NSInteger)index{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Message"
                                          message:[NSString stringWithFormat:@"You click %ld",(long)index]
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action){
                             
                         }];
    
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
    //    NSLog(@"index: %ld",(long)index);
}


@end
