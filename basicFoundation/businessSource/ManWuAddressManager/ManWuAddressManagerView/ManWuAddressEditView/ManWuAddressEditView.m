//
//  ManWuAddressEditView.m
//  basicFoundation
//
//  Created by 逸行 on 15-5-13.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "ManWuAddressEditView.h"
#import "HZAreaPickerView.h"
#import "ManWuAddressSetDefaultView.h"
#import "ManWuAddressBottomVIew.h"
#import "ManWuAddressEditService.h"
#import "MWUtils.h"

#define stand_textfield_left   (15.0)
#define stand_textfield_right  (15.0)
#define stand_container_height (40.0)

@interface ManWuAddressEditView()<UITextFieldDelegate, HZAreaPickerDelegate,WeAppBasicServiceDelegate,UIAlertViewDelegate>{

}

@property (strong, nonatomic) CSLinearLayoutView    *container;

@property (strong, nonatomic) UITextField           *nameInfoText;
@property (strong, nonatomic) UITextField           *phoneNumText;

@property (strong, nonatomic) UITextField           *areaText;
@property (strong, nonatomic) HZAreaPickerView      *locatePicker;

@property (strong, nonatomic) UITextField           *descriptionText;

@property (strong, nonatomic) ManWuAddressSetDefaultView   *settingDefaultView;
@property (strong, nonatomic) ManWuAddressBottomVIew       *bottomView;

@property (strong, nonatomic) ManWuAddressEditService      *addressEditService;

@property (strong, nonatomic) ManWuAddressEditService      *addressDeleteService;

@end

@implementation ManWuAddressEditView

-(void)setupView{
    [super setupView];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
    
    self.backgroundColor = RGB(0xf8, 0xf8, 0xf8);
    [self addSubview:self.container];
    [self reloadData];
}

-(void)dealloc{
    [self dismissKeyboard];
    if (_locatePicker) {
        [_locatePicker cancelPicker];
        _locatePicker.delegate = nil;
        _locatePicker = nil;
    }
}

-(void)setAddressInfoModel:(ManWuAddressInfoModel *)addressInfoModel{
    _addressInfoModel = addressInfoModel;
    self.nameInfoText.text = addressInfoModel.recvName;
    self.phoneNumText.text = addressInfoModel.phoneNum;
    NSArray* addressArray = [addressInfoModel.address componentsSeparatedByString:@" "];
    if ([addressArray count] > 1) {
        self.areaText.text = [addressArray count] > 0? [addressArray objectAtIndex:0]:addressInfoModel.address;
        self.descriptionText.text = [addressArray count] > 1?[addressArray objectAtIndex:1]:addressInfoModel.address;
    }else{
        self.areaText.text = @"";
        self.descriptionText.text = addressInfoModel.address;
    }
    
    self.settingDefaultView.isDefaultAddress = addressInfoModel?addressInfoModel.defaultAddress:self.isDefaultAddress;
    if (addressInfoModel) {
        self.isDefaultAddress = addressInfoModel.defaultAddress;
    }
    if (_addressInfoModel.addressId == nil) {
        self.deleteButton.enabled = NO;
        self.deleteButton.hidden = YES;
    }else{
        self.deleteButton.enabled = YES;
        self.deleteButton.hidden = NO;
    }
}

-(ManWuAddressEditService *)addressEditService{
    if (_addressEditService == nil) {
        _addressEditService = [[ManWuAddressEditService alloc] init];
        _addressEditService.delegate = self;
    }
    return _addressEditService;
}

-(ManWuAddressEditService *)addressDeleteService{
    if (_addressDeleteService == nil) {
        _addressDeleteService = [[ManWuAddressEditService alloc] init];
        _addressDeleteService.delegate = self;
    }
    return _addressDeleteService;
}

