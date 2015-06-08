//
//  JEYahooStocksController.h
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^stock_results_handler)(NSArray *results);

@interface JEYahooStocksController : NSObject

- (instancetype)initWithTicker:(NSString *)ticker
                     startDate:(NSDate *)startDate
                       endDate:(NSDate *)endDate;

- (void)fetchStockPrices:(stock_results_handler)handler;

@end
