//
//  TFCommentDetailController.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFInformation.h"

@interface TFCommentDetailController : UITableViewController
@property (nonatomic ,strong) NSString *copyrightID;
@property (nonatomic ,strong) TFInformation *information;
@end
