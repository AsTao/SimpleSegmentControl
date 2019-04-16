//
//  SimpleSegmentControl.swift
//  Pods-SimpleSegmentControl_Example
//
//  Created by tobias on 2018/4/19.
//

import UIKit

public class SimpleSegmentControl: UIView {

    @objc public var segments :[String] = []
    @objc public var indexChangedHandler: ((_ index: Int) -> (Swift.Void))?
    
    @objc public var indicatorWidth :CGFloat = 0
    @objc public var indicatorHeight :CGFloat = 3
    @objc public var indicatorColor :UIColor = UIColor(red: 146/255.0, green: 59/255.0, blue: 1, alpha: 1)
    @objc public var indicatorBakcgroundColor :UIColor = UIColor(red: 223/255.0, green: 223/255.0, blue: 223/255.0, alpha: 1)
    
    @objc public var collectionSectionInset :UIEdgeInsets = UIEdgeInsets.zero
    

    @objc public var titleLabelFont :UIFont = UIFont.systemFont(ofSize: 13)
    @objc public var titleLabelColor :UIColor = UIColor(red: 102/255.0, green: 107/255.0, blue: 108/255.0, alpha: 1)
    @objc public var titleLabelHighlightedColor :UIColor = UIColor(red: 146/255.0, green: 59/255.0, blue: 1, alpha: 1)
    
    @objc public var selectedSegmentIndex :Int = 0 {
        didSet{
            self.indicatorOffsetX =  CGFloat(selectedSegmentIndex) * collectionItemWidth + (collectionItemWidth - indicatorWidth)/2
            self.segmentCollection.selectItem(at: IndexPath(item: selectedSegmentIndex, section: 0), animated: true, scrollPosition: .top)
            indexChangedHandler?(selectedSegmentIndex)
        }
    }
    
    @objc public var indicatorOffsetX :CGFloat = 0{
        didSet{
            let x = self.indicatorOffsetX + self.collectionSectionInset.left
            UIView.animate(withDuration: 0.25, animations: {
                self.indicator.frame = CGRect(x: x, y: self.collectionHeight, width: self.indicatorWidth, height: self.indicatorHeight)
            }, completion: { finish in
                let n = (self.indicatorOffsetX - (self.collectionItemWidth - self.indicatorWidth)/2)/self.collectionItemWidth
                self.segmentCollection.selectItem(at: IndexPath(item: Int(floor(n)), section: 0), animated: true, scrollPosition: .top)
            })
        }
    }
    
    @objc public func reloadSegments(){
        guard segments.count > 0 else {return}
        if indicatorWidth == 0 {
            let text = segments.first ?? ""
            let boundingBox = text.boundingRect(with: CGSize(width: 300, height: 20), options: .usesLineFragmentOrigin, attributes: [.font: titleLabelFont], context: nil)
            self.indicatorWidth = ceil(boundingBox.width)
        }
        self.indicator.backgroundColor = indicatorColor
        self.trackLine.backgroundColor = indicatorBakcgroundColor
        
        self.collectionItemWidth = (self.frame.width - collectionSectionInset.left - collectionSectionInset.right)/CGFloat(segments.count)
        self.indicatorOffsetX = (collectionItemWidth - indicatorWidth)/2
        self.segmentCollection.reloadData()
        self.segmentCollection.backgroundColor = self.backgroundColor
        self.segmentCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
    }
    
    fileprivate var collectionItemWidth :CGFloat = 0
    
    fileprivate var collectionHeight :CGFloat{
        return self.frame.height - indicatorHeight
    }
   
    // MARK: - Life Cycle
    public init() {
        super.init(frame: .zero)
        initUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    private func initUI(){
        self.addSubview(self.segmentCollection)
        self.addSubview(self.trackLine)
        self.addSubview(self.indicator)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.segmentCollection.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: collectionHeight)
        self.trackLine.frame = CGRect(x: 0, y: collectionHeight, width: self.frame.width, height: indicatorHeight)
      //  self.indicator.frame = CGRect(x: collectionSectionInset.left, y: collectionHeight, width: indicatorWidth, height: indicatorHeight)
    }
    
    private lazy var indicator :UIView = {
        let view = UIView(frame: CGRect.zero)
        view.isUserInteractionEnabled = false
        return view;
    }()
    
    private lazy var trackLine :UIView = {
        let view = UIView(frame: CGRect.zero)
        view.isUserInteractionEnabled = false
        return view;
    }()
    
    private lazy var segmentCollection :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.scrollsToTop = false
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(SimpSegmentCell.self, forCellWithReuseIdentifier: "SimpSegmentCell")
        return view;
    }()
    
}

extension SimpleSegmentControl :UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedSegmentIndex = indexPath.row
    }
}

extension SimpleSegmentControl :UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return segments.count
    }
 
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpSegmentCell", for: indexPath) as! SimpSegmentCell
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let acell = cell as! SimpSegmentCell
        acell.titleLabel.text = segments[indexPath.row]
        acell.titleLabel.font = titleLabelFont
        acell.titleLabel.textColor = titleLabelColor
        acell.titleLabel.highlightedTextColor = titleLabelHighlightedColor
        acell.backgroundColor = UIColor.red
    }
}

extension SimpleSegmentControl :UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionItemWidth, height: collectionView.frame.height)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return collectionSectionInset
    }
}

class SimpSegmentCell: UICollectionViewCell {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.titleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = self.bounds
    }

    public lazy var titleLabel :UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.isUserInteractionEnabled = false
        view.textAlignment = .center
        view.numberOfLines = 0
        return view;
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




