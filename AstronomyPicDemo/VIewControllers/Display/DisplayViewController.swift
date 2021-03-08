//
//  DisplayViewController.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import UIKit

class DisplayViewController: BaseViewController {
    
    fileprivate let viewModel = DisplayViewModel()
    
    lazy var collectionView = UICollectionView()
    var layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setBind()
        viewModel.clipDataArrayToDisplay()
    }
    
    override func setUpUI() {
        super.setUpUI()
        
        self.view.backgroundColor = .white
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 4) - 4, height: (UIScreen.main.bounds.width / 4))
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundView?.isHidden = true
        collectionView.register(DisplayCollectionViewCell.self, forCellWithReuseIdentifier: "DisplayCollectionViewCell")
        self.view.addSubview(collectionView)
        
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    override func setBind() {
        super.setBind()
        viewModel.completed = { [weak self] in
            guard let strongSelf = self else {return}
            print("CollectionView need reload")
            strongSelf.collectionView.reload {}
        }
    }
    
    static func initViewController(data: [AstronomyItems]) -> UIViewController{
        let vc = DisplayViewController()
        vc.viewModel.dataArray = data
        return vc
    }
}
extension DisplayViewController{
    func pushToDetail(data: AstronomyItems){
        navigator.show(destination: .deatil(data: data), sender: self)
    }
}
extension DisplayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.disPlayDataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisplayCollectionViewCell", for: indexPath) as! DisplayCollectionViewCell
        cell.config(data: viewModel.disPlayDataArray[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushToDetail(data: viewModel.disPlayDataArray[indexPath.item])
    }
}
//MARK: UIScrollViewmdelegate
extension DisplayViewController: UIScrollViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView.contentSize.height > collectionView.frame.height else {return}
        if scrollView.contentSize.height - (scrollView.frame.size.height + scrollView.contentOffset.y) <= -10 {
            print("Pull up to load more")
            viewModel.clipDataArrayToDisplay()
        }
    }
}
