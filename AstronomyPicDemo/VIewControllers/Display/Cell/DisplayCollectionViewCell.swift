//
//  DisplayCollectionViewCell.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import UIKit

class DisplayCollectionViewCell: UICollectionViewCell {
    let photoImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "--"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
    super.init(frame: frame)
        setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
extension DisplayCollectionViewCell{
    func setUpUI(){
        
        self.backgroundColor = .white
        self.contentView.backgroundColor = .white
        
        contentView.addSubview(photoImageView)
        photoImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        photoImageView.addSubview(label)
        label.anchor(top: photoImageView.topAnchor, left: photoImageView.leftAnchor, bottom: photoImageView.bottomAnchor, right: photoImageView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
    }
    func config(data: AstronomyItems){
        label.text = data.title
        photoImageView.loadImage(urlString: data.url, size: CGSize(width: contentView.frame.width, height: contentView.frame.height))
    }
}
