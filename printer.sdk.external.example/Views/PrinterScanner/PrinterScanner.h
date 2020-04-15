//
//  ReaderScanner.h
//  ibox.pro.sdk.external.example
//
//  Created by Axon on 31.03.17.
//  Copyright © 2017 DevReactor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrinterController.h"

@protocol PrinterScannerDelegate<NSObject>
-(void)PrinterScannerDelegateSelectedPrinter:(BTDevice *)printer;
@end

@interface PrinterScanner : UIViewController<UITableViewDataSource, UITableViewDelegate, PrinterDelegate>
{
IBOutlet UIButton *btnClose;
IBOutlet UITableView *TableView;
IBOutlet UIActivityIndicatorView *viewActivity;

@private id<PrinterHandler> mPrinterHandler;
@private id<PrinterScannerDelegate> mDelegate;
@private NSArray *mDevices;
}

-(PrinterScanner *)init;
-(void)setDelegate:(id<PrinterScannerDelegate>)delegate;

@end
