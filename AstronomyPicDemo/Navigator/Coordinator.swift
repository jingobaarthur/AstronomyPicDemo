//
//  Navigator.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import UIKit

protocol Navigatable {
    var navigator: Coordinator { get }
}

extension Navigatable {
    var navigator: Coordinator {
        return Coordinator.sharedInstance
    }
}

class Coordinator{
    static let sharedInstance = Coordinator()
    private init() {}
    
    enum Destination{
        
        enum TransitionType{
            case root(in: UIWindow)
            case navigation
            case present
        }
        
        case main
        case display(data: [AstronomyItems])
        case deatil(data: AstronomyItems)
    }
    
    func getViewController(destination: Destination) -> UIViewController{
        switch destination{
        case .main:
            return MainViewController.initViewController()
        case .display(let data):
            return DisplayViewController.initViewController(data: data)
        case .deatil(let data):
            return DetailViewController.initViewController(data: data)
        }
    }
    
    func show(destination: Destination, sender: UIViewController, transitionType: Destination.TransitionType = .navigation){
        let targetVC = getViewController(destination: destination)
        showViewController(target: targetVC, sender: sender, transitionType: transitionType)
    }
    
    private func showViewController(target: UIViewController, sender: UIViewController?, transitionType: Destination.TransitionType){
         switch transitionType{
         case .root(in: let window):
            window.switchRootViewController(to: target, animated: true, duration: 0.5, options: .transitionFlipFromRight, nil)
             break
         default:
             break
         }
         guard let sender = sender else {
             fatalError("You need to pass in a sender for .navigation or .modal transitions")
         }
         switch transitionType{
         case .navigation:
             if let nav = sender.navigationController{
                 nav.pushViewController(target, animated: true)
             }else{
                 fatalError("why no navigationController")
             }
         case .present:
             sender.present(target, animated: true, completion: nil)
         default:
             fatalError("who are you")
         }
     }
}
