//
//  JEYahooStockTickerController.m
//  JEYahooStocks
//
//  Created by ederle on 6/10/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "JEYahooStockTickerController.h"
#import "YQL.h"
#import "NSDate+YQL.h"
#import "NSString+YQL.h"
#import <DRPBase/DRPLogging.h>
#import "JEYahooStockPrice.h"

@implementation JEYahooStockTickerController {
  NSString *_symbol;
}

- (instancetype)initWithSymbol:(NSString *)ticker {
  self = [super init];
  if (self) {
    _symbol = ticker;
  }
  return self;
}

- (void)fetchCurrentPrice:(ticker_result_handler)handler {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    YQL *yql = [[YQL alloc] init];
    NSString *query = [NSString stringWithFormat:@"select * from yahoo.finance.quote where symbol in (\"%@\")",
                       _symbol];

    NSDictionary *response = [yql query:query];
    NSString *lastTradePriceStr = response[@"query"][@"results"][@"quote"][@"LastTradePriceOnly"];
    NSNumber *lastTradePrice = [NSNumber numberWithFloat:lastTradePriceStr.floatValue];
    dispatch_async(dispatch_get_main_queue(), ^{
      handler(lastTradePrice);
    });
  });
}

@end
