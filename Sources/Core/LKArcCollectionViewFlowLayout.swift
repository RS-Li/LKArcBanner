//
//  LKArcCollectionViewFlowLayout.swift
//  ZGWAIAgentSystem
//
//  Created by 李棒棒 on 2024/5/27.
//

import UIKit

public protocol LKArcCollectionViewFlowLayoutDelegate: NSObjectProtocol {
    func lkArcCollectionViewFlowLayout(_ flowLayout:LKArcCollectionViewFlowLayout,collectionView:UICollectionView?,itemScale:CGFloat,itemAttributes:UICollectionViewLayoutAttributes,indexPath:IndexPath)
}

extension LKArcCollectionViewFlowLayoutDelegate where Self:LKArcCollectionViewFlowLayout {
  func lkarcCollectionViewFlowLayout(_ flowLayout:LKArcCollectionViewFlowLayout,collectionView:UICollectionView?,itemScale:CGFloat,itemAttributes:UICollectionViewLayoutAttributes,indexPath:IndexPath) {}
}

public enum LKArcCollectionViewFlowLayoutSlideStyle {
    
    ///上弦弧缩放
    case topChordArcScaling
    ///下弦弧缩放
    case lowerChordArcScaling
    ///水平缩放
    case smoothScaling
    
    case `default`
}

open class LKArcCollectionViewFlowLayout: UICollectionViewFlowLayout {

    weak var arcDelegate:LKArcCollectionViewFlowLayoutDelegate?

    var slideStyle:LKArcCollectionViewFlowLayoutSlideStyle = .lowerChordArcScaling
    
    open override func prepare() {
        super.prepare()
        
        // 设置水平滚动
        self.scrollDirection = .horizontal
        
//        let inset = (self.collectionView?.frame.size.width - self.itemSize.width) * 0.5
//        self.sectionInset = UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
        
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let attributesArr:[UICollectionViewLayoutAttributes]? = NSArray.init(array: super.layoutAttributesForElements(in: rect) ?? [], copyItems: true) as? [UICollectionViewLayoutAttributes]
        
        // collectionView 中心点
        let centerX = (self.collectionView?.contentOffset.x ?? 0.0) + (self.collectionView?.frame.size.width ?? 0.0) * 0.5
        
        var itemCenterY = (self.collectionView?.frame.size.height ?? 0.0) / 2.0;
        
        if let attributesArr = attributesArr {
            
            for (_,attrs) in attributesArr.enumerated() {
                
                switch slideStyle {
                    
                case .topChordArcScaling, .lowerChordArcScaling , .smoothScaling:

                    // item中心点x 和 collectionView最中心点的x值 的间距
                    let delta = abs(attrs.center.x - centerX)
                    // 根据间距值计算item的缩放比例
                    let scale:CGFloat = 1.0 - delta / (self.collectionView?.frame.size.width ?? 0.0)
                    //print("计算出的缩放比例：\(scale) - 位置：\(index) - indexPath：\(attrs.indexPath)")
                    
                    if slideStyle == .topChordArcScaling { //上弦弧
                        
                        itemCenterY = attrs.center.y - scale * (attrs.frame.size.height) + (attrs.frame.size.height/2.0) + self.minimumInteritemSpacing
                        attrs.center = CGPoint(x: attrs.center.x, y: itemCenterY);
                        
                    } else if slideStyle == .lowerChordArcScaling { //下弦弧
                        
                        itemCenterY = attrs.center.y + scale * (attrs.frame.size.height) - (attrs.frame.size.height/2.0) - self.minimumInteritemSpacing
                        attrs.center = CGPoint(x: attrs.center.x, y: itemCenterY);
                        
                    }
                    
                    // 设置缩放比例
                    attrs.transform = CGAffineTransformMakeScale(scale, scale);
                    
                    arcDelegate?.lkArcCollectionViewFlowLayout(self, collectionView:self.collectionView,itemScale: scale, itemAttributes: attrs, indexPath: attrs.indexPath)
                    
                case .default:
                    
                    arcDelegate?.lkArcCollectionViewFlowLayout(self, collectionView:self.collectionView,itemScale: 1.0, itemAttributes: attrs, indexPath: attrs.indexPath)
                    
                }
            }
        }
        
        return  attributesArr
    }
    
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var temp_proposedContentOffset = proposedContentOffset
        
        let rect:CGRect = CGRect(x: temp_proposedContentOffset.x,
                                 y: 0.0,
                                 width: (self.collectionView?.frame.size.width ?? 0.0),
                                 height: (self.collectionView?.frame.size.height ?? 0.0))
        
        let attributesArr:[UICollectionViewLayoutAttributes]? = NSArray.init(array: super.layoutAttributesForElements(in: rect) ?? [], copyItems: true) as? [UICollectionViewLayoutAttributes]
        
        let  centerX = temp_proposedContentOffset.x + (self.collectionView?.frame.size.width ?? 0.0) * 0.5;
        
        var minDelta:CGFloat = CGFloat(MAXFLOAT)
        if let attributesArr = attributesArr {
            for (_,attri) in attributesArr.enumerated() {
                if abs(minDelta) > abs(attri.center.x - centerX) {
                    minDelta = attri.center.x - centerX
                }
            }
        }
        
        temp_proposedContentOffset.x = temp_proposedContentOffset.x + minDelta
        
        return temp_proposedContentOffset
    }
    
    
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
