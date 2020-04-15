//
//  Login.h
//  ibox.pro.sdk.external.example
//
//  Created by AxonMacMini on 02.02.15.
//  Copyright (c) 2015 DevReactor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrinterScanner.h"

@interface Initial : UIViewController<PrinterScannerDelegate, PrinterDelegate>
{
@private id<PrinterHandler> mPrinterHandler;
@private UITapGestureRecognizer *mTapGestureRecognizer;
    
IBOutlet UIActivityIndicatorView *viewActivity;
IBOutlet UILabel *lblPrinterState;
IBOutlet UILabel *lblPrinterTitle;
IBOutlet UITextField *txtQR;
IBOutlet UITextView *txtText;
IBOutlet UIButton *btnPrinterScan;
IBOutlet UIButton *btnPrinterDisconnect;
IBOutlet UIButton *btnPrintInvoice;
IBOutlet UIButton *btnPrintText;
IBOutlet UIButton *btnPrintQR;
    
IBOutlet NSLayoutConstraint *ctrPrintViewHeight;
IBOutlet NSLayoutConstraint *ctrScrollViewBottom;
}

-(Initial *)init;

@end
