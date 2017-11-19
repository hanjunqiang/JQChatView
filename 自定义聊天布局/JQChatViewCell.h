//
//  JQChatViewCell.h
//  自定义聊天布局
//
//  Created by 韩军强 on 2017/11/16.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQChatModel.h"

@interface JQChatViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *jq_imgBtn;

@property (weak, nonatomic) IBOutlet UIButton *jq_textBtn;

@property (weak, nonatomic) IBOutlet UILabel *jq_timelbl;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jq_timeTopLayout;

@property (nonatomic, strong) JQChatModel *model;

@end
