//
//  PrinterDelegate.h
//  ibox.pro.sdk
//
//  Created by Axon on 13.07.17.
//  Copyright © 2017 ibox. All rights reserved.
//

typedef enum
{
    PrinterError_DISCONNECTED
} PrinterError;

@protocol PrinterDelegate <NSObject>

@required
-(void)onPrinterInitialized;
-(void)onConnectionChanged:(BOOL)value;
-(void)onFoundBTDevices:(NSArray *)devices;
-(void)onPrinterError:(PrinterError)error;
-(void)onPrintingFinish;

@end
