//
//  WirteReViewViewController.m
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "WirteReViewViewController.h"
@interface WirteReViewViewController ()
{
    UIScrollView *scrollView;
    UILabel*ratingLabel;
    UITextView *textView1;
    UILabel *label;
    UIImageView *photoImageView;
    UIImageView *photoImageView1;
    UIImageView *photoImageView2;
    NSString *index;
    NSInteger indexTag;
    NSString *ratingStr;
}
@property (nonatomic ,strong) ZYRatingView *starView;
@end

@implementation WirteReViewViewController
- (void)leftBtn
{
        [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Write Comments";
    index = @"0";

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT)];
    scrollView.backgroundColor = nav_Color;
    [self.view addSubview:scrollView];
    UIView *view = [[UIView alloc]initWithFrame:RECT(0, 10, 320, 260)];
    view.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view];
    ratingLabel = [[UILabel alloc]init];
    ratingLabel.frame =RECT(15, 5, 200, 20);
    ratingLabel.font = [UIFont systemFontOfSize:15];
    ratingLabel.textColor =Btn_Color;
    ratingLabel.text = @"Rating:";
    ratingLabel.textAlignment =NSTextAlignmentLeft;
    [view addSubview:ratingLabel];
    
    self.starView = [[ZYRatingView alloc]initWithFrame:RECT(15, 30, 100, 30)];
    [view addSubview:_starView];
    
    [_starView setImagesDeselected:@"xinglight" partlySelected:@"xinglight" fullSelected:@"xing" andDelegate:self];
    //设置评分
    [_starView displayRating:5];
    
    UIImageView *lineImage = [[UIImageView alloc]init];
    lineImage.frame = RECT(10, 65, 308, 1);
    lineImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [view addSubview:lineImage];
    
    
    textView1 = [[UITextView alloc]initWithFrame:RECT(10, 75, 300, 100)];
    //    textView.layer.borderWidth =1.0;
    //    textView.layer.cornerRadius =5.0;
    
    textView1.layer.borderColor = [[UIColor grayColor]CGColor];
    textView1.delegate = self;
    textView1.font = [UIFont fontWithName:@"Arial" size:15.0];
    [view addSubview:textView1];

    label = [[UILabel alloc]init];
    label.frame =RECT(15, 80, 200, 20);
    label.text = @"Review(at last 20 characters)";
    label.enabled = NO;//lable必须设置为不可用
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cameraBtn.frame =RECT(CURRENT_CONTENT_WIDTH - 70, 200, 70, 50);
    [cameraBtn addTarget:self action:@selector(carmeraBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cameraBtn];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:RECT(CURRENT_CONTENT_WIDTH - 40, 230, 22, 18)];
    imageView.image = [UIImage imageNamed:@"cameraImage"];
    [view addSubview:imageView];
    for (int i = 0; i<3; i++) {
        UIButton * canleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        canleBtn.frame = RECT(10 + 80 *i, 180, 70, 70);
        canleBtn.backgroundColor = [UIColor clearColor];
        [canleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        canleBtn.tag=i+100;
        canleBtn.userInteractionEnabled = NO;
        [canleBtn addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:canleBtn];
    }

    
    photoImageView = [[UIImageView alloc]initWithFrame:RECT(10, 180, 70, 70)];
    photoImageView1 = [[UIImageView alloc]initWithFrame:RECT(90, 180, 70, 70)];
    photoImageView2 = [[UIImageView alloc]initWithFrame:RECT(170, 180, 70, 70)];
    [view addSubview:photoImageView];
    [view addSubview:photoImageView1];
    [view addSubview:photoImageView2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = RECT(10, 285, 300, 40);
    btn.layer.cornerRadius = 3;
    btn.backgroundColor = Btn_Color;
    [btn setTitle:@"Submit" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btn];
    
    
}
//实现代理方法
-(void)ratingChanged:(float)newRating {
    //显示评分
//    label.text = [NSString stringWithFormat:@"%1.1f", newRating];
    ratingStr = [NSString stringWithFormat:@"%1.1f", newRating];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        label.text = @"Add your comment...";
    }else{
        label.text = @"";
    }
}
- (void)carmeraBtn:(UIButton *)btn
{
    NSLog(@"相机");
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo album", nil];
    [sheet showInView:self.view];
}
- (void)btn:(UIButton *)b
{
    NSLog(@"提交评论");
    [self showLoading];
    NSString *image1=[self base64:photoImageView.image];
    NSString *image2 = [self base64:photoImageView1.image];
    NSString *image3 = [self base64:photoImageView2.image];
    NSMutableDictionary *   requestDic = [[Singleton sharedInstance]zenidDic];

    [requestDic setObject:self.product_id forKey:@"products_id"];
    if (image1) {
        [requestDic setObject:image1 forKey:@"reviews_images[]=a"];
    }
    if (image2){
        [requestDic setObject:image2 forKey:@"reviews_images[]=b"];
    }
    if (image3) {
        [requestDic setObject:image3 forKey:@"reviews_images[]=c"];
    }
    NSDictionary *dic = [NSUserDefaultsDic dictionaryForKey:@"loginOK"];
    if (dic) {
        [requestDic setObject:ratingStr forKey:@"reviews_rating"];
        [requestDic setObject:textView1.text forKey:@"reviews_text"];
        [requestDic setObject:[dic objectForKey:@"useremail"] forKey:@"customers_name"];
        [LORequestManger POST:addProductReViews_Url params:requestDic URl:nil success:^(id response) {
            NSLog(@"%@",response);
            NSString *status =[response objectForKey:@"status"];
            
            if ([status isEqualToString:@"OK"])  {
                [self dismissSuccess:@"Success"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissError:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [self dismiss];
        }];
    }else {
        [requestDic setObject:ratingStr forKey:@"reviews_rating"];
        [requestDic setObject:textView1.text forKey:@"reviews_text"];
        [requestDic setObject:@"name" forKey:@"customers_name"];
        [LORequestManger POST:addProductReViews_Url params:requestDic URl:nil success:^(id response) {
            NSLog(@"%@",response);
            NSString *status =[response objectForKey:@"status"];
            
            if ([status isEqualToString:@"OK"])  {
                [self dismissSuccess:@"Success"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissError:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [self dismiss];
        }];
    }
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            //            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
        //        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else if (buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Access to photos error"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }

    
}


- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if ([index isEqualToString:@"0"]) {
        [self stauts1:image];
    } else if([index isEqualToString:@"1"]) {
        
        [self stauts2:image];
    }else if([index isEqualToString:@"2"]) {
        [self stauts3:image];
    }

    [picker dismissModalViewControllerAnimated:YES];
    NSLog(@"%@",editingInfo);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//判断状态
- (void)stauts1:(UIImage *)image
{
    photoImageView.frame =RECT(10, 180, 70, 70);
    [photoImageView setImage:image];
    index= @"1";
    UIButton *b =(UIButton*)[self.view viewWithTag:100];
    b.userInteractionEnabled =YES;
}

- (void)stauts2:(UIImage *)image
{
    photoImageView1.frame = RECT(90, 180, 70, 70);
    index= @"2";
    NSLog(@"%f",photoImageView1.frame.origin.x);
    [photoImageView1 setImage:image];
    UIButton *b =(UIButton*)[self.view viewWithTag:101];
    b.userInteractionEnabled =YES;
    
}
- (void)stauts3:(UIImage *)image
{
    photoImageView2.frame = RECT(170, 180, 70, 70);
    index= @"3";
    
    [photoImageView2 setImage:image];
    UIButton *b =(UIButton*)[self.view viewWithTag:102];
    b.userInteractionEnabled =YES;
    
}

- (void)removeImage:(UIButton *)btn
{
    NSLog(@"%ld",(long)btn.tag);
    indexTag = btn.tag;
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:nil message:@"Cancel image?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [av show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 1) {
        [self removeImage];
    }
}
- (void)removeImage
{
    UIButton *b =(UIButton*)[self.view viewWithTag:indexTag];
    if (indexTag == 100) {
        if (photoImageView1.image) {
            
            if (photoImageView2.image) {
                photoImageView.image = photoImageView1.image;
                photoImageView1.image = photoImageView2.image;
                photoImageView2.image = nil;
                b.userInteractionEnabled =YES;
                UIButton *b2 =(UIButton*)[self.view viewWithTag:indexTag+2];
                b2.userInteractionEnabled = NO;
                index = [NSString stringWithFormat:@"%ld",(indexTag-100)+2];
            }else{
                
                photoImageView.image = photoImageView1.image;
                photoImageView1.image = nil;
                b.userInteractionEnabled =YES;
                UIButton *b2 =(UIButton*)[self.view viewWithTag:indexTag+1];
                b2.userInteractionEnabled = NO;
                index = [NSString stringWithFormat:@"%ld",(indexTag-100)+1];
            }
            
        }else{
            index = [NSString stringWithFormat:@"%ld",indexTag-100];
            
            photoImageView.image = nil;
            b.userInteractionEnabled =NO;
            
        }
        
    }else if (indexTag == 101){
        if (photoImageView2.image) {
            photoImageView1.image = photoImageView2.image;
            photoImageView2.image = nil;
            b.userInteractionEnabled =YES;
            UIButton *b2 =(UIButton*)[self.view viewWithTag:indexTag+1];
            b2.userInteractionEnabled = NO;
            index = [NSString stringWithFormat:@"%ld",(indexTag-100)+1];
            
        }else{
            index = [NSString stringWithFormat:@"%ld",(indexTag-100)];
            b.userInteractionEnabled =NO;
            
            photoImageView1.image = nil;
            
        }
    }else if (indexTag == 102){
        index = [NSString stringWithFormat:@"%ld",(indexTag-100)];
        photoImageView2.image = nil;
        b.userInteractionEnabled =NO;
    }
    
    
    
}

- (NSString *)base64:(UIImage *)image
{
    NSData *headData = UIImageJPEGRepresentation(image ,0.00001);
    NSString *headPicBase64 = [headData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    return headPicBase64;
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
