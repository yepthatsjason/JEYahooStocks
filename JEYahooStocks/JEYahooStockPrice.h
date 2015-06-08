//
//  JEYahooStockPrice.h
//  JEYahooStocks
//
//  Created by Jason Ederle on 6/7/15.
//  Copyright (c) 2015 Funly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEYahooStockPrice : NSObject
@property (readonly, nonatomic) NSDate *date;
@property (readonly, nonatomic) float close;
@property (readonly, nonatomic) float adjClose;
@property (readonly, nonatomic) float high;
@property (readonly, nonatomic) float low;
@property (readonly, nonatomic) float open;
@property (readonly, nonatomic) NSInteger volume;


- (instancetype)initWithDate:(NSDate *)date
                       close:(float)close
                    adjClose:(float)adjClose
                        high:(float)high
                         low:(float)low
                        open:(float)open
                      volume:(NSInteger)volume;

@end
