//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Josep on 13/07/2018.
//  Copyright © 2018 Epeuva. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    
    // You're on the screen. Otherwise it will be updated on viewVillAppear
    if(self.view.window) [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{ NSForegroundColorAttributeName: [UIColor greenColor], NSStrokeWidthAttributeName : @-3}];
}

- (NSAttributedString *)characterswithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    while(index < [self.textToAnalyze length]) {
        NSRange range;
        // Value could be a color, font, and so on, so we use id
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if(value){
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return characters;
}

- (void) updateUI {
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", [[self characterswithAttribute:NSForegroundColorAttributeName]  length]];
    
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters", [[self characterswithAttribute:NSStrokeWidthAttributeName]  length]];
}

@end
