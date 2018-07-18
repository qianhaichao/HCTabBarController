//
//  NSString+XMAttributeString.h
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XMAttributeStringTypeSelected,  //选中文字
    XMAttributeStringTypeReverseSelected,  //反选文字
} XMAttributeStringType;

@interface NSString (XMAttributeString)

#pragma mark - 主要设置方法
- (NSMutableAttributedString *)xm_attributeStringWithAttribute:(NSDictionary *)attribute
                                                      range:(NSRange)range
                                                       type:(XMAttributeStringType)type;

- (NSMutableAttributedString *)xm_attributeStringWithAttribute:(NSDictionary *)attribute
                                                 attrString:(NSString *)attrString
                                                       type:(XMAttributeStringType)type;

#pragma mark - 一些基本的常用设置
#pragma mark - 设置文字颜色


/**
 根据位置设置文字颜色

 @param textColor 文字颜色
 @param range 位置
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                                  range:(NSRange)range
                                                   type:(XMAttributeStringType)type;

/**
 根据内容设置文字颜色

 @param textColor 文字颜色
 @param attrString 要设置的文字
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                                  attrString:(NSString *)attrString
                                                   type:(XMAttributeStringType)type;

/**
  根据多个内容设置文字颜色

  @param textColor    文字颜色
  @param attrStringArr 要改变的字符串
  @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                          attrStringArr:(NSArray *)attrStringArr
                                                   type:(XMAttributeStringType)type;

#pragma mark - 设置字体

/**
 根据位置设置文字的字体

 @param font 字体
 @param range 位置
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithFont:(UIFont *)font
                                             range:(NSRange)range
                                              type:(XMAttributeStringType)type;

/**
 根据内容设置文字字体

 @param font 文字字体
 @param attrString 要设置的文字
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithFont:(UIFont *)font
                                        attrString:(NSString *)attrString
                                              type:(XMAttributeStringType)type;




#pragma mark - 设置字体和颜色
/**
 根据内容设置文字颜色和字体

 @param font         字体
 @param textColor    文字颜色
 @param attrString 要改变的字符串
 @param type 设置类型
 */

- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                                   font:(UIFont *)font
                                             attrString:(NSString *)attrString
                                                   type:(XMAttributeStringType)type;

#pragma mark - 设置行间距和字间距

/**
 单纯的改变行间距

 @param lineSpace 行间距
 */
- (NSAttributedString *)xm_attributeStringWithLineSpace:(CGFloat)lineSpace;

/**
 单纯的改变字间距
 @param textSpace 字间距
 */
- (NSAttributedString *)xm_attributeStringWithTextSpace:(CGFloat)textSpace;

/**
 *  同时改变行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param textSpace 字间距
 */

- (NSAttributedString *)xm_attributeStringWitLineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;
@end
