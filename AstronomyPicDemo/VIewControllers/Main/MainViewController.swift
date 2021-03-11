//
//  ViewController.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/4.
//

import UIKit

class MainViewController: BaseViewController {
    
    fileprivate let viewModel = MainViewModel()
    
   private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Astronomy Pictrue of the Day"
        label.numberOfLines = 0
        return label
    }()
    
    private let requestButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapedRequestButton), for: .touchUpInside)
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBind()
    }
    
    override func setUpUI() {
        super.setUpUI()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(requestButton)
        
        titleLabel.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 8, paddingRight: 8)
        titleLabel.centerY(inView: view)
        
        requestButton.centerX(inView: view)
        requestButton.anchor(top: titleLabel.bottomAnchor, paddingTop: 16)
        
    }
    
    override func setBind() {
        super.setBind()
        viewModel.completed = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.pushToDisplayVC(data: strongSelf.viewModel.dataArray)
            strongSelf.requestButton.isEnabled = true
        }
    }
    
    static func initViewController() -> UIViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withClass: MainViewController.self)!
        return vc
    }
    
}
extension MainViewController{
    @objc func didTapedRequestButton(){
        requestButton.isEnabled = false
        viewModel.fetch()
    }
    func pushToDisplayVC(data: [AstronomyItems]){
        navigator.show(destination: .display(data: data), sender: self)
    }
}

