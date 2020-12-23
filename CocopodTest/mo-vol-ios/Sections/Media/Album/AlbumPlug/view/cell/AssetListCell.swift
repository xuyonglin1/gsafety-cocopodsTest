//
//  AssetListCell.swift
//  
//
//  Created by Layne on 2020/5/4.
//  Copyright © 2020 Layne. All rights reserved.
//

import UIKit

class AssetListCell: UITableViewCell {
    var thumbnailView: UIImageView = UIImageView.init()
    var nameLabel: UILabel = UILabel.init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        //缩略图
        thumbnailView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        thumbnailView.contentMode = .scaleAspectFill
        self.addSubview(thumbnailView)
        //相册名 + 图片个数
        nameLabel.font = UIFont.systemFont(ofSize: 18.0)
        self.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(thumbnail: UIImage, collectionName: String, count: Int) {
        thumbnailView.frame = CGRect(x: 1, y: 0, width: frame.size.height, height: frame.size.height)
        thumbnailView.image = thumbnail
        nameLabel.text = collectionName + " (\(count))"
        nameLabel.sizeToFit()
        var frame = nameLabel.frame
        frame.origin.x = thumbnailView.frame.origin.x + thumbnailView.frame.size.width + 5
        frame.origin.y = (self.frame.size.height - frame.size.height) / 2.0
        nameLabel.frame = frame
    }
    
}
