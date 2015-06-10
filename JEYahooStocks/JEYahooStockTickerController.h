//
//  JEYahooStockTickerController.h
//  JEYahooStocks
//
//  Created by ederle on 6/10/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ticker_result_handler)(NSNumber *value);

@interface JEYahooStockTickerController : NSObject

- (instancetype)initWithSymbol:(NSString *)ticker;

- (void)fetchCurrentPrice:(ticker_result_handler)handler;

@end
