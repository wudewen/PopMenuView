//
//  PopMenuView.h
//  PopMenuView
//
//  Created by 吴德文 on 2019/8/8.
//  Copyright © 2019 Shanutec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopMenuView : UIView

+(void)showPopMenuView:(NSArray *)titleArray imgNameArray:(NSArray *)imgNameArray blockTapAction:(void(^) (NSInteger index))blockTapAction;
@end

NS_ASSUME_NONNULL_END
