//
//  TipViewController.m
//  Tippy
//
//  Created by Sarah Wang on 6/22/21.
//

#import "TipViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentageControl;
@property (weak, nonatomic) IBOutlet UIView *labelsContainerView;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideLabels];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:true];
}

int previous = 0;

- (IBAction)updateLabels:(id)sender {
    if (self.billField.text.length == 0) {
        previous = 0;
        [self hideLabels];
        
    }
    else if(self.billField.text.length == 1 && previous == 0) {
        previous = 1;
        [self showLabels];
        
    }
   
    double tipPercentages[] = {0.15, 0.2, 0.25};
    double tipPercentage = tipPercentages[self.tipPercentageControl.selectedSegmentIndex];
    
    double bill = [self.billField.text doubleValue];
    double tip = bill * tipPercentage;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (void)hideLabels {
    [UIView animateWithDuration:0.5 animations:^{
        UIColor *colour = [[UIColor alloc]initWithRed:200.0/255.0 green:215.0/255.0 blue:255.0/255.0 alpha:1.0];
        self.view.backgroundColor = colour;
        
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y += 200;
        
        self.billField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y += 200;
        
        self.labelsContainerView.frame = labelsFrame;
        
        self.labelsContainerView.alpha = 0;
    }];
}

- (void)showLabels {
    [UIView animateWithDuration:0.5 animations:^{
        UIColor *colour = [[UIColor alloc]initWithRed:200.0/255.0 green:255.0/255.0 blue:220/255.0 alpha:1.0];
        self.view.backgroundColor = colour;
        
        CGRect billFrame = self.billField.frame;
        billFrame.origin.y -= 200;
        
        self.billField.frame = billFrame;
        
        CGRect labelsFrame = self.labelsContainerView.frame;
        labelsFrame.origin.y -= 200;
        
        self.labelsContainerView.frame = labelsFrame;
        
        self.labelsContainerView.alpha = 1;
    }];
}

@end
