//
//  ViewController.m
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import "ViewController.h"
#import "JEYahooStocksController.h"
#import <DRPBase/DRPLogging.h>
#import "JEYahooStockPrice.h"

@implementation ViewController {
  JEYahooStocksController *_stocks;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    NSDate *lastYear = [NSDate dateWithTimeIntervalSinceNow:-31536000];
    _stocks = [[JEYahooStocksController alloc] initWithTicker:@"GOOG"
                                                    startDate:lastYear
                                                      endDate:[NSDate date]];
    
    [_stocks fetchStockPrices:^(NSArray *results) {
      if (!results.count) {
        DRPLogError(@"Failed to load stock data");
        return;
      }

      DRPLogDebug(@"Loaded historical stock prices: %@", results);

      JEYahooStockPrice *price = results.firstObject;

      _lastPriceLabel.text = [NSString stringWithFormat:@"$%f", price.close];
    }];
  }
  return self;
}

@end
