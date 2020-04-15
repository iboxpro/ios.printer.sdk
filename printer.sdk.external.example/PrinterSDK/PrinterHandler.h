//
//  PrinterHandler.h
//  ibox.pro.sdk
//
//  Created by Axon on 13.07.17.
//  Copyright © 2017 ibox. All rights reserved.
//

#import "PrinterDelegate.h"
#import "BTDevice.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

typedef enum
{
    PrinterType_QUNSUO_QS = 0
} PrinterType;

typedef enum
{
    PrinterResponse_DONE,
    PrinterResponse_ERROR
} PrinterResponse;

typedef enum
{
    PrinterState_IDLE,
    PrinterState_FILLING_BUFFER,
    PrinterState_PRINTING
} PrinterState;

@protocol PrinterHandler <NSObject>

@required
#pragma mark - common
-(id<PrinterHandler>)init;
-(PrinterState)state;
-(NSString *)deviceName;
-(void)enable;
-(void)disable;
-(void)resume;
-(void)setDelegate:(id<PrinterDelegate>)delegate;
-(void)setDevice:(BTDevice *)device;
-(void)disconnectBTDevice;
-(void)reconnect;
-(BOOL)connected;
-(int)batteryLevel;
-(int)tapeWidth;

#pragma mark - buffer printing
-(PrinterResponse)printBuffer;
-(void)addText2Buffer:(NSString *)text Alignment:(NSTextAlignment)alignment;
-(void)addQRData2Buffer:(NSString *)qrData;
-(void)addImage2Buffer:(UIImage *)image;
-(void)clearBuffer;

#pragma mark - simple printing
-(PrinterResponse)printDividerLine:(NSString *)dividerSign;
-(PrinterResponse)printText:(NSString *)text Alignment:(NSTextAlignment)alignment;
-(PrinterResponse)printText:(NSString *)text;
-(PrinterResponse)printKey:(NSString *)key Value:(NSString *)value;
-(PrinterResponse)printImage:(UIImage *)image;
-(PrinterResponse)scrollWithLines:(int)lines;

@end

