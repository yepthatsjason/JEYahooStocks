//
//  NSString+NSString_YQL.m
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "NSString+YQL.h"

@implementation NSString (NSString_YQL)

- (NSDate *)dateFromString {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
  });
  
  return [dateFormatter dateFromString:self];
}

@end
