//
//  GesView.h
//  UNLock
//
//  Created by mika on 2017/12/22.
//  Copyright © 2017年 mika. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GesCompleteBlock)(NSString *passWord);

@interface GesView : UIView
@property (nonatomic, strong) GesCompleteBlock completeBlock;
@end
