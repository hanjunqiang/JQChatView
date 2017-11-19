
//
//  JQChatViewCell.m
//  自定义聊天布局
//
//  Created by 韩军强 on 2017/11/16.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import "JQChatViewCell.h"

@implementation JQChatViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor clearColor]; //设置self时，默认设置了self.contentView
//    self.contentView.backgroundColor = [UIColor clearColor];

    //该句只是限定titleLabel的最大宽度，jq_textBtn的宽要限定范围[60,250].
//    self.jq_textBtn.titleLabel.preferredMaxLayoutWidth = 250;   //该句或许可以省略，最好写上。
    self.jq_textBtn.titleLabel.numberOfLines = 0;

}


-(void)setModel:(JQChatModel *)model
{
    _model = model;

//    self.jq_textBtn.titleLabel.preferredMaxLayoutWidth = 250;   //该句或许可以省略，最好写上。
//    self.jq_textBtn.titleLabel.numberOfLines = 0;

    if (model.isHideTime) {
        self.jq_timelbl.hidden = YES;
        [self.jq_timelbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@0);
        }];
        
        self.jq_timeTopLayout.constant = 0;
    }else{
        self.jq_timelbl.hidden = NO;
        self.jq_timelbl.text = model.time;
        [self.jq_timelbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@21);
        }];
        
        self.jq_timeTopLayout.constant = 10;
    }
    
    [self.jq_textBtn setTitle:model.text forState:UIControlStateNormal];

    /**
     注意：
         ➤1，这里是为了获取jq_textBtn中titleLabel的高度，必须刷新一下jq_textBtn的布局。
         ➤2，titleLabel_height不能使用CGRectGetMaxY(self.jq_textBtn.titleLabel.frame),
             因为self.jq_textBtn.titleLabel本身的x,y都为0.
    */
    [self layoutIfNeeded];
    

    /**
        一定要注意：
             1，xib中的jq_textBtn的type一定要设置成Custom,
                否则，在更新按钮约束的时候，可能会导致cell高度复用。
     
             2，这里的+30，是为了让titleLabel的文字top和bottom显示在气泡中，所以增加了jq_textBtn高度。
     
             在xib中的contentInset设置了left、right，使文字显示在了气泡中。
             为什么不设置top和bottom ？
             首先要明白，jq_textBtn的高度不能等于jq_textBtn中titleLabel的高度，那样肯定显示不在气泡中。
             所以，高度比titleLabel高30，也就不需要设置top和bottom
     
    */

    CGFloat titleLabel_height = self.jq_textBtn.titleLabel.frame.size.height;  //获取按钮中label的高度
    [self.jq_textBtn mas_updateConstraints:^(MASConstraintMaker *make) {
       
        NSLog(@"width---%f",self.jq_textBtn.titleLabel.width);
        NSLog(@"titleLabel_height---%f",titleLabel_height);
        make.height.mas_equalTo(@(titleLabel_height + 30));
        
    }];
    
    [self layoutIfNeeded];  //必须强制布局一下整个cell，不然控件显示有bug.

    //获取内容和头像的最大值，即cell的高度。
    CGFloat textBtnHeight = CGRectGetMaxY(self.jq_textBtn.frame);
    CGFloat imgHeight = CGRectGetMaxY(self.jq_imgBtn.frame);
    CGFloat cellHeight = MAX(textBtnHeight, imgHeight);
    
    model.cellHeight = cellHeight + 10; //cell的高度记录到model中（这里留10的间距）
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
