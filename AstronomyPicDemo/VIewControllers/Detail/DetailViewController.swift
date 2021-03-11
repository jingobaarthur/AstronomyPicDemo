//
//  DetailViewController.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import UIKit

class DetailViewController: BaseViewController {
    
    fileprivate let viewModel = DetailViewModel()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.scrollsToTop = true
        scrollView.isDirectionalLockEnabled = true
        scrollView.bounces = true
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
        return scrollView
    }()
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        return imgView
    }()
    
    private let tLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let copyRightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let desLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBind()
        viewModel.trainsfromDate()
    }
    override func setUpUI() {
        super.setUpUI()
        self.view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(baseView)
        baseView.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingRight: 0)
        baseView.setWidth(width: UIScreen.main.bounds.width)
        baseView.centerX(inView: scrollView)
        
        
        baseView.addSubview(dateLabel)
        dateLabel.anchor(top: baseView.topAnchor, left: baseView.leftAnchor, right: baseView.rightAnchor, paddingTop: 16, paddingLeft: 8, paddingRight: 8)
        
        baseView.addSubview(imgView)
        imgView.setWidth(width: UIScreen.main.bounds.width - 16)
        imgView.setHeight(height: UIScreen.main.bounds.width - 16)
        imgView.centerX(inView: baseView)
        imgView.anchor(top: dateLabel.bottomAnchor, paddingTop: 8)
        
        baseView.addSubview(tLabel)
        tLabel.anchor(top: imgView.bottomAnchor, left: baseView.leftAnchor, right: baseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        
        baseView.addSubview(copyRightLabel)
        copyRightLabel.anchor(top: tLabel.bottomAnchor, left: baseView.leftAnchor, right: baseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        
        baseView.addSubview(desLabel)
        desLabel.anchor(top: copyRightLabel.bottomAnchor, left: baseView.leftAnchor, bottom: baseView.bottomAnchor, right: baseView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
    }
    override func setBind() {
        super.setBind()
        viewModel.completed = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.config()
        }
    }
    static func initViewController(data: AstronomyItems) -> UIViewController{
        let vc = DetailViewController()
        vc.viewModel.dateString = data.date
        vc.viewModel.hdUrl = data.hdurl
        vc.viewModel.title = data.title
        vc.viewModel.des = data.description
        vc.viewModel.copyRight = data.copyright
        return vc
    }
}
extension DetailViewController{
    func config(){
        DispatchQueue.main.async {
            self.dateLabel.text = self.viewModel.dateFormatterString
            self.tLabel.text = self.viewModel.title
            self.copyRightLabel.text = self.viewModel.copyRight
            self.desLabel.text = self.viewModel.des
            self.imgView.loadImage(urlString: self.viewModel.hdUrl, size: CGSize(width: self.imgView.frame.width, height: self.imgView.frame.height))
        }
    }
}
extension DetailViewController: UIScrollViewDelegate{
    
}
