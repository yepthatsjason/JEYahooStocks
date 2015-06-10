//
//  ViewController.m
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "ViewController.h"
#import "JEYahooStockHistoryController.h"
#import "JEYahooStockTickerController.h"
#import <DRPBase/DRPLogging.h>
#import "JEYahooStockPrice.h"

@implementation ViewController {
  JEYahooStockHistoryController *_historyController;
  JEYahooStockTickerController *_tickerController;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    NSDate *lastYear = [NSDate dateWithTimeIntervalSinceNow:-31536000];
    _historyController = [[JEYahooStockHistoryController alloc] initWithTicker:@"GOOG"
                                                          startDate:lastYear
                                                            endDate:[NSDate date]];
    
    [_historyController fetchStockPrices:^(NSArray *results) {
      if (!results.count) {
        DRPLogError(@"Failed to load stock data");
        return;
      }

      DRPLogDebug(@"Loaded historical stock prices: %@", results);

      JEYahooStockPrice *price = results.firstObject;
    }];

    _tickerController = [[JEYahooStockTickerController alloc] initWithSymbol:@"GOOG"];
    [_tickerController fetchCurrentPrice:^(NSNumber *value) {
      DRPLogDebug(@"Current ticker value is: %@", value);
      _lastPriceLabel.text = [NSString stringWithFormat:@"$%d", (int)(1250 * value.floatValue)];
    }];
  }
  return self;
}

@end
