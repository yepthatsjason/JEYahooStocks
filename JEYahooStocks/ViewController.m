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
      DRPLogDebug(@"Loaded historical stock prices: %@", results);
    }];
  }
  return self;
}

@end
