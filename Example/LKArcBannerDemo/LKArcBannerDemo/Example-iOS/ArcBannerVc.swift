//
//  ArcBannerVc.swift
//  Comic
//
//  Created by 李棒棒 on 2024/6/3.
//

import UIKit
import LKArcBanner

class ArcBannerVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.addSubview(arcBanner)
        view.addSubview(topArcBanner)
        view.addSubview(lowerArcBanner)
        view.addSubview(myArcBanner)
        
        arcBanner.snp.makeConstraints { make in
            make.top.equalTo(120.0)
            make.left.right.equalTo(0.0)
            make.height.equalTo(120.0)
        }
        
        topArcBanner.snp.makeConstraints { make in
            make.top.equalTo(arcBanner.snp.bottom).offset(16.0)
            make.left.right.equalTo(0.0)
            make.height.equalTo(120.0)
        }
        
        lowerArcBanner.snp.makeConstraints { make in
            make.top.equalTo(topArcBanner.snp.bottom).offset(16.0)
            make.left.right.equalTo(0.0)
            make.height.equalTo(120.0)
        }
        
        myArcBanner.snp.makeConstraints { make in
            make.top.equalTo(lowerArcBanner.snp.bottom).offset(16.0)
            make.left.right.equalTo(0.0)
            make.height.equalTo(120.0)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        myNavigationController?.navBarStyle(style: .autoWhite,animated:animated)
//        myNavigationController?.navTitleColor = .themeText_color
        
        navigationItem.title = "弧形轮播菜单"
    }
    
    
    lazy var arcBanner:LKArcBanner = {
        let banner = LKArcBanner()
        banner.backgroundColor = .LK.hex("#87CEFA")
        banner.itemSlideStyle = .smoothScaling
        //banner.delegate = self
        banner.isScrollLoop = true
        banner.dataSourceArr = [
            "https://img0.baidu.com/it/u=433375432,1706420025&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800",
            "https://img2.baidu.com/it/u=2615120794,4070707239&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400",
            "https://img0.baidu.com/it/u=2266791864,792280171&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=458",
            "https://img2.baidu.com/it/u=4080708188,1925632072&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://img1.baidu.com/it/u=902333013,1237256716&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"]
        return banner
    }()
    
    
    lazy var topArcBanner:LKArcBanner = {
        let banner = LKArcBanner()
        banner.backgroundColor = UIColor.LK.hex("#F2F2F2")
        banner.itemSlideStyle = .topChordArcScaling
        //banner.delegate = self
        banner.isScrollLoop = true
        banner.dataSourceArr = [
            "https://img2.baidu.com/it/u=2450820256,885567602&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://img2.baidu.com/it/u=1313287122,3642041988&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://img0.baidu.com/it/u=956359712,3045623931&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380",
            "https://img2.baidu.com/it/u=2612717694,2364849194&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380",
            "https://img1.baidu.com/it/u=2639090463,553901199&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"]
        return banner
    }()
    
    lazy var lowerArcBanner:LKArcBanner = {
        let banner = LKArcBanner()
        banner.backgroundColor = .LK.hex("#AFEEEE")
        banner.itemSlideStyle = .lowerChordArcScaling
        //banner.delegate = self
        banner.isScrollLoop = true
        banner.dataSourceArr = [
            "https://img2.baidu.com/it/u=1932232343,3478732518&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500",
            "https://img1.baidu.com/it/u=3904094238,2730939132&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://img1.baidu.com/it/u=1954851291,1342197195&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500",
            "https://img0.baidu.com/it/u=4087690236,108396132&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=400",
            "https://img2.baidu.com/it/u=400609548,1288160687&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800"]
        return banner
    }()
    
    
    lazy var myArcBanner:LKArcBanner = {
        
        let banner = LKArcBanner()
        banner.backgroundColor = .LK.hex("#FFA07A")
        banner.itemSlideStyle = .lowerChordArcScaling
        banner.delegate = self
        banner.isScrollLoop = true
        
        banner.dataSourceArr = [
            "https://img2.baidu.com/it/u=2450820256,885567602&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500",
            "https://img2.baidu.com/it/u=2294382127,356664496&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=501",
            "https://img0.baidu.com/it/u=956359712,3045623931&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380",
            "https://img2.baidu.com/it/u=2612717694,2364849194&fm=253&fmt=auto&app=138&f=JPEG?w=380&h=380",
            "https://img1.baidu.com/it/u=2639090463,553901199&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500"]
        
        return banner
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ArcBannerVc: LKArcBannerDelegate {
    
    func customCollectionViewCellNibForArcBanner(arcBanner: LKArcBanner, collectionView: UICollectionView) -> UINib? {
        
        return UINib(nibName: "WriterArcBannerCollCell", bundle: Bundle.main)
    }
    
    func setupCustomCell(cell: UICollectionViewCell, forIndex index: NSInteger, arcBanner: LKArcBanner, collectionView:UICollectionView) {
        
        if let cell = cell as? WriterArcBannerCollCell {
            
            cell.layer.cornerRadius = (arcBanner.bannerItemSize.height / 2.0)
            cell.clipsToBounds = true
            cell.content_view.backgroundColor = .yellow
            cell.title_lab.font = UIFont.systemFont(ofSize: 18.0)
            cell.title_lab.text = "自定义(\(index))"
        }
    }
    
    func lkArcBanner(_ arcBanner: LKArcBanner, flowLayout: LKArcCollectionViewFlowLayout, collectionView: UICollectionView?, itemScale: CGFloat, itemAttributes: UICollectionViewLayoutAttributes, indexPath: IndexPath) {
    
        if let cell:WriterArcBannerCollCell = collectionView?.cellForItem(at: indexPath) as? WriterArcBannerCollCell {
        
            var scale = abs(itemScale)
            if itemScale < 0.0 {//缩小
                scale = 1.0 + itemScale
            }
            
            if scale > 0.88 {
                cell.content_view.backgroundColor = UIColor.cyan
                cell.title_lab.textColor = UIColor.white
            } else {
                cell.content_view.backgroundColor = UIColor.yellow
                cell.title_lab.textColor = UIColor.black
            }
            
        }
    }
    
    func lkArcBanner(_ arcBanner: LKArcBanner, collectionView: UICollectionView, didSelectItemAt index: Int, indexPath: IndexPath, itemModel: Any?) {
        
        if let cell:WriterArcBannerCollCell = collectionView.cellForItem(at: indexPath) as? WriterArcBannerCollCell {
            
            cell.content_view.backgroundColor = UIColor.cyan
            cell.title_lab.textColor = UIColor.white
            
        }
    }
    
}
