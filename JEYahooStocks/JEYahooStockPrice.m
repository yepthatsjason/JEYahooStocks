//
//  JEYahooStockPrice.m
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "JEYahooStockPrice.h"

@implementation JEYahooStockPrice

- (instancetype)initWithDate:(NSDate *)date
                       close:(float)close
                    adjClose:(float)adjClose
                        high:(float)high
                         low:(float)low
                        open:(float)open
                      volume:(NSInteger)volume {
  self = [super init];
  if (self) {
    _date = date;
    _close = close;
    _adjClose = adjClose;
    _high = high;
    _low = low;
    _open = open;
    _volume = volume;
  }
  return self;
}

- (NSString *)description {
  return [NSString stringWithFormat:@"date:%@ close:%f", _date, _close];
}

@end
