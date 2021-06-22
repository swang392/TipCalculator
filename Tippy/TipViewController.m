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
    // Do any additional setup after loading the view.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    
    //removes keyboard from screen
    [self.view endEditing:true];
}

//If previous value is 0, then the screen previously had no bill amount inputted (and the labels are hidden). Thus, once the code detects that an amount is being typed in, labels will show.
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
    //an array to hold possible tip percentages
    double tipPercentages[] = {0.15, 0.2, 0.25};
    double tipPercentage = tipPercentages[self.tipPercentageControl.selectedSegmentIndex];
    
    //calculate tip
    double bill = [self.billField.text doubleValue];
    double tip = bill * tipPercentage;
    double total = bill + tip;
    
    //update labels
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

//animation to hide calculations and labels
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
        
        //disappearing labels
        self.labelsContainerView.alpha = 0;
    }];
}

//animation to hide calculations and labels
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
        
        //reappearing labels
        self.labelsContainerView.alpha = 1;
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
