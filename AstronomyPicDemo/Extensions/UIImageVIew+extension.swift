//
//  UIImageVIew+extension.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import UIKit

extension UIImageView{
    func loadImage(urlString: String, size: CGSize){
        if let url = URL(string: urlString){
            let tempDirectory = FileManager.default.temporaryDirectory
            let imageFileUrl = tempDirectory.appendingPathComponent(url.lastPathComponent)
            if FileManager.default.fileExists(atPath: imageFileUrl.path){
                let image = UIImage(contentsOfFile: imageFileUrl.path)
                self.image = image?.imageResized(to: size)
            }else{
                self.image = nil
                let request = URLRequest(url: url)
                APIManager.sharedInstance.getImageRequest(request) { [weak self](result) in
                    guard let strongSelf = self else {return}
                    DispatchQueue.main.async {
                        switch result{
                        case.success(let data):
                            if let photoImage = UIImage(data: data){
                                try? data.write(to: imageFileUrl)
                                strongSelf.image = photoImage.imageResized(to: size)
                            }
                        case .failure(let error):
                            print("Set Image error:\(error.localizedDescription)")
                            strongSelf.image = nil
                        }
                    }
                }
            }
        }
    }
}
extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
