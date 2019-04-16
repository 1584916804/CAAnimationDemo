//
//  BaseViewController.m
//  CAAnimationDemo
//
//  Created by mini on 2019/3/22.
//  Copyright © 2019年 mini. All rights reserved.
//

#import "BaseViewController.h"
#import "BasicAnimationVC.h"
#import "BubbleAnimationVC.h"
#import "CardAnimationVC.h"

@interface BaseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation BaseViewController

- (UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64 - 50) style:UITableViewStyleGrouped];
        _listTableView.backgroundColor = [UIColor clearColor];
//        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = [[UIView alloc] init];
    }
    return _listTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //20190416002
    
    self.sectionArray = [[NSMutableArray alloc] initWithObjects:@"基本动画", @"泡泡", @"卡牌", nil];
    
    
    [self.view addSubview:self.listTableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.sectionArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.sectionArray[indexPath.row];
    if ([title isEqualToString:@"基本动画"]) {
        BasicAnimationVC *baseVC = [[BasicAnimationVC alloc] init];
        
        [self.navigationController pushViewController:baseVC animated:YES];
    }
    else if ([title isEqualToString:@"泡泡"]){
        BubbleAnimationVC *bubbleVC = [[BubbleAnimationVC alloc] init];
        
        [self.navigationController pushViewController:bubbleVC animated:YES];
    }
    else if ([title isEqualToString:@"卡牌"]){
        CardAnimationVC *cardVC = [[CardAnimationVC alloc] init];
        
        [self.navigationController pushViewController:cardVC animated:YES];
    }
    else if ([title isEqualToString:@""]){
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
    return footer;
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
