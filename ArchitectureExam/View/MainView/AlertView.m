//
//  AlertView.m
//  ArchitectureExam
//
//  Created by Lumig on 15/12/27.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,copy) AlertBlock alertBlock;

@end

@implementation AlertView

- (id)initWithtitle:(NSString *)title content:(NSString *)content indexBlock:(AlertBlock)block
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AlertView" owner:nil options:nil] lastObject];
    if (self) {
        self.contentView.layer.cornerRadius = 6;
        self.contentView.layer.masksToBounds = YES;
        self.titleLabel.text = title;
        self.contentLabel.text = content;
        self.alertBlock = block;
        
    }
    return self;
}

- (void)dismiss
{
    [self setAlpha:0];
}

+ (void)showInView:(UIView *)superView title:(NSString *)title content:(NSString *)content indexBlock:(AlertBlock)block
{
    AlertView *alertView = [[AlertView alloc] initWithtitle:@"温馨提示" content:content indexBlock:block];
    [superView addSubview:alertView];
}


- (IBAction)cancelBtnDidClick:(id)sender {
    [self dismiss];
}

- (IBAction)submitBtnDidClick:(id)sender {
    if (self.alertBlock) {
        self.alertBlock(1);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
