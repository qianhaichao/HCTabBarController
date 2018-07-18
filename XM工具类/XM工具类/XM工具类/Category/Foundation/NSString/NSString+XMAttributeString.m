//
//  NSString+XMAttributeString.m
//  XM工具类
//
//  Created by 钱海超 on 2018/6/21.
//  Copyright © 2018年 北京大账房信息技术有限公司. All rights reserved.
//

#import "NSString+XMAttributeString.h"

@implementation NSString (XMAttributeString)

#pragma mark - 主要设置方法
- (NSMutableAttributedString *)xm_attributeStringWithAttribute:(NSDictionary *)attribute
                                                         range:(NSRange)range
                                                          type:(XMAttributeStringType)type
{
    if(range.location > self.length || range.location == NSNotFound){
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSUInteger len = 0;
    if(range.location + range.length > self.length){ //如果range超过字符串长度
        len = self.length - range.location; //取出未超过部分
    }else{
        len = range.length;
    }
    range = NSMakeRange(range.location, len);
    if(type == XMAttributeStringTypeSelected){
        [attrStr addAttributes:attribute range:range];
    }else{
        NSArray *reRangeArr = [self reverseRangeArrayWithRangeArray:@[[NSValue valueWithRange:range]]];
        for (NSValue * reRangeValue in reRangeArr) {
            NSRange reRange = [reRangeValue rangeValue];
            [attrStr addAttributes:attribute range:reRange];
        }
    }
    return attrStr;
}

- (NSMutableAttributedString *)xm_attributeStringWithAttribute:(NSDictionary *)attribute
                                                    attrString:(NSString *)attrString
                                                          type:(XMAttributeStringType)type
{
    if([self rangeOfString:attrString].location == NSNotFound){
        return [[NSMutableAttributedString alloc] initWithString:self];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSArray *rangeArr = [self rangeArrayWithString:attrString];
    if(type == XMAttributeStringTypeSelected){
        for (NSValue *rangeValue in rangeArr) {
            NSRange range = [rangeValue rangeValue];
            [attrStr addAttributes:attribute range:range];
        }
    }else{
        NSArray *reRangeArr = [self reverseRangeArrayWithRangeArray:rangeArr];
        for (NSValue *rangeValue in reRangeArr) {
            NSRange range = [rangeValue rangeValue];
            [attrStr addAttributes:attribute range:range];
        }
    }
    return attrStr;
}


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
                                                   type:(XMAttributeStringType)type
{
    return [self xm_attributeStringWithTextColor:textColor font:nil range:range type:type];
}

/**
 根据内容设置文字颜色

 @param textColor 文字颜色
 @param attrString 要设置的文字
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                                attrString:(NSString *)attrString
                                                   type:(XMAttributeStringType)type
{
    return [self xm_attributeStringWithTextColor:textColor font:nil attrString:attrString type:type];
}

/**
 根据多个内容设置文字颜色

 @param textColor    文字颜色
 @param attrStringArr 要改变的字符串
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                          attrStringArr:(NSArray *)attrStringArr
                                                   type:(XMAttributeStringType)type
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(textColor == nil) return attrStr;
    NSDictionary *attribute = @{NSForegroundColorAttributeName: textColor};

    NSMutableArray *rangeArr = [NSMutableArray array];
    for (NSString *str in attrStringArr) {
        [rangeArr addObjectsFromArray:[self rangeArrayWithString:str]];
    }

    if(type == XMAttributeStringTypeSelected){
        for (NSValue *rangeValue in rangeArr) {
            NSRange range = [rangeValue rangeValue];
            [attrStr addAttributes:attribute range:range];
        }
    }else{
        NSArray *reRangeArr = [self reverseRangeArrayWithRangeArray:rangeArr];
        for (NSValue *rangeValue in reRangeArr) {
            NSRange range = [rangeValue rangeValue];
            [attrStr addAttributes:attribute range:range];
        }
    }
    return attrStr;

}

#pragma mark - 设置字体
/**
 根据位置设置文字的字体

 @param font 字体
 @param range 位置
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithFont:(UIFont *)font
                                             range:(NSRange)range
                                              type:(XMAttributeStringType)type
{
    return [self xm_attributeStringWithTextColor:nil font:font range:range type:type];
}

/**
 根据内容设置文字字体

 @param font 文字字体
 @param attrString 要设置的文字
 @param type 设置类型
 */
- (NSAttributedString *)xm_attributeStringWithFont:(UIFont *)font
                                        attrString:(NSString *)attrString
                                              type:(XMAttributeStringType)type
{
    return [self xm_attributeStringWithTextColor:nil font:font attrString:attrString type:type];
}

#pragma mark - 设置字体和颜色
/**
 根据内容设置文字颜色和字体

 @param font         字体
 @param textColor    文字颜色
 @param range        位置
 @param type         设置类型
 */

- (NSAttributedString *)xm_attributeStringWithTextColor:(UIColor *)textColor
                                                   font:(UIFont *)font
                                                  range:(NSRange )range
                                                   type:(XMAttributeStringType)type
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(textColor == nil && font == nil) return attrStr;
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    if(textColor){
        [attribute setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    if(font){
        [attribute setObject:font forKey:NSFontAttributeName];
    }
    return [self xm_attributeStringWithAttribute:attribute range:range type:type];
}
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
                                                   type:(XMAttributeStringType)type
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(textColor == nil && font == nil) return attrStr;
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    if(textColor){
        [attribute setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    if(font){
        [attribute setObject:font forKey:NSFontAttributeName];
    }
    return [self xm_attributeStringWithAttribute:attribute attrString:attrString type:type];
}

#pragma mark - 设置行间距和字间距

/**
 单纯的改变行间距

 @param lineSpace 行间距
 */
- (NSAttributedString *)xm_attributeStringWithLineSpace:(CGFloat)lineSpace
{
    return [self xm_attributeStringWitLineSpace:lineSpace textSpace:-1];
}

/**
 单纯的改变字间距
 @param textSpace 字间距
 */
- (NSAttributedString *)xm_attributeStringWithTextSpace:(CGFloat)textSpace
{
    return [self xm_attributeStringWitLineSpace:-1 textSpace:textSpace];
}

/**
 *  同时改变行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param textSpace 字间距
 */

- (NSAttributedString *)xm_attributeStringWitLineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self];
    if(lineSpace <= 0 && textSpace <= 0) return attr;
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    if(lineSpace > 0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = lineSpace;
        [attribute setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }
    if(textSpace > 0){
        long number = textSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
        [attribute setObject:(__bridge id)num forKey:NSKernAttributeName];
    }

    return [self xm_attributeStringWithAttribute:attribute attrString:self type:XMAttributeStringTypeSelected];
}


/**
 *  单纯改变一句话中的某些字体颜色(一种颜色)
 *
 *  @param textColor    文字颜色
 *  @param subStringArr 需要改变的字符串(要是有相同的只改变第一个)
 */
- (NSAttributedString *)xm_changeTextColorWitxmolor:(UIColor *)textColor SubStringArr:(NSArray *)subStringArr
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSString *rangeStr in subStringArr) {
        NSRange range = [self rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }
    return attributeStr;
}

/**
 *  改变字符串中某些文字的字体和颜色
 *
 *  @param font         字体
 *  @param textColor    文字颜色
 *  @param subStringArr 要改变的字符串
 */

- (NSAttributedString *)xm_changeTextFontAndTextColor:(UIFont *)font TextColor:(UIColor *)textColor SubStringArr:(NSArray *)subStringArr
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];

    for(NSString *rangeStr in subStringArr){

        NSRange range = [self rangeOfString:rangeStr];

        [attributeStr addAttribute:NSFontAttributeName value:font range:range];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    }

    return attributeStr;
}

