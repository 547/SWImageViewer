//
//  ImageViewerDataItem.swift
//  SWImageViewer
//
//  Created by Supernova SanDick SSD on 2019/6/19.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation
import ImageViewer
import UIKit
public struct ImageViewerDataItem {
    public let imageView:UIImageView
    public let galleryItem: GalleryItem
    public init(image:UIImage) {
        self.imageView = UIImageView.init(image: image)
        self.galleryItem = GalleryItem.image(fetchImageBlock: { (imageCompletion) in
            imageCompletion(image)
        })
    }
    public init(image:UIImage, galleryItem: GalleryItem) {
        self.imageView = UIImageView.init(image: image)
        self.galleryItem = galleryItem
    }
    public static func createDateItems(images:[UIImage]) -> [ImageViewerDataItem] {
        var result = [ImageViewerDataItem]()
        for item in images {
            result.append(ImageViewerDataItem.init(image: item))
        }
        return result
    }
}
extension ImageViewerDataItem {
   public static func createDateItemsWithMultimedias(_ multimedias:[MultimediaEntity], defaultImage:UIImage = UIImage()) -> [ImageViewerDataItem]? {
        var result = [ImageViewerDataItem]()
        for item in multimedias {
            let image = item.image ?? defaultImage
            var galleryItem = GalleryItem.image(fetchImageBlock: { (imageCompletion) in
                imageCompletion(image)
            })
            if item.type == .video, let url = URL.init(string: item.url) {
                galleryItem = GalleryItem.video(fetchPreviewImageBlock: { (imageCompletion) in
                    imageCompletion(image)
                }, videoURL: url)
            }
            let dataItem = ImageViewerDataItem.init(image: image, galleryItem: galleryItem)
            result.append(dataItem)
        }
        return result.count == 0 ? nil : result
    }
}
