//
//  PrinterController.h
//  printer.sdk.external
//
//  Created by Oleh Piskorskyj on 5/13/19.
//  Copyright © 2019 investbank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrinterHandler.h"

@interface PrinterController : NSObject

+(PrinterController *)instance;
+(void)destroy;

-(id<PrinterHandler>)printerHandler;
-(void)destroyPrinterHandler;

-(NSString *)version;

@end