/**
 *  单纯的改变字间距
 *
 *  @param space 文字间隙
 */
- (NSAttributedString *)xm_changeTextSpaceWithSapce:(CGFloat)space
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];
    long number = space;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);

    [attributeStr addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributeStr length])];
    CFRelease(num);

    return attributeStr;
}
/**
 *  单纯的改变行间距
 *  @param lineSpace 段落间隙
 */
- (NSAttributedString *)xm_changeLineSpaceWithSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;

    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];

    return attributeStr;
}
/**
 *  同时改变行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param textSpace 字间距
 */

- (NSAttributedString *)xm_changeLineAndTextSpaceWitLineSpace:(CGFloat)lineSpace TextSpace:(CGFloat)textSpace
{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:self];

    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);

    [attributeStr addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0, [attributeStr length])];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;

    [attributeStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];

    return attributeStr;
}

#pragma mark - 私有方法
- (NSArray *)rangeArrayWithString:(NSString *)string
{
    NSMutableArray *rangeArr = [NSMutableArray array];
    NSString *str = self;
    while (1) {

        NSRange range = [rangeArr.lastObject rangeValue];
        if (range.location != NSNotFound) { // 数组中有值

            if (self.length - range.location - range.length) {  // 未越界
                str = [self substringWithRange:NSMakeRange(range.location + range.length, self.length - (range.location + range.length))];
            } else {
                return rangeArr;    // 越界时返回数组
            }
        }

        if ([str rangeOfString:string].location == NSNotFound) {    // 无匹配字符串时返回数组
            return rangeArr;
        }

        NSRange tmpRange = [str rangeOfString:string];
        NSRange lastRange = [rangeArr.lastObject rangeValue];
        if (lastRange.location == NSNotFound) { // 数组中无值时
            lastRange = NSMakeRange(0, 0);
        }

        [rangeArr addObject:[NSValue valueWithRange:NSMakeRange(lastRange.location + lastRange.length + tmpRange.location, tmpRange.length)]];

    }
}

- (NSArray *)reverseRangeArrayWithRangeArray:(NSArray *)rangeArray
{
    NSMutableArray *reRangeArr = [NSMutableArray array];

    // 添加第一个range之前的range
    NSValue *firstValue = rangeArray.firstObject;
    NSRange firstRange = [firstValue rangeValue];
    [reRangeArr addObject:[NSValue valueWithRange:NSMakeRange(0, firstRange.location)]];

    for (int i = 0; i < rangeArray.count - 1; i++) {
        NSValue *value = rangeArray[i];
        NSValue *nextValue = rangeArray[i+1];
        NSRange range = [value rangeValue];
        NSRange nextRange = [nextValue rangeValue];

        [reRangeArr addObject:[NSValue valueWithRange:NSMakeRange(range.location + range.length, nextRange.location - range.location - range.length)]];
    }

    // 添加最后一个range之前的range
    NSValue *lastValue = rangeArray.lastObject;
    NSRange lastRange = [lastValue rangeValue];
    [reRangeArr addObject:[NSValue valueWithRange:NSMakeRange(lastRange.location + lastRange.length, self.length - lastRange.location - lastRange.length)]];


    return reRangeArr;
}


@end
