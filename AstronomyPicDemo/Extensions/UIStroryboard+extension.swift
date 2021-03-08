//
//  UIStroryboard+extension.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

#if canImport(UIKit)  && !os(watchOS)
import UIKit

public extension UIStoryboard {

    static var main: UIStoryboard? {
        let bundle = Bundle.main
        guard let name = bundle.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: bundle)
    }

    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }

}

#endif
