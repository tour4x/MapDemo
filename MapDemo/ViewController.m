//
//  ViewController.m
//  MapDemo
//
//  Created by X on 2018/3/12.
//  Copyright © 2018年 leyoubms. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#define kTileOverlayRemoteServerTemplate    @"http://10.80.25.105/tiles4/{z}/tile{x}_{y}.png"

#define kTileOverlayRemoteMinZ      15
#define kTileOverlayRemoteMaxZ      19


@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) MATileOverlay *tileOverlay;

@end

@implementation ViewController

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MATileOverlay class]])
    {
        MATileOverlayRenderer *renderer = [[MATileOverlayRenderer alloc] initWithTileOverlay:overlay];
        return renderer;
    }
    
    return nil;
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(24.677358, 118.175778);
    self.mapView.zoomLevel = kTileOverlayRemoteMaxZ;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.rotateEnabled = NO;

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* 添加新的楼层. */
    self.tileOverlay = [[MATileOverlay alloc] initWithURLTemplate:kTileOverlayRemoteServerTemplate];
    
    /* minimumZ 是tileOverlay的可见最小Zoom值. */
    self.tileOverlay.minimumZ = kTileOverlayRemoteMinZ;
    /* minimumZ 是tileOverlay的可见最大Zoom值. */
    self.tileOverlay.maximumZ = kTileOverlayRemoteMaxZ;
    
    /* boundingMapRect 是用来 设定tileOverlay的可渲染区域. */
    self.tileOverlay.boundingMapRect = MAMapRectWorld;
    self.tileOverlay.tileSize = CGSizeMake(128, 128);
    
    [self.mapView addOverlay:self.tileOverlay];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

@end

