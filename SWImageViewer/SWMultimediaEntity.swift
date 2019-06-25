//
//  SWMultimediaEntity.swift
//  SWImageViewer
//
//  Created by Supernova SanDick SSD on 2019/6/19.
//  Copyright © 2019 Seven. All rights reserved.
//

import Foundation
import UIKit
///多媒体（图片、视频、音频）
public class SWMultimediaEntity {
    public var identifier:String? = nil
    public var title:String? = nil
    ///主要内容的url
    public var url:String
    ///主图url
    public var imageUrl:String
    ///主图
    public var image:UIImage? = nil
    ///类型（图片、视频、音频）
    public var type:MultimediaType
    public init(identifier:String? = nil, title:String? = nil, url:String, imageUrl:String, image:UIImage? = nil, type:MultimediaType) {
        self.identifier = identifier
        self.title = title
        self.url = url
        self.imageUrl = imageUrl
        self.image = image
        self.type = type
    }
    ///创建image多媒体对象
    public convenience init(identifier:String? = nil, title:String? = nil, imageUrl:String, image:UIImage? = nil) {
        self.init(identifier: identifier, title: title, url: imageUrl, imageUrl: imageUrl, image: image, type: .image)
    }
}
extension SWMultimediaEntity {
    public enum MultimediaType {
        case image
        case video
        case audio
    }
}

