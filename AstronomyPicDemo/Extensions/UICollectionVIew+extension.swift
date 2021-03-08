//
//  UICollectionVIew+extension.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/4.
//

import UIKit

extension UICollectionView{
    func reload(completion:@escaping() -> ()){
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
            { _ in completion() }
    }
}
