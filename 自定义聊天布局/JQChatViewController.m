//
//  JQChatViewController.m
//  自定义聊天布局
//
//  Created by 韩军强 on 2017/11/16.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import "JQChatViewController.h"
#import "JQChatViewCell.h"
#import "JQChatModel.h"

@interface JQChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableV;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation JQChatViewController

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static  NSString* const  JQChatViewCellID = @"JQChatViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableV.backgroundColor = [UIColor whiteColor];
    
    
}



-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];

        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"dataArray---%@",dataArray);
        
        JQChatModel *lastModel = nil;
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            
            JQChatModel *model = [JQChatModel new];
            /**
                 注意：
                     1，调用者是model，而不是JQChatModel。
                     2，JQChatModel中的属性名，要和dic中的key一一对应。
            */
            [model setValuesForKeysWithDictionary:dic];
            model.hideTime = [model.time isEqualToString:lastModel.time];
            
            [models addObject:model];
            
            lastModel = model;
        }
        
        [_dataArr addObjectsFromArray:models];
    }
    return _dataArr;
}

- (UITableView *)mainTableV
{
    if (!_mainTableV)
    {
        _mainTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mainTableV.delegate = self;
        _mainTableV.dataSource = self;
        
        _mainTableV.showsVerticalScrollIndicator = NO;
//        _mainTableV.backgroundColor=RGBCOLOR(239, 239, 239);
        _mainTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _mainTableV.estimatedRowHeight = 100;
//        _mainTableV.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:_mainTableV];
    }
    return _mainTableV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JQChatModel *model = self.dataArr[indexPath.row];
    
    NSString * ID = model.type == JQChatModelStyleMe? @"me":@"other";
    
    JQChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"JQChatViewCell" owner:self options:nil][model.type];
    }
    cell.model = model;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JQChatModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