-(void)reloadData{
    [self.container removeAllItems];
    
    CSLinearLayoutItemPadding padding = CSLinearLayoutMakePadding(0, stand_textfield_left, 0.0, 0);
    
    CSLinearLayoutItem *nameInfoTextLayoutItem = [[CSLinearLayoutItem alloc]
                                                     initWithView:self.nameInfoText];
    nameInfoTextLayoutItem.padding             = padding;
    [self.container addItem:nameInfoTextLayoutItem];
    
    UIView* endline =  [TBDetailUITools drawDivisionLine:stand_textfield_left
                                                    yPos:0
                                               lineWidth:self.width - stand_textfield_left - stand_textfield_right];
    CSLinearLayoutItem *nameInfoTextEndLineLayoutItem = [[CSLinearLayoutItem alloc]
                                                  initWithView:endline];
    nameInfoTextEndLineLayoutItem.padding             = padding;
    [self.container addItem:nameInfoTextEndLineLayoutItem];
    
    CSLinearLayoutItem *phoneNumTextLayoutItem = [[CSLinearLayoutItem alloc]
                                                  initWithView:self.phoneNumText];
    phoneNumTextLayoutItem.padding             = padding;
    [self.container addItem:phoneNumTextLayoutItem];
    
    UIView* endline1 =  [TBDetailUITools drawDivisionLine:stand_textfield_left
                                                    yPos:0
                                               lineWidth:self.width - stand_textfield_left - stand_textfield_right];
    CSLinearLayoutItem *phoneNumTextEndLineLayoutItem = [[CSLinearLayoutItem alloc]
                                                         initWithView:endline1];
    phoneNumTextEndLineLayoutItem.padding             = padding;
    [self.container addItem:phoneNumTextEndLineLayoutItem];
    
    CSLinearLayoutItem *areaTextLayoutItem = [[CSLinearLayoutItem alloc]
                                                initWithView:self.areaText];
    areaTextLayoutItem.padding             = padding;
    [self.container addItem:areaTextLayoutItem];
    
    UIView* endline2 =  [TBDetailUITools drawDivisionLine:stand_textfield_left
                                                     yPos:0
                                                lineWidth:self.width - stand_textfield_left - stand_textfield_right];
    CSLinearLayoutItem *areaTextEndLineLayoutItem = [[CSLinearLayoutItem alloc]
                                                         initWithView:endline2];
    areaTextEndLineLayoutItem.padding             = padding;
    [self.container addItem:areaTextEndLineLayoutItem];
    
    CSLinearLayoutItem *descriptionTextLayoutItem = [[CSLinearLayoutItem alloc]
                                              initWithView:self.descriptionText];
    descriptionTextLayoutItem.padding             = padding;
    [self.container addItem:descriptionTextLayoutItem];
    
    UIView* endline3 =  [TBDetailUITools drawDivisionLine:stand_textfield_left
                                                     yPos:0
                                                lineWidth:self.width - stand_textfield_left - stand_textfield_right];
    CSLinearLayoutItem *descriptionTextEndLineLayoutItem = [[CSLinearLayoutItem alloc]
                                                     initWithView:endline3];
    descriptionTextEndLineLayoutItem.padding             = padding;
    [self.container addItem:descriptionTextEndLineLayoutItem];
    
    CSLinearLayoutItem *settingDefaultViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                     initWithView:self.settingDefaultView];
    [self.container addItem:settingDefaultViewLayoutItem];

    CSLinearLayoutItem *bottomViewLayoutItem = [[CSLinearLayoutItem alloc]
                                                        initWithView:self.bottomView];
    [self.container addItem:bottomViewLayoutItem];
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    [self dismissKeyboard];
    [self showPickView:NO];
}

#pragma mark - container

- (CSLinearLayoutView *)container {
    if (!_container) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.height);
        _container = [[CSLinearLayoutView alloc] initWithFrame:frame];
        _container.autoAdjustFrameSize = YES;
        _container.backgroundColor  = [TBDetailUIStyle colorWithStyle:TBDetailColorStyle_ComponentBg1];
    }
    return _container;
}

-(void)setupTextField:(UITextField*)textField{
    if (textField == nil) {
        return;
    }
    textField.textColor = RGB(0x99, 0x99, 0x99);
    textField.font = [UIFont boldSystemFontOfSize:15];
    [textField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];

    textField.delegate = self;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

-(UITextField *)nameInfoText{
    if (_nameInfoText == nil) {
        _nameInfoText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, stand_container_height)];
        [self setupTextField:_nameInfoText];
        _nameInfoText.placeholder = @"收货人姓名";
    }
    return _nameInfoText;
}

-(UITextField *)phoneNumText{
    if (_phoneNumText == nil) {
        _phoneNumText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, stand_container_height)];
        [self setupTextField:_phoneNumText];
        _phoneNumText.keyboardType = UIKeyboardTypePhonePad;
        _phoneNumText.placeholder = @"手机号码";
    }
    return _phoneNumText;
}

-(UITextField *)areaText{
    if (_areaText == nil) {
        _areaText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, stand_container_height)];
        [self setupTextField:_areaText];
        _areaText.placeholder = @"省、市、区";
    }
    return _areaText;
}

-(HZAreaPickerView *)locatePicker{
    if (_locatePicker == nil) {
        _locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
    }
    return _locatePicker;
}

