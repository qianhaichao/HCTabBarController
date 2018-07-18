//
//  XMControl.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/20.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "XMControl.h"

@implementation XMControl

/**
 *  创建UILabel
 */
+(UILabel*)createLabelWithFrame:(CGRect)frame
                           font:(NSInteger)font
                           text:(NSString*)text
{

    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    //设置字体
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
//    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //设置内容
    label.text=text;
    return label;

}
/**
 *  创建UIButton
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                          imageName:(NSString *)imageName
                       selImageName:(NSString *)selImageName
                               font:(NSInteger)font
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];

    //设置标题
    [button setTitle:title forState:UIControlStateNormal];

    //设置按钮图片
    UIImage *image=[UIImage imageNamed:imageName];
    [button setImage:image forState:UIControlStateNormal];
    UIImage *selImage=[UIImage imageNamed:selImageName];
    [button setImage:selImage forState:UIControlStateHighlighted];

    button.titleLabel.font=[UIFont systemFontOfSize:font];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.5] forState:UIControlStateHighlighted];

    button.frame=frame;
    return button;
}
/**
 *  创建UITextField
 */
+(UITextField*)createTextFieldWithFrame:(CGRect)frame
                            placeholder:(NSString*)placeholder
                          leftImageView:(UIImageView*)imageView
                                   font:(NSInteger)font
                              textColor:(UIColor *)textColor
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色占位文字
    textField.placeholder=placeholder;
    //文字颜色
    textField.textColor=textColor;
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor blackColor];
    return textField ;

}

@end
