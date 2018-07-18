//
//  XMControl.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/20.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMControl : NSObject

/**
 *  创建UILabel
 */
+(UILabel*)createLabelWithFrame:(CGRect)frame
                           font:(NSInteger)font
                           text:(NSString*)text;

/**
 *  创建UIButton
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                          imageName:(NSString *)imageName
                       selImageName:(NSString *)selImageName
                               font:(NSInteger)font;
/**
 *  创建UITextField
 */
+(UITextField*)createTextFieldWithFrame:(CGRect)frame
                            placeholder:(NSString*)placeholder
                          leftImageView:(UIImageView*)imageView
                                   font:(NSInteger)font
                              textColor:(UIColor *)textColor;



@end
