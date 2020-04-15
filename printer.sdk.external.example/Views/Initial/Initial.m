//
//  Login.m
//  ibox.pro.sdk.external.example
//
//  Created by AxonMacMini on 02.02.15.
//  Copyright (c) 2015 DevReactor. All rights reserved.
//

#import "Initial.h"
#import "Utility.h"
#import "PrinterScanner.h"

@implementation Initial

#pragma mark - Ctor/Dtor
-(Initial *)init
{
    self = [super initWithNibName:@"Initial" bundle:NULL];
    if (self)
    {
        mPrinterHandler = NULL;
    }
    return self;
}

-(void)dealloc
{
    [viewActivity release];
    [btnPrinterScan release];
    [btnPrintInvoice release];
    [btnPrintText release];
    [lblPrinterState release];
    [lblPrinterTitle release];
    [ctrPrintViewHeight release];
    [btnPrintQR release];
    [txtQR release];
    [txtText release];
    [btnPrinterDisconnect release];
    [ctrScrollViewBottom release];
    [ctrScrollViewBottom release];
    [super dealloc];
}

#pragma mark - View controller life cycle
-(void)viewDidLoad
{
    NSLog(@"SDK version: %@", [[PrinterController instance] version]);
    
    [super viewDidLoad];
    [self updateControls];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self enableKeyboardObservers];
    
    mPrinterHandler = [[PrinterController instance] printerHandler];
    [mPrinterHandler setDelegate:self];
    
    [self updatePrinterInformation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view addGestureRecognizer:mTapGestureRecognizer];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view removeGestureRecognizer:mTapGestureRecognizer];
    [self disableKeyboardObservers];
    [self tap];
    [super viewWillDisappear:animated];
}

#pragma mark - Events
-(void)btnPrinterScanClick
{
    PrinterScanner *printerScanner = [[PrinterScanner alloc] init];
    [printerScanner setDelegate:self];
    [self.navigationController pushViewController:printerScanner animated:TRUE];
    [printerScanner release];
}

-(void)btnPrinterDisconnectClick
{
    if ([mPrinterHandler connected])
    {
        [mPrinterHandler disconnectBTDevice];
    }
}

-(void)btnPrintQRClick
{
    if ([mPrinterHandler connected])
    {
        NSString *qrData = [txtQR text];
        if (qrData && ![qrData isEqualToString:@""])
        {
            [mPrinterHandler clearBuffer];
            [mPrinterHandler addQRData2Buffer:[txtQR text]];
            [mPrinterHandler printBuffer];
        }
    }
    else
        NSLog(@"Printer not connected");
}

-(void)btnPrintTextClick
{
    if ([mPrinterHandler connected])
    {
        NSString *textData = [txtText text];
        if (textData && ![textData isEqualToString:@""])
        {
            [mPrinterHandler printText:textData];
        }
    }
    else
    {
        NSLog(@"Printer not connected");
    }
}

