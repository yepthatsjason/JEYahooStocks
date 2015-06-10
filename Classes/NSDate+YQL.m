//
//  NSObject+NSDate_YQL.m
//  
//
//  Created by Jason Ederle on 6/7/15.
//
//

#import "NSDate+YQL.h"

@implementation NSDate (YQL)

- (NSString *)yqlDateFormat {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
  });
  
  return [dateFormatter stringFromDate:self];
}

@end