-(UITextField *)descriptionText{
    if (_descriptionText == nil) {
        _descriptionText = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.width, stand_container_height)];
        [self setupTextField:_descriptionText];
        _descriptionText.placeholder = @"详细地址";
    }
    return _descriptionText;
}

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_deleteButton setTitleColor:RGB(0x66, 0x66, 0x66) forState:UIControlStateNormal];
        [_deleteButton setTitleEdgeInsets:UIEdgeInsetsMake(0, _deleteButton.width - 40, 0, 2)];
        [_deleteButton setBackgroundColor:[UIColor clearColor]];
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

-(void)deleteButtonClicked:(id)sender {
    UIAlertView* aleatView = [[UIAlertView alloc] initWithTitle:nil message:@"确定需要删除地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [aleatView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.addressDeleteService deleteAddressInfoWithAddressId:self.addressInfoModel.addressId];
    }
}

-(ManWuAddressSetDefaultView *)settingDefaultView{
    if (_settingDefaultView == nil) {
        _settingDefaultView = [[ManWuAddressSetDefaultView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        WEAKSELF
        _settingDefaultView.addressSwitchClick = ^(BOOL isOn){
            STRONGSELF
            strongSelf.isDefaultAddress = isOn;
        };
    }
    return _settingDefaultView;
}

-(ManWuAddressBottomVIew *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[ManWuAddressBottomVIew alloc] initWithFrame:CGRectMake(0, 0, self.width, 90)];
        WEAKSELF
        _bottomView.addressBottomClick = ^(){
            STRONGSELF
            // bottom click todo save or delete
            // 请求service 成功后再执行
            @try {
                NSRange range = [strongSelf.descriptionText.text rangeOfString:strongSelf.areaText.text];
                if (range.location != NSNotFound) {
                    strongSelf.descriptionText.text = [strongSelf.descriptionText.text substringFromIndex:range.location + range.length];
                }
                NSString* address = [NSString stringWithFormat:@"%@ %@",strongSelf.areaText.text?:@"",strongSelf.descriptionText.text];
                if ([MWUtils isEmptyString:strongSelf.nameInfoText.text]) {
                    [WeAppToast toast:@"请输入姓名"];
                    return;
                }
                if (![MWUtils isValidMobile:strongSelf.phoneNumText.text]) {
                    [WeAppToast toast:@"请输入正确的手机号码"];
                    return;
                }
                [strongSelf.addressEditService editAddressInfoWithAddressId:strongSelf.addressInfoModel.addressId userId:[KSAuthenticationCenter userId] recvName:strongSelf.nameInfoText.text?:strongSelf.addressInfoModel.recvName phoneNum:strongSelf.phoneNumText.text?:strongSelf.addressInfoModel.phoneNum address:address?:strongSelf.addressInfoModel.address defaultAddress:strongSelf.isDefaultAddress];
            }
            @catch (NSException *exception) {
                NSLog(@"----> address edit page crashed for reason of %@",exception.reason);
            }
        };
    }
    return _bottomView;
}

-(void)showPickView:(BOOL)showView{
    if (showView) {
        [self.locatePicker showInView:self];
        [self.locatePicker.locatePicker becomeFirstResponder];
    }else{
        [self.locatePicker cancelPicker];
    }
}

-(void)dismissKeyboard {
    NSArray *subviews = [self.container subviews];
    for (id objInput in subviews) {
        if ([objInput isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objInput;
            if ([objInput isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}

//点击键盘上的Return按钮响应的方法
-(IBAction)nextOnKeyboard:(UITextField *)sender
{
    [self hidenKeyboard];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.areaText) {
        [self dismissKeyboard];
        [self showPickView:YES];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.container scrollRectToVisible:textField.frame animated:YES];
    [self showPickView:NO];
}


#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaText.text = [NSString stringWithFormat:@"%@%@%@", picker.locate.state, picker.locate.city, picker.locate.district];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark WeAppBasicServiceDelegate method

-(void)serviceDidFinishLoad:(WeAppBasicService *)service{
    if (service == self.addressEditService) {
        [WeAppToast toast:@"保存成功"];
        if (self.addressDidChangeBlock) {
            self.addressDidChangeBlock(YES, self.addressInfoModel);
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    }else if (service == self.addressDeleteService){
        [WeAppToast toast:@"删除成功"];
        if (self.addressDidChangeBlock) {
            self.addressDidChangeBlock(YES, nil);
            [self.viewController.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)service:(WeAppBasicService *)service didFailLoadWithError:(NSError *)error{
    if (service == self.addressEditService) {
        [WeAppToast toast:@"保存失败，请稍后再试"];
    }else if (service == self.addressDeleteService){
        [WeAppToast toast:@"删除失败，请稍后再试"];
    }
}

@end