-(void)btnPrintInvoiceClick
{
    if ([mPrinterHandler connected])
    {
        [mPrinterHandler clearBuffer];
        
        [mPrinterHandler addText2Buffer:@"********************************" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"*  OLEG&Co                     *" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"*  OLEG&Co                     *" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"*  1111                        *" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"*  +62(232)323-23-23           *" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"********************************" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ПРИХОД" Alignment:NSTextAlignmentCenter];
        [mPrinterHandler addText2Buffer:@"--------------------------------" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"КАССИР           Олег Медведьйев" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ДАТА/ВРЕМЯ     13.05.19 16:53:43" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"НОМЕР ЧЕКА:         YXA648GAAPNM" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"--------------------------------" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"1 X 58.00=58.00" Alignment:NSTextAlignmentRight];
        [mPrinterHandler addText2Buffer:@"--------------------------------" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ИТОГ                       58.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"--------------------------------" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"Сумма без НДС              58.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"   Без НДС                  0.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"НАЛИЧНЫМИ                   0.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ЭЛЕКТРОННЫМИ               58.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ПРЕДВАРИТЕЛЬНАЯ ОПЛАТА (АВАНС)" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"   0.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"ПОСЛЕДУЮЩАЯ ОПЛАТА (КРЕДИТ) 0.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"СДАЧА                       0.00" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@" +                            +" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  11.05.19 15:42" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  ИНН" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  СНО                УСН ДОХОД" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  Сайт ФНС     http://nalog.ru" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  Смена №                   35" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  Чек №                      1" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  ЗН ККТ:       00106705224895" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  ФН №        9999078900001218" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  ФД №                     409" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"  ФПД №:            3116755862" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@" +                            +" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addQRData2Buffer:@"https://www.apple.com"];
        [mPrinterHandler addText2Buffer:@"********************************" Alignment:NSTextAlignmentLeft];
        [mPrinterHandler addText2Buffer:@"Спасибо за покупку." Alignment:NSTextAlignmentCenter];
        
        [mPrinterHandler printBuffer];
    }
    else
    {
        NSLog(@"Printer not connected");
    }
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    [ctrScrollViewBottom setConstant:216.0f];
    [self.view layoutIfNeeded];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [ctrScrollViewBottom setConstant:0.0f];
    [self.view layoutIfNeeded];
}

-(void)tap
{
    [txtQR resignFirstResponder];
    [txtText resignFirstResponder];
}

#pragma mark - Keyboard observers
-(void)enableKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:NULL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:NULL];
}

-(void)disableKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - PrinterScannerDelegate
-(void)PrinterScannerDelegateSelectedPrinter:(BTDevice *)printer
{
    if (printer)
    {
        NSLog(@"Selected printer - %@", [printer title]);
    }
}

#pragma mark - PrinterDelegate
-(void)onPrinterInitialized{}
-(void)onConnectionChanged:(BOOL)value
{
    [self updatePrinterInformation];
}

-(void)onFoundBTDevices:(NSArray *)devices{}
-(void)onPrinterError:(PrinterError)error{}
-(void)onPrintingFinish{}

#pragma mark - Other methods
-(void)updateControls
{
    [Utility updateTextWithViewController:self];
    [viewActivity setHidden:TRUE];
    
    [txtQR setText:@"https://www.apple.com"];
    
    NSString *invoiceData = @"\n"
    "********************************\n"
    "*  OLEG&Co                     *\n"
    "*  OLEG&Co                     *\n"
    "*  1111                        *\n"
    "*  +62(232)323-23-23           *\n"
    "********************************\n"
    "             ПРИХОД             \n"
    "--------------------------------\n"
    "КАССИР           Олег Медведьйев\n"
    "ДАТА/ВРЕМЯ     13.05.19 16:53:43\n"
    "НОМЕР ЧЕКА:         YXA648GAAPNM\n"
    "--------------------------------\n"
    "                 1 X 58.00=58.00\n"
    "--------------------------------\n"
    "ИТОГ                       58.00\n"
    "--------------------------------\n"
    "Сумма без НДС              58.00\n"
    "   Без НДС                  0.00\n"
    "НАЛИЧНЫМИ                   0.00\n"
    "ЭЛЕКТРОННЫМИ               58.00\n"
    "ПРЕДВАРИТЕЛЬНАЯ ОПЛАТА (АВАНС)  \n"
    "   0.00                         \n"
    "ПОСЛЕДУЮЩАЯ ОПЛАТА (КРЕДИТ) 0.00\n"
    "СДАЧА                       0.00\n"
    "                                \n"
    "                                \n"
    " +                            + \n"
    "  11.05.19 15:42                \n"
    "  ИНН                           \n"
    "  СНО                УСН ДОХОД  \n"
    "  Сайт ФНС     http://nalog.ru  \n"
    "  Смена №                   35  \n"
    "  Чек №                      1  \n"
    "  ЗН ККТ:       00106705224895  \n"
    "  ФН №        9999078900001218  \n"
    "  ФД №                     409  \n"
    "  ФПД №:            3116755862  \n"
    " +                            + \n"
    "                                \n"
    "********************************\n"
    "       Спасибо за покупку.      \n";
    [txtText setText:invoiceData];
    NSLog(@"%@", invoiceData);
    
    [btnPrinterScan addTarget:self action:@selector(btnPrinterScanClick) forControlEvents:UIControlEventTouchUpInside];
    [btnPrinterDisconnect addTarget:self action:@selector(btnPrinterDisconnectClick) forControlEvents:UIControlEventTouchUpInside];
    [btnPrintQR addTarget:self action:@selector(btnPrintQRClick) forControlEvents:UIControlEventTouchUpInside];
    [btnPrintInvoice addTarget:self action:@selector(btnPrintInvoiceClick) forControlEvents:UIControlEventTouchUpInside];
    [btnPrintText addTarget:self action:@selector(btnPrintTextClick) forControlEvents:UIControlEventTouchUpInside];
    
    mTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [mTapGestureRecognizer setNumberOfTapsRequired:1];
    [mTapGestureRecognizer setNumberOfTouchesRequired:1];
}

-(void)updatePrinterInformation
{
    if (![mPrinterHandler connected])
    {
        [lblPrinterState setText:[Utility localizedStringWithKey:@"initial_printer_state_disconnected"]];
        [lblPrinterTitle setText:NULL];
        
        [ctrPrintViewHeight setConstant:0.0f];
    }
    else
    {
        [lblPrinterState setText:[Utility localizedStringWithKey:@"initial_printer_state_connected"]];
        [lblPrinterTitle setText:[mPrinterHandler deviceName]];
        
        [ctrPrintViewHeight setConstant:460.0f];
    }
}

@end
