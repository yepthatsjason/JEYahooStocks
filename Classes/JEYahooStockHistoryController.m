//
//  JEYahooStockHistoryController.m
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "JEYahooStockHistoryController.h"
#import "YQL.h"
#import "NSDate+YQL.h"
#import "NSString+YQL.h"
#import <DRPBase/DRPLogging.h>
#import "JEYahooStockPrice.h"

@implementation JEYahooStockHistoryController {
  NSString *_ticker;
  NSDate *_startDate;
  NSDate *_endDate;
}

- (instancetype)initWithTicker:(NSString *)ticker
                     startDate:(NSDate *)startDate
                       endDate:(NSDate *)endDate {
  self = [super init];
  if (self) {
    _ticker = ticker;
    _startDate = startDate;
    _endDate = endDate;
  }
  return self;
}

- (void)fetchStockPrices:(stock_results_handler)handler {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    YQL *yql = [[YQL alloc] init];
    NSString *query = [NSString stringWithFormat:@"select * from yahoo.finance.historicaldata where symbol = \"%@\" and startDate = \"%@\" and endDate = \"%@\"",
                       _ticker,
                       [_startDate yqlDateFormat],
                       [_endDate yqlDateFormat]];
    
    NSDictionary *response = [yql query:query];
    NSArray *rawQuotes = response[@"query"][@"results"][@"quote"];
    NSArray *quotes = [self _parseQuotes:rawQuotes];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      handler(quotes);
    });
  });
}

- (NSArray *)_parseQuotes:(NSArray *)rawQuotes {
  if (!rawQuotes) {
    return nil;
  }
  
  NSMutableArray *formattedQuotes = [NSMutableArray array];
  
  for (NSDictionary *rawQuote in rawQuotes) {
    JEYahooStockPrice *price = [[JEYahooStockPrice alloc] initWithDate:[rawQuote[@"Date"] dateFromString]
                                                                 close:[rawQuote[@"Close"] floatValue]
                                                              adjClose:[rawQuote[@"Adj_Close"] floatValue]
                                                                  high:[rawQuote[@"High"] floatValue]
                                                                   low:[rawQuote[@"Low"] floatValue]
                                                                  open:[rawQuote[@"Open"] floatValue]
                                                                volume:[rawQuote[@"Volume"] integerValue]];
    [formattedQuotes addObject:price];
  }
  
  return formattedQuotes;
}

@end
