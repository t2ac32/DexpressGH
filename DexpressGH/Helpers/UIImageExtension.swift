//
//  UIImageExtension.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//
import UIKit
import Foundation

extension UIImageView {

    struct Holder {
        static var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    }
    var imageCache: NSCache<NSString, UIImage> {
        get {
            return Holder.imageCache
        }
        set(newValue) {
            Holder.imageCache = newValue
        }
    }

    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {

        self.image = nil
        //If imageurl's imagename has space then this line going to work for this
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
