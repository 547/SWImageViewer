//
//  ImageViewerHandler.swift
//  SWImageViewer
//
//  Created by Supernova SanDick SSD on 2019/6/19.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation
import ImageViewer
import UIKit
public class ImageViewerHandler {
    public var dataSource:[ImageViewerDataItem]?
    public static func persentImageViewer(WithDatasoure data:[UIImage]?, starIndex:Int, viewController:UIViewController) -> () {
        guard let images = data, images.count > 0 else { return }
        let handler = ImageViewerHandler()
        handler.dataSource = ImageViewerDataItem.createDateItems(images: images)
        let galleryViewController =  GalleryViewController.init(startIndex: starIndex, itemsDataSource: handler, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: handler.galleryConfiguration())
        if images.count > 1 {
            let headerView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 24))
            headerView.textColor = UIColor.white
            headerView.font = UIFont.systemFont(ofSize: 14)
            galleryViewController.headerView = headerView
            galleryViewController.landedPageAtIndexCompletion = { index in
                headerView.text = "\(index + 1)/\(images.count)"
            }
        }
        viewController.presentImageGallery(galleryViewController, completion: nil)
    }
}
extension ImageViewerHandler {
    public static func persentImageViewerWithDataItems(_ dataItems:[ImageViewerDataItem]?, starIndex:Int, viewController:UIViewController) -> () {
        guard let dataItems = dataItems, dataItems.count > 0 else { return }
        let handler = ImageViewerHandler()
        handler.dataSource = dataItems
        let galleryViewController =  GalleryViewController.init(startIndex: starIndex, itemsDataSource: handler, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: handler.galleryConfiguration())
        if dataItems.count > 1 {
            let headerView = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 24))
            headerView.textColor = UIColor.white
            headerView.font = UIFont.systemFont(ofSize: 14)
            galleryViewController.headerView = headerView
            galleryViewController.landedPageAtIndexCompletion = { index in
                headerView.text = "\(index + 1)/\(dataItems.count)"
            }
        }
        viewController.presentImageGallery(galleryViewController, completion: nil)
    }
}
extension ImageViewerHandler {
    private func galleryConfiguration() -> GalleryConfiguration {
        return [
            GalleryConfigurationItem.closeButtonMode(.builtIn),
            GalleryConfigurationItem.thumbnailsButtonMode(.none),
            GalleryConfigurationItem.deleteButtonMode(.none),
            
            GalleryConfigurationItem.doubleTapToZoomDuration(0.15),
            
            GalleryConfigurationItem.maximumZoomScale(8),
            GalleryConfigurationItem.swipeToDismissThresholdVelocity(500)
        ]
    }
}
extension ImageViewerHandler: GalleryItemsDataSource {
    public func itemCount() -> Int {
        return dataSource?.count ?? 0
    }
    public func provideGalleryItem(_ index: Int, , defaultImage:UIImage = UIImage()) -> GalleryItem {
        var result = GalleryItem.image(fetchImageBlock: { $0(defaultImage)})
        guard let dataSource = dataSource, dataSource.count > index else { return result }
        result = dataSource[index].galleryItem
        return result
    }
}
