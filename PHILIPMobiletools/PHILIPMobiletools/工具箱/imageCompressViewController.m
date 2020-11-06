//
//  imageCompressViewController.m
//  PHILIPMobiletools
//
//  Created by 孙铭健 on 2020/11/6.
//

#import "imageCompressViewController.h"
#import "SSKit.h"
#import <TZImagePickerController/TZImagePickerController.h>

@interface imageCompressViewController ()

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (weak, nonatomic) IBOutlet UILabel *size100;
@property (weak, nonatomic) IBOutlet UILabel *size60;
@property (weak, nonatomic) IBOutlet UILabel *size30;

@property (weak, nonatomic) IBOutlet UILabel *quality100;
@property (weak, nonatomic) IBOutlet UILabel *quality60;
@property (weak, nonatomic) IBOutlet UILabel *quality30;

@property (nonatomic, strong) UIImage *image; // 原图
@property (nonatomic, strong) UIImage *resultiImage; // 结果图

@end

@implementation imageCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ss_navigationTitle:@"图片压缩"];
    [self ss_navigationBarTransparent];
    [self ss_navigationBarImageBackButton:@"icon_back_black"];
    
    [_size100 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSize100)]];
    [_size60 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSize60)]];
    [_size30 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSize30)]];
    
    [_quality100 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToQuality100)]];
    [_quality60 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToQuality60)]];
    [_quality30 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToQuality30)]];
    
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSelectImage)]];
    
    
    _selectView.layer.cornerRadius = 8;
    _size100.layer.cornerRadius = 8;
    _size60.layer.cornerRadius = 8;
    _size30.layer.cornerRadius = 8;
    _quality100.layer.cornerRadius = 8;
    _quality60.layer.cornerRadius = 8;
    _quality30.layer.cornerRadius = 8;
    _saveBtn.layer.cornerRadius = 24;
    
    [self clickToSize100];
    self.imageView.image = SSImageNamed(@"添加图片 2");
}

- (IBAction)clickToSave:(id)sender
{
//    [_imageView.image ss_imageSaveToPhotosAlbum];
    
}

- (void)clickToSelectImage
{
    TZImagePickerController *vc = [TZImagePickerController.alloc initWithMaxImagesCount:1 delegate:self];
    vc.allowPickingGif = NO;
    vc.allowPickingVideo = NO;
    @weakify;
    vc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify;
        self.image = photos.firstObject;
        self.imageView.image = self.image;
    };
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)clickToSize100
{
    _size100.textColor = UIColor.whiteColor;
    _size100.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size60.textColor = UIColor.darkGrayColor;
    _size60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size30.textColor = UIColor.darkGrayColor;
    _size30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality100.textColor = UIColor.darkGrayColor;
    _quality100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality60.textColor = UIColor.darkGrayColor;
    _quality60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality30.textColor = UIColor.darkGrayColor;
    _quality30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    
    if (_image) {
        _imageView.image = _image;
    }
}

- (void)clickToSize60
{
    _size60.textColor = UIColor.whiteColor;
    _size60.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size100.textColor = UIColor.darkGrayColor;
    _size100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size30.textColor = UIColor.darkGrayColor;
    _size30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality100.textColor = UIColor.darkGrayColor;
    _quality100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality60.textColor = UIColor.darkGrayColor;
    _quality60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality30.textColor = UIColor.darkGrayColor;
    _quality30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    
    if (_image) {
        _imageView.image = [_image ss_imageScale:0.6];
    }
}

- (void)clickToSize30
{
    _size30.textColor = UIColor.whiteColor;
    _size30.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size100.textColor = UIColor.darkGrayColor;
    _size100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size60.textColor = UIColor.darkGrayColor;
    _size60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality100.textColor = UIColor.darkGrayColor;
    _quality100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality60.textColor = UIColor.darkGrayColor;
    _quality60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality30.textColor = UIColor.darkGrayColor;
    _quality30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    
    if (_image) {
        _imageView.image = [_image ss_imageScale:0.3];
    }
}

- (void)clickToQuality100
{
    _quality100.textColor = UIColor.whiteColor;
    _quality100.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size100.textColor = UIColor.darkGrayColor;
    _size100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size60.textColor = UIColor.darkGrayColor;
    _size60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size30.textColor = UIColor.darkGrayColor;
    _size30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality60.textColor = UIColor.darkGrayColor;
    _quality60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality30.textColor = UIColor.darkGrayColor;
    _quality30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    
    if (_image) {
        _imageView.image = _image;
    }
}

- (void)clickToQuality60
{
    _quality60.textColor = UIColor.whiteColor;
    _quality60.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size100.textColor = UIColor.darkGrayColor;
    _size100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size60.textColor = UIColor.darkGrayColor;
    _size60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size30.textColor = UIColor.darkGrayColor;
    _size30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality100.textColor = UIColor.darkGrayColor;
    _quality100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality30.textColor = UIColor.darkGrayColor;
    _quality30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    
    if (_image) {
        
    }
}

- (void)clickToQuality30
{
    _quality30.textColor = UIColor.whiteColor;
    _quality30.backgroundColor = SSColorRGBA(62, 137, 234, 1);
    
    _size100.textColor = UIColor.darkGrayColor;
    _size100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size60.textColor = UIColor.darkGrayColor;
    _size60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _size30.textColor = UIColor.darkGrayColor;
    _size30.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality100.textColor = UIColor.darkGrayColor;
    _quality100.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    _quality60.textColor = UIColor.darkGrayColor;
    _quality60.backgroundColor = SSColorRGBA(240, 240, 240, 1);
    if (_image) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.5);
        NSLog(@"-- %ld", data.length);
        NSLog(@"== %ld", [_image ss_imageCompressMinQuality].length);
        _imageView.image = [UIImage imageWithData:[_image ss_imageCompressMinQuality]];
        data = [_imageView.image ss_imageCompressMinQuality];
        NSLog(@"** %ld", data.length);
        
        NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp.JPG"];
        [data writeToFile:jpgPath atomically:YES];

        [PHPhotoLibrary.sharedPhotoLibrary performChanges:^{
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImageAtFileURL:[NSURL URLWithString:jpgPath]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"success = %d, error = %@", success, error);
        }];
    }
}

@end
