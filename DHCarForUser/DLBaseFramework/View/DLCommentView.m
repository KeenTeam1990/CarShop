//
//  DLCommentView.m
//  Auction
//
//  Created by 卢迎志 on 14-12-16.
//
//

#import "DLCommentView.h"

@implementation DLCommentView

DEF_FACTORY_FRAME(DLCommentView);

DEF_MODEL(myAttachmentIconBtn);
DEF_MODEL(myBackView);
DEF_MODEL(myFaceIconBtn);
DEF_MODEL(myTextField);
DEF_MODEL(myTextFieldBackView);
DEF_MODEL(myVoiceIconBtn);
DEF_MODEL(mySendBtn);
DEF_MODEL(myImageView);

DEF_MODEL(showAddImage);
DEF_MODEL(showAttachment);
DEF_MODEL(showFace);
DEF_MODEL(showSendBtn);
DEF_MODEL(showVoice);

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initCommentView];
        
    }
    return self;
}

-(void)initCommentView
{
    CGRect tempFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    self.myBackView = [[UIImageView alloc]initWithFrame:tempFrame];
 
    [self.myBackView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.myBackView];
    
    self.myTextFieldBackView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (NavigationBarHeight-35)/2, self.frame.size.width-90, 35)];
//    self.myTextFieldBackView.contentMode=UIViewContentModeScaleAspectFit;
    UIEdgeInsets inset;
    inset.left=10;inset.right=10;inset.top=10;inset.bottom=10;
    [self.myTextFieldBackView  setImage:[[UIImage imageNamed:@"聊天输入"]resizableImageWithCapInsets:inset]];
    [self addSubview:self.myTextFieldBackView];
    
    self.myTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.myTextFieldBackView.frame.origin.x+5, self.myTextFieldBackView.frame.origin.y+(self.myTextFieldBackView.frame.size.height-30)/2, self.myTextFieldBackView.frame.size.width-10, 30)];
    
    [self.myTextField setBorderStyle:UITextBorderStyleNone]; //外框类型
    self.myTextField.placeholder = @"请输入内容"; //默认显示的字
    self.myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.myTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.myTextField.returnKeyType = UIReturnKeySend;
    self.myTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    self.myTextField.enablesReturnKeyAutomatically = YES;
    self.myTextField.delegate = self;
    [self addSubview:self.myTextField];
    
    self.mySendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mySendBtn setBackgroundImage:[[UIImage imageNamed:@"btn_getcode_btn_h"]resizableImageWithCapInsets:inset ] forState:UIControlStateNormal];
    [self.mySendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mySendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.mySendBtn addTarget:self action:@selector(sendBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.mySendBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.mySendBtn.frame = CGRectMake(self.frame.size.width-70, (NavigationBarHeight-30)/2, 60, 30);
    [self addSubview:self.mySendBtn];
    
    self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addImageBtn setBackgroundColor:[UIColor redColor]];
    [self.addImageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.addImageBtn setTitle:@"添加图片" forState:UIControlStateNormal];
    [self.addImageBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.addImageBtn addTarget:self action:@selector(addImageBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.addImageBtn.frame = CGRectMake(10, NavigationBarHeight+(NavigationBarHeight-30)/2, 80, 30);
    self.addImageBtn.hidden = YES;
    [self addSubview:self.addImageBtn];
    
    self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, NavigationBarHeight, NavigationBarHeight, NavigationBarHeight)];
    
    [self addSubview:self.myImageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.myBackView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)setShowAddImage:(BOOL)show
{
    showAddImage = show;
    
    self.addImageBtn.hidden = !show;
    
    [self performSelector:@selector(showAddImageAnimation) withObject:nil afterDelay:0.3];
}

-(void)showAddImageAnimation
{
    if (self.showAddImage) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect tempframe = self.myTextFieldBackView.frame;
            tempframe.size.width = self.frame.size.width-20;
            self.myTextFieldBackView.frame = tempframe;
            
            tempframe = self.myTextField.frame;
            tempframe.size.width = self.myTextFieldBackView.frame.size.width-10;
            self.myTextField.frame = tempframe;
            
            tempframe = self.mySendBtn.frame;
            tempframe.origin.y = NavigationBarHeight + (NavigationBarHeight-30)/2;
            self.mySendBtn.frame = tempframe;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGRect tempframe = self.myTextFieldBackView.frame;
            tempframe.size.width = self.frame.size.width-90;
            self.myTextFieldBackView.frame = tempframe;
            
            tempframe = self.myTextField.frame;
            tempframe.size.width = self.myTextFieldBackView.frame.size.width-10;
            self.myTextField.frame = tempframe;
            
            tempframe = self.mySendBtn.frame;
            tempframe.origin.y = (NavigationBarHeight-30)/2 ;
            self.mySendBtn.frame = tempframe;
            
        } completion:^(BOOL finished) {

        }];
    }
}

-(void)addImageBtnPressed:(id)sender
{
    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(addImageBtnPressed:)]) {
        [self.delegate addImageBtnPressed:sender];
    }
}

-(void)sendBtnPressed:(id)sender
{
    [self hidekeyword];
    [self finish];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hidekeyword];
    [self finish];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    int MAXLENGTH = 200;
//    
//    if ([textField.text length] == 0) {
//        self.mySendBtn.enabled = NO;
//    }else{
//        self.mySendBtn.enabled = YES;
//    }
//    
//    if ([textField.text length] > MAXLENGTH )
//    {
//        textField.text = [textField.text substringToIndex:MAXLENGTH-1];
//        return NO;
//    }
//    return YES;
//}

-(void)showkeyword
{
    [self.myTextField becomeFirstResponder];
}

-(void)hidekeyword
{
    [self.myTextField resignFirstResponder];
    
}

-(void)finish
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(send:)]) {
        [self.delegate send:self.myTextField.text];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
