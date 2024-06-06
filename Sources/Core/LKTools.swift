//
//  LKTools.swift
//
//
//  Created by 李棒棒 on 2024/6/6.
//

import Foundation
import UIKit

open class LKTools: NSObject {
    
    // 使用URLSession下载图片
   class func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
}
