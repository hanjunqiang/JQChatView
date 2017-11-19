//
//  JQChatModel.h
//  自定义聊天布局
//
//  Created by 韩军强 on 2017/11/16.
//  Copyright © 2017年 韩军强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    JQChatModelStyleMe,
    JQChatModelStyleOther
} JQChatModelStyle;

@interface JQChatModel : NSObject

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *imgName;

@property (nonatomic, assign) JQChatModelStyle type;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign, getter=isHideTime) BOOL hideTime;

@end
