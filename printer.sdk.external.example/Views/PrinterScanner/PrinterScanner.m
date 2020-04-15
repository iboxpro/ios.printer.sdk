//
//  ReaderScanner.m
//  ibox.pro.sdk.external.example
//
//  Created by Axon on 31.03.17.
//  Copyright © 2017 DevReactor. All rights reserved.
//

#import "PrinterScanner.h"
#import "Utility.h"
#import "BTDevice.h"
#import "PrinterScannerCell.h"

@implementation PrinterScanner

#pragma mark - Ctor/Dtor
-(PrinterScanner *)init
{
    self = [super initWithNibName:@"PrinterScanner" bundle:NULL];
    if (self)
    {
        mPrinterHandler = NULL;
        mDevices = NULL;
    }
    return self;
}

-(void)dealloc
{
    if (mDevices) [mDevices release];
    [btnClose release];
    [TableView release];
    [viewActivity release];
    [super dealloc];
}

#pragma mark - View controller life cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateControls];
    
    mPrinterHandler = [[PrinterController instance] printerHandler];
    
    [mPrinterHandler disconnectBTDevice];
    [mPrinterHandler disable];
    [mPrinterHandler setDelegate:self];
    [mPrinterHandler enable];
}

#pragma mark - Events
-(void)btnCloseClick
{
    [mPrinterHandler setDelegate:NULL];
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - Table view source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mDevices count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PrinterScannerCell";
    PrinterScannerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        NSArray *items = [[NSBundle mainBundle] loadNibNamed:@"PrinterScannerCell" owner:self options:NULL];
        for(id item in items)
        {
            if ([item isKindOfClass:[PrinterScannerCell class]])
            {
                cell = item;
                break;
            }
        }
    }
    
    BTDevice *device = [mDevices objectAtIndex:(int)indexPath.row];
    [cell.lblTitle setText:[device titleExtended]];

    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTDevice *device = [mDevices objectAtIndex:(int)indexPath.row];
    if (device)
    {
        [mPrinterHandler setDevice:device];
        
        if (mDelegate && [mDelegate respondsToSelector:@selector(PrinterScannerDelegateSelectedPrinter:)])
            [mDelegate PrinterScannerDelegateSelectedPrinter:device];
    }
    [self btnCloseClick];
}

#pragma mark - PrinterDelegate
-(void)onPrinterInitialized{}
-(void)onConnectionChanged:(BOOL)value{}

-(void)onFoundBTDevices:(NSArray *)devices
{
    if ([devices count])
    {
        [self setDevices:devices];
        [TableView reloadData];
    }
}

-(void)onPrinterError:(PrinterError)error{}
-(void)onPrintingFinish{}

#pragma mark - Other methods
-(void)updateControls
{
    [Utility updateTextWithViewController:self];
    
    [self setAutomaticallyAdjustsScrollViewInsets:FALSE];
    [viewActivity setHidden:TRUE];
    
    [TableView setDataSource:self];
    [TableView setDelegate:self];
    
    UIView *emptyFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [TableView setTableFooterView:emptyFooterView];
    [emptyFooterView release];
    
    [btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setDevices:(NSArray *)devices
{
    if (mDevices != devices)
    {
        if (mDevices)
            [mDevices release];
        [devices retain];
        mDevices = devices;
    }
}

#pragma mark - Public methods
-(void)setDelegate:(id<PrinterScannerDelegate>)delegate
{
    mDelegate = delegate;
}

 /*
-(void)setReaderType:(PaymentControllerReaderType)readerType
{
    mReaderType = readerType;
}

-(void)setReaderTypeLocalized:(NSString *)readerTypeLocalized
{
    if (mReaderTypeLocalized != readerTypeLocalized)
    {
        if (mReaderTypeLocalized)
            [mReaderTypeLocalized release];
        [readerTypeLocalized retain];
        mReaderTypeLocalized = readerTypeLocalized;
    }
}

-(PaymentControllerReaderType)readerType
{
    return mReaderType;
}

-(NSString *)readerTypeLocalized
{
    return mReaderTypeLocalized;
}
*/

@end
