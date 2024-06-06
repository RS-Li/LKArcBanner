// The Swift Programming Language
// https://docs.swift.org/swift-book


import UIKit

@objc
public protocol LKArcBannerDelegate: NSObjectProtocol {
    
    // 轮播自定义cell
    /** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
    @objc optional func customCollectionViewCellClassForArcBanner(arcBanner:LKArcBanner,collectionView: UICollectionView) -> AnyClass?
    /** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的Nib。 */
    @objc optional func customCollectionViewCellNibForArcBanner(arcBanner:LKArcBanner,collectionView: UICollectionView) -> UINib?
    
    /** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
    @objc optional func setupCustomCell(cell:UICollectionViewCell, forIndex index:NSInteger, arcBanner: LKArcBanner,collectionView: UICollectionView)
    
    
    @objc optional func lkArcBanner(_ arcBanner:LKArcBanner,collectionView: UICollectionView, didSelectItemAt index:Int, indexPath: IndexPath,itemModel:Any?)
    
    @objc optional func lkArcBanner(_ arcBanner:LKArcBanner, flowLayout: LKArcCollectionViewFlowLayout, collectionView: UICollectionView?, itemScale: CGFloat, itemAttributes: UICollectionViewLayoutAttributes, indexPath: IndexPath)
}

extension LKArcBannerDelegate where Self:LKArcBanner {
   
    func customcollectionViewCellClassForArcBanner(arcBanner:LKArcBanner,collectionView: UICollectionView) -> AnyClass? {
        return nil
    }
    
    func customCollectionViewCellNibForArcBanner(arcBanner:LKArcBanner,collectionView: UICollectionView) -> UINib? {
        return nil
    }
    
    func lkArcBanner(_ arcBanner:LKArcBanner, didSelectItemAt index:Int, indexPath: IndexPath,itemModel:Any?){}
    
     
    func lkArcBanner(_ arcBanner:LKArcBanner, flowLayout: LKArcCollectionViewFlowLayout, collectionView: UICollectionView?, itemScale: CGFloat, itemAttributes: UICollectionViewLayoutAttributes, indexPath: IndexPath){}
}

open class LKArcBanner: UIView {
    
    fileprivate var totalItemsCount:Int = 0
    
    fileprivate let LKArcBannerCollectionViewCell_identifier = "LKArcBannerCollectionViewCell_identifier"
    
    fileprivate let LoopNum:Int = 100
    
    public weak var delegate:LKArcBannerDelegate? {
        
        didSet {
            
            if(delegate?.responds(to: Selector(("customCollectionViewCellClassForArcBanner")))) != nil ,
              (delegate?.customCollectionViewCellClassForArcBanner?(arcBanner: self, collectionView: collectionView)) != nil {
                
                collectionView.register(delegate?.customCollectionViewCellClassForArcBanner?(arcBanner: self, collectionView: collectionView), forCellWithReuseIdentifier: LKArcBannerCollectionViewCell_identifier)
                
            } else if (delegate?.responds(to: Selector(("customCollectionViewCellNibForArcBanner")))) != nil ,
                      (delegate?.customCollectionViewCellNibForArcBanner?(arcBanner: self, collectionView: collectionView)) != nil  {
                
                collectionView.register(delegate?.customCollectionViewCellNibForArcBanner?(arcBanner: self , collectionView: collectionView), forCellWithReuseIdentifier: LKArcBannerCollectionViewCell_identifier)
            }
        }
    }
    
    public var itemSlideStyle:LKArcCollectionViewFlowLayoutSlideStyle = .lowerChordArcScaling {
        didSet {
            flowLayout.slideStyle = itemSlideStyle
        }
    }
    
    public var isScrollLoop:Bool = true {
        didSet {
            if isScrollLoop {
                totalItemsCount = (dataSourceArr?.count ?? 0) * LoopNum
            } else {
                totalItemsCount = (dataSourceArr?.count ?? 0)
            }
            
            if dataSourceArr != nil {
                collectionView.reloadData()
            }
        }
    }
    
    public var bannerItemSize:CGSize = CGSize(width: 80.0, height: 80.0) {
        didSet {
            flowLayout.itemSize = bannerItemSize
            collectionView.reloadData()
        }
    }
    
    public var contentInsets:UIEdgeInsets = .zero {
        didSet {
            
            let c_width = bounds.size.width - max(contentInsets.left, 0.0) - max(contentInsets.right, 0.0)
            let c_height = bounds.size.height - max(contentInsets.top, 0.0) - max(contentInsets.bottom, 0.0)
            collectionView.frame = CGRectMake(contentInsets.left,contentInsets.top, c_width,c_height)
        }
        
    }
    
    public var dataSourceArr:[Any]? {
        didSet {
            if isScrollLoop {
                totalItemsCount = (dataSourceArr?.count ?? 0) * LoopNum
            } else {
                totalItemsCount = (dataSourceArr?.count ?? 0)
            }
            collectionView.reloadData()
            selectedItemIndex = 0
        }
    }
    
    public var selectedItemIndex:Int = 0 {
        didSet {
            if isScrollLoop {
                scrollToIndex((totalItemsCount + selectedItemIndex), animated: true)
            } else {
                scrollToIndex(selectedItemIndex, animated: true)
            }
        }
    }
    
    required convenience public init(frame: CGRect,bannerItemSize:CGSize = CGSize(width: 80.0, height: 80.0)) {
        self.init(frame: frame)
        self.bannerItemSize = bannerItemSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeSubViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let c_width = self.bounds.size.width - max(contentInsets.left, 0.0) - max(contentInsets.right, 0.0)
        let c_height = self.bounds.size.height - max(contentInsets.top, 0.0) - max(contentInsets.bottom, 0.0)
        collectionView.frame = CGRectMake(contentInsets.left,contentInsets.top, c_width,c_height)
    }
    
    func makeSubViews() {
        
        addSubview(collectionView)
        
        let c_width = self.bounds.size.width - max(contentInsets.left, 0.0) - max(contentInsets.right, 0.0)
        let c_height = self.bounds.size.height - max(contentInsets.top, 0.0) - max(contentInsets.bottom, 0.0)
        collectionView.frame = CGRectMake(contentInsets.left,contentInsets.top, c_width,c_height)
    }
    
    lazy var flowLayout:LKArcCollectionViewFlowLayout = {
        
        let flowLayout = LKArcCollectionViewFlowLayout();
        flowLayout.arcDelegate = self
        flowLayout.slideStyle = itemSlideStyle
        flowLayout.minimumLineSpacing = 8;//行间距
        flowLayout.minimumInteritemSpacing = 32;//item左右间距
        flowLayout.scrollDirection = .horizontal;
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = bannerItemSize
        
        return flowLayout
    }()
    
    lazy var collectionView:UICollectionView = {
        
        //LKHorizontalArcCollectionViewLayout *flowLayout = [[LKHorizontalArcCollectionViewLayout alloc] init];
        let cView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout);
        
        cView.backgroundColor = UIColor.clear
        cView.delegate = self
        cView.dataSource = self
        cView.keyboardDismissMode = .onDrag
        
        cView.isPagingEnabled = false
        cView.showsHorizontalScrollIndicator = false
        cView.showsVerticalScrollIndicator = false
        cView.alwaysBounceHorizontal = true
        //cView.alwaysBounceVertical = true
        
        cView.register(LKArcBannerCollectionViewCell.self, forCellWithReuseIdentifier: LKArcBannerCollectionViewCell_identifier)
        
        return cView
    }()
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension LKArcBanner {
    
    func configurationViewFrom(_ viewData: Any?,from:Any?){
        if let viewData = viewData,viewData is Array<Any> {
            self.dataSourceArr = viewData as? [Any]
        }
    }
    
}

extension LKArcBanner:LKArcCollectionViewFlowLayoutDelegate {
    
    public func lkArcCollectionViewFlowLayout(_ flowLayout: LKArcCollectionViewFlowLayout, collectionView: UICollectionView?, itemScale: CGFloat, itemAttributes: UICollectionViewLayoutAttributes, indexPath: IndexPath) {
    
        delegate?.lkArcBanner?(self, flowLayout: flowLayout, collectionView: collectionView, itemScale: itemScale, itemAttributes: itemAttributes, indexPath: indexPath)
        
        if let cell:LKArcBannerCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as? LKArcBannerCollectionViewCell {
            
            var scale = abs(itemScale)
            if itemScale < 0.0 {//缩小
                scale = 1.0 + itemScale
            }
            
            if scale > 0.88 {
                cell.setRoundborder(1.0)
            } else {
                cell.setRoundborder(0.0)
            }
        }
    }
}

extension LKArcBanner:UICollectionViewDelegate,
                      UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout,
                      UIScrollViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalItemsCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bannerItemSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemIndex = itemIndexWithCurrentCellIndex(indexPath.item);
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LKArcBannerCollectionViewCell_identifier, for: indexPath)
        
        if (delegate?.responds(to: Selector(("setupCustomCell")))) != nil ,
           (delegate?.responds(to: Selector(("customCollectionViewCellClassForArcBanner")))) != nil,
           (delegate?.customCollectionViewCellClassForArcBanner?(arcBanner: self, collectionView: collectionView)) != nil {
            
            delegate?.setupCustomCell?(cell: cell, forIndex: itemIndex, arcBanner: self,collectionView:collectionView)
            
            return cell;
            
        } else if (delegate?.responds(to: Selector(("setupCustomCell")))) != nil ,
                  (delegate?.responds(to: Selector(("customCollectionViewCellNibForArcBanner")))) != nil,
                  (delegate?.customCollectionViewCellNibForArcBanner?(arcBanner: self, collectionView: collectionView)) != nil {
            
            delegate?.setupCustomCell?(cell: cell, forIndex: itemIndex, arcBanner: self,collectionView:collectionView)
            
            return cell;
        }
        
        if let cell = cell as? LKArcBannerCollectionViewCell {
            
            cell.layer.cornerRadius = (flowLayout.itemSize.height / 2.0)
            cell.clipsToBounds = true
            cell.backgroundColor = .gray
            cell.indexLab.text = "\(itemIndex)"
            
            if let dataSourceArr = dataSourceArr , dataSourceArr.count > itemIndex {
                cell.configurationCellFrom(dataSourceArr[itemIndex], atIndexPath: indexPath)
            }
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let seItemIndex = itemIndexWithCurrentCellIndex(indexPath.item);
        print("当前选中的item：\(seItemIndex)")
        didSelectItemScrollToCenter(itemAt: indexPath)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if isScrollLoop {
            return .zero
        } else {
            return CGSize(width: collectionView.bounds.size.width/2.0 + bannerItemSize.width, height: collectionView.bounds.size.height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if isScrollLoop {
            return .zero
        } else {
            return CGSize(width: collectionView.bounds.size.width/2.0 + bannerItemSize.width, height: collectionView.bounds.size.height)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if kind == .header {
//
//        }
//    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetThreshold = 10.0;
        if scrollView.contentOffset.x <= offsetThreshold {
            // 滑动到顶部
            print("滑动到顶部");
            if self.totalItemsCount > 0 {
                var targetIndex = self.totalItemsCount/2;
                if isScrollLoop == false {
                    targetIndex = 0
                }
                collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
        let distanceFromBottom = scrollView.contentSize.width - scrollView.bounds.size.width - scrollView.contentOffset.x;
        
        if distanceFromBottom <= offsetThreshold {
            // 滑动到底部
            print("滑动到底部");
            if self.totalItemsCount > 0 {
                var targetIndex = self.totalItemsCount/2;
                if isScrollLoop == false {
                    targetIndex = self.totalItemsCount-1
                }
                collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
        
        // didSelectItemScrollToCenter(itemAt: IndexPath(item: currentIndex(), section: 0))
        
        
        //print("滚动位置：\(currentIndex()) - \(self.collectionView.contentOffset.x)");
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let myCurrentIndex:Int = Int(max(floor(scrollView.contentOffset.x / scrollView.bounds.size.width ), 0))
        scrollEnd(indexPath: IndexPath(item: myCurrentIndex, section: 0))
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let myCurrentIndex:Int = Int(max(floor(scrollView.contentOffset.x / scrollView.bounds.size.width ), 0))
        scrollEnd(indexPath: IndexPath(item: myCurrentIndex, section: 0))
    }
    
}


extension LKArcBanner {
    
    //根据Cell的index位置计算当前的item数据真实位置
    func itemIndexWithCurrentCellIndex(_ cellIndex:Int) -> Int {
        guard let dataSourceArr = dataSourceArr else {return 0}
        if isScrollLoop {
            return cellIndex % dataSourceArr.count
        } else {
            return cellIndex
        }
    }
    
    func currentIndex() -> Int {
        
        if (self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) {
            return 0;
        }
        
        var index = 0;
        if (self.flowLayout.scrollDirection == .horizontal) {
            
            index = Int((self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width);
            
        } else {
            index = Int((self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5) / self.flowLayout.itemSize.height);
        }
        return max(0, index);
    }
    
    // 让当前选中的item滚动到视觉正中心的位置
    func didSelectItemScrollToCenter(itemAt indexPath: IndexPath) {
        
        if isScrollLoop {
            
            let visibleCells = collectionView.visibleCells
            let sortedIndexPaths = visibleCells.compactMap { (cell) -> IndexPath? in
                return collectionView.indexPath(for: cell)
            }.sorted { (indexPath1, indexPath2) -> Bool in
                return indexPath1.section < indexPath2.section || (indexPath1.section == indexPath2.section && indexPath1.row < indexPath2.row)
            }
            
            if (sortedIndexPaths.count > 0) {
                let center = sortedIndexPaths.count / 2;
                let tmpCell = collectionView.cellForItem(at: indexPath)
                for i in 0..<sortedIndexPaths.count {
                    let cell = collectionView.cellForItem(at:sortedIndexPaths[i]);
                    if cell == tmpCell {
                        var nextIndexPath:IndexPath? = nil;
                        if (i>center || i<center) {
                            nextIndexPath = IndexPath(item: indexPath.row, section: 0)
                            if let nextIndexPath = nextIndexPath {
                                self.calcScrollToIndex(nextIndexPath.item)
                                collectionView.isUserInteractionEnabled = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                                    self?.collectionView.isUserInteractionEnabled = true
                                }
                            }
                        }
                        break;
                    }
                }
            }
            
        } else {
            scrollToIndex(indexPath.item, animated: true)
        }
    }
    
    func calcScrollToIndex(_ targetIndex:Int) {
        
//        collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: true)
//        return
        
        let itemIndex = itemIndexWithCurrentCellIndex(targetIndex)
        
        var currentOffsetX = self.collectionView.contentOffset.x - CGFloat(self.totalItemsCount) * self.collectionView.frame.size.width / 2.0;
        
        if currentOffsetX < 0 {
            
            if currentOffsetX >= -self.collectionView.frame.size.width{
            
                currentOffsetX = CGFloat(itemIndex) * self.collectionView.frame.size.width
                
            }else if currentOffsetX <= -(CGFloat((dataSourceArr?.count ?? 0)) * self.collectionView.frame.size.width) {
                
                collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: true)
            }else {
                
                currentOffsetX = CGFloat((dataSourceArr?.count ?? 0)) * self.collectionView.frame.size.width + currentOffsetX;
            }
        }
        
        if currentOffsetX >= CGFloat((dataSourceArr?.count ?? 0)) * self.collectionView.frame.size.width {
           
            collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    func scrollEnd(indexPath:IndexPath) {
        
        guard let dataSourceArr = dataSourceArr else {return}
        if collectionView.visibleCells.count == 0 {return}
        
        let centerPoint = CGPoint(x: CGRectGetMidX(self.collectionView.bounds),
                                  y: CGRectGetMidY(self.collectionView.bounds))
        
        let centerCellIndexPath = collectionView.indexPathForItem(at: centerPoint)
        let seCellIndexPath:IndexPath = centerCellIndexPath ?? indexPath
        let seItemIndex = itemIndexWithCurrentCellIndex(seCellIndexPath.item)
        
        print("滚动后当前选中的item：\(seItemIndex)")
        
        delegate?.lkArcBanner?(self, collectionView: collectionView, didSelectItemAt: seItemIndex, indexPath: seCellIndexPath, itemModel: dataSourceArr[seItemIndex])
    }
    
    func scrollToIndex(_ targetIndex:Int,animated:Bool) {
        
        var seCellIndexPath:IndexPath = IndexPath(item: targetIndex, section: 0)
        if targetIndex >= totalItemsCount {
            if isScrollLoop {
                seCellIndexPath = IndexPath(item: targetIndex/2, section: 0)
            } else {
                seCellIndexPath = IndexPath(item: (totalItemsCount-1), section: 0)
            }
        } else {
            seCellIndexPath = IndexPath(item: targetIndex, section: 0)
        }
        collectionView.scrollToItem(at: seCellIndexPath, at: .centeredHorizontally, animated: animated)
        
        let seItemIndex = itemIndexWithCurrentCellIndex(seCellIndexPath.item)
        
        delegate?.lkArcBanner?(self, collectionView: collectionView, didSelectItemAt: seItemIndex, indexPath: seCellIndexPath, itemModel: dataSourceArr?[seItemIndex])
        
        //设置选中状态效果
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if let cell = self?.collectionView.cellForItem(at: seCellIndexPath) as? LKArcBannerCollectionViewCell {
                cell.setRoundborder(1.0)
            }
        }
        
    }
}
