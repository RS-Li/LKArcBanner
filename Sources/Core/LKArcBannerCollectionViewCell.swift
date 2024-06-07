//
//  LKArcBannerCollectionViewCell.swift
//  ZGWAIAgentSystem
//
//  Created by 李棒棒 on 2024/5/27.
//

import UIKit
import SnapKit

class LKArcBannerCollectionViewCell: UICollectionViewCell {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentImgView)
        addSubview(indexLab)
        
        contentImgView.snp.makeConstraints { make in
            
//            make.edges.equalTo(0.0)
            
            make.left.equalTo(5.0)
            make.top.equalTo(5.0)
            make.right.equalTo(-5.0)
            make.bottom.equalTo(-5.0)
        }
        
        indexLab.snp.makeConstraints { make in
            make.left.right.equalTo(0.0)
            make.center.equalToSuperview()
        }
        
        self.bringSubviewToFront(contentImgView)
        self.bringSubviewToFront(indexLab)
        
        layer.borderWidth = 5.0
        layer.cornerRadius = self.frame.size.height / 2.0
        
        contentImgView.layer.borderWidth = 7.0
        contentImgView.layer.cornerRadius = (self.frame.size.height - 10.0)/2.0
        
        layer.borderColor = UIColor.clear.cgColor
        contentImgView.layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentImgView = {
        let imgV = UIImageView()
        imgV.backgroundColor = UIColor.lightGray
        imgV.contentMode = .scaleAspectFill
        imgV.layer.borderWidth = 7.0
        return imgV
    }()
    
    lazy var indexLab:UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        lab.textAlignment = .center
        lab.textColor = .red
        lab.adjustsFontSizeToFitWidth = true
        return lab
    }()
}

extension LKArcBannerCollectionViewCell {
    
    func setRoundborder(_ alpha:CGFloat) {
        
        if alpha == 1.0 {
            layer.borderColor = UIColor.LK.hex("#FFFFFF", alpha: 0.8).cgColor
            contentImgView.layer.borderColor = UIColor.LK.hex("#FF7100", alpha: 0.9).cgColor
        } else {
            layer.borderColor = UIColor.clear.cgColor
            contentImgView.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func configurationCellFrom(_ cellData: Any?,atIndexPath:IndexPath) {
        if let cellData = cellData as? String {
            if cellData.hasPrefix("https://") || cellData.hasPrefix("http://") {
                if let imgUrl = cellData.asURL() {
                    
                    LKTools.downloadImage(from: imgUrl) { [weak self] image in
                        // 回主线程
                        DispatchQueue.main.async {
                            self?.contentImgView.image = image
                        }
                    }
                }
            }
        }
    }
}



extension String {
    fileprivate func asURL() -> URL? {
        guard let url = URL(string: self) else { return nil}
        return url
    }
}
