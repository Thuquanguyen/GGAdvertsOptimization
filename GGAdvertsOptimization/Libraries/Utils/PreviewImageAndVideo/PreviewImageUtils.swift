//
//  PreviewImageUtils.swift
//  YTeThongMinh
//
//  Created by ThanhND on 7/22/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import UIKit

struct DataItem {
    let galleryItem: GalleryItem
}

@objc protocol PreviewImageDelete: class {
    @objc optional func launchedCompletion()
    @objc optional func closedCompletion()
    @objc optional func swipedToDismissCompletion()
    @objc optional func landedPageAtIndexCompletion(index: Int)
}

class PreviewImageUtils {
    static func showPreviewImage(from vc: UIViewController,
                                 dataSoucre: GalleryItemsDataSourceDeletgate,
                                 configuration: GalleryConfiguration = defaultConfiguration(),
                                 headerView: UIView? = nil,
                                 footerView: UIView? = nil,
                                 startIndex: Int = 0,
                                 previewDelegate: PreviewImageDelete? = nil) {
        let galleryViewController = GalleryViewController(startIndex: startIndex, itemsDataSource: dataSoucre, itemsDelegate: dataSoucre, displacedViewsDataSource: dataSoucre, configuration: configuration)
        galleryViewController.headerView = headerView
        galleryViewController.footerView = footerView
        galleryViewController.launchedCompletion = {
            print("LAUNCHED")
            previewDelegate?.launchedCompletion?()
        }
        galleryViewController.closedCompletion = {
            print("CLOSED")
            previewDelegate?.closedCompletion?()
        }
        galleryViewController.swipedToDismissCompletion = {
            print("SWIPE-DISMISSED")
            previewDelegate?.swipedToDismissCompletion?()
        }
        galleryViewController.landedPageAtIndexCompletion = { index in
            print("LANDED AT INDEX: \(index)")
            previewDelegate?.landedPageAtIndexCompletion?(index: index)
        }
        vc.presentImageGallery(galleryViewController)
    }
    
    static func defaultConfiguration() -> GalleryConfiguration {
        return [
            GalleryConfigurationItem.closeButtonMode(.builtIn),
            GalleryConfigurationItem.deleteButtonMode(.none),
            GalleryConfigurationItem.thumbnailsButtonMode(.none),
            
            GalleryConfigurationItem.pagingMode(.standard),
            GalleryConfigurationItem.presentationStyle(.displacement),
            GalleryConfigurationItem.hideDecorationViewsOnLaunch(false),
            
            GalleryConfigurationItem.toggleDecorationViewsBySingleTap(false),
            GalleryConfigurationItem.activityViewByLongPress(false),
            
            GalleryConfigurationItem.overlayColor(UIColor(white: 0.035, alpha: 1)),
            GalleryConfigurationItem.overlayColorOpacity(1),
            GalleryConfigurationItem.overlayBlurOpacity(1),
            GalleryConfigurationItem.overlayBlurStyle(UIBlurEffect.Style.light),
            
            GalleryConfigurationItem.videoControlsColor(.white),
            
            GalleryConfigurationItem.maximumZoomScale(8),
            GalleryConfigurationItem.swipeToDismissThresholdVelocity(500),
            GalleryConfigurationItem.swipeToDismissMode(.vertical),
            
            GalleryConfigurationItem.doubleTapToZoomDuration(0.15),
            
            GalleryConfigurationItem.blurPresentDuration(0.5),
            GalleryConfigurationItem.blurPresentDelay(0),
            GalleryConfigurationItem.colorPresentDuration(0.25),
            GalleryConfigurationItem.colorPresentDelay(0),
            
            GalleryConfigurationItem.blurDismissDuration(0.1),
            GalleryConfigurationItem.blurDismissDelay(0.4),
            GalleryConfigurationItem.colorDismissDuration(0.45),
            GalleryConfigurationItem.colorDismissDelay(0),
            
            GalleryConfigurationItem.itemFadeDuration(0.3),
            GalleryConfigurationItem.decorationViewsFadeDuration(0.15),
            GalleryConfigurationItem.rotationDuration(0.15),
            
            GalleryConfigurationItem.displacementDuration(0.55),
            GalleryConfigurationItem.reverseDisplacementDuration(0.25),
            GalleryConfigurationItem.displacementTransitionStyle(.springBounce(0.7)),
            GalleryConfigurationItem.displacementTimingCurve(.linear),
            
            GalleryConfigurationItem.statusBarHidden(true),
            GalleryConfigurationItem.displacementKeepOriginalInPlace(false),
            GalleryConfigurationItem.displacementInsetMargin(50)
        ]
    }
}

class GalleryItemsDataSourceDeletgate: NSObject, GalleryItemsDataSource, GalleryItemsDelegate, GalleryDisplacedViewsDataSource {
    
    var datas: [DataItem] = []
    var didTapDeleteBtn: ((Int, DataItem)->())?
    var provideDisplacementItem: ((Int) -> (DisplaceableView?))?
    
    init(datas: [DataItem],
                  didTapDeleteBtn: ((Int, DataItem)->())? = nil,
                  provideDisplacementItem: ((Int) -> (DisplaceableView?))? = nil) {
        self.datas = datas
        self.didTapDeleteBtn = didTapDeleteBtn
        self.provideDisplacementItem = provideDisplacementItem
    }
    
    func itemCount() -> Int {
        datas.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        return datas[index].galleryItem
    }
    
    func removeGalleryItem(at index: Int) {
        print("remove at index")
        didTapDeleteBtn?(index, datas[index])
    }
    func provideDisplacementItem(atIndex index: Int) -> DisplaceableView? {
        return provideDisplacementItem?(index)
    }
}

