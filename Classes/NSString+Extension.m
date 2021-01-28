//
//  NSString+Extension.m
//  LittleBei
//
//  Created by 田洋 on 2018/12/3.
//  Copyright © 2018 田洋. All rights reserved.
//

#import "NSString+Extension.h"
#define SpecialCharacter @"@／：()；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""

@implementation NSString (Extension)
#pragma mark---获取字符串的字符长度--
- (int)convertToByte{
	
	int strlength = 0;
	char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
	for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
		if (*p) {
			p++;
			strlength++;
		}
		else {
			p++;
		}
	}
	return strlength;
}

#pragma mark---只能输入数字---
- (BOOL)validateNumber {
	BOOL res = YES;
	NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	int i = 0;
	while (i < self.length) {
		NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
		NSRange range = [string rangeOfCharacterFromSet:tmpSet];
		if (range.length == 0) {
			res = NO;
			break;
		}
		i++;
	}
	return res;
}
#pragma mark -------------------检查---------
- (BOOL)isUrl
{
	return [self match:@"[a-zA-z]+://[^\s]*"];
}

- (BOOL)match:(NSString *)pattern
{
	// 1.创建正则表达式
	NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
	// 2.测试字符串
	NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
	
	return results.count > 0;
}

/** 判断是不是手机号 */
- (BOOL)isPhoneNumber {
	NSString *regexStr = @"^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$";
	NSError *error;
	NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
	if (error) return NO;
	NSInteger count = [regular numberOfMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
	if (count > 0) {
		return YES;
	} else {
		return NO;
	}
}

+(BOOL)checkIdentityCardNo:(NSString*)cardNo
{
	if (cardNo.length != 18) {
		return  NO;
	}
	NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
	NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
	
	NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
	
	int val;
	BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
	if (!isNum) {
		return NO;
	}
	int sumValue = 0;
	
	for (int i =0; i<17; i++) {
		sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
	}
	
	NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
	
	if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
		return YES;
	}
	return  NO;
}

/** 移除所有空格 */
- (NSString *)removeALLBlankSpace{
	NSString *tempStr = [self removeBothSideBlankSpace];
	NSString *tempStr1 = [tempStr stringByReplacingOccurrencesOfString:@" " withString:@""];
	NSMutableString *resStr = [NSMutableString string];
	for (int i = 0; i < tempStr1.length; i++) {
		NSString *characStr = [tempStr1 substringWithRange:NSMakeRange(i, 1)];
		if (![characStr isEqualToString:@" "]) {
			[resStr appendString:characStr];
		}
	}
	
	return resStr;
}

/** 移除两端空格 */
- (NSString *)removeBothSideBlankSpace{
	return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 移除部分特殊字符( @／：()；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\")
 */
- (NSString *)removePartSpecialCharater{
	
	NSCharacterSet *set1 = [NSCharacterSet characterSetWithCharactersInString:[SpecialCharacter replaceSpecialWhitespace]];
	NSString *resStr1 = [self stringByTrimmingCharactersInSet:set1];
	
	NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:[SpecialCharacter replaceNormalWhiteSpace]];
	NSString *resStr2 = [resStr1 stringByTrimmingCharactersInSet:set2];
	
	return resStr2;
}


- (NSString *)replaceSpecialWhitespace{
	NSMutableString *convertedString = [self mutableCopy];
	CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false);
	return [NSString stringWithString:convertedString];
}
- (NSString *)replaceNormalWhiteSpace{
	NSMutableString *convertedString = [self mutableCopy];
	CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformHiraganaKatakana, false);
	return [NSString stringWithString:convertedString];
}


#pragma mark bounding 计算size宽高






@end
