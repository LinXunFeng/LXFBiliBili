//
//  LXFHomeLiveTopHeader.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReusableKit
import TYCyclePagerView
import Then
import Kingfisher

fileprivate enum Reusable {
    static let categoryCell = ReusableCell<LXFLiveTopCategoryCell>(nibName: "LXFLiveTopCategoryCell")
}


class LXFHomeLiveTopHeader: UICollectionReusableView {
    
    var header: LXFHomeLiveHeader!
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var categoryView: UICollectionView!
    @IBOutlet private weak var headerView: UIView!
    
    var bannerArr = Variable<[String]>([])
    
    private var dataSource : RxCollectionViewSectionedReloadDataSource<LXFMenuSection>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
        bindUI()
    }
    
}

extension LXFHomeLiveTopHeader {
    private func bindUI() {
        dataSource = RxCollectionViewSectionedReloadDataSource<LXFMenuSection>(configureCell: { (ds, cv, indexPath, item) in
            let cell = cv.dequeue(Reusable.categoryCell, for: indexPath)
            cell.iconView.image = UIImage(named: item.imageName)
            cell.titleLabel.text = item.title
            return cell
        }, configureSupplementaryView: {(ds, cv, kind, indexPath) in
            return UICollectionReusableView()
        })
        
        let sections = [
            LXFMenuSection(items: [
                LXFMenuModel(imageName: "live_home_follow_anchor", title: "关注"),
                LXFMenuModel(imageName: "ic_live_home_entertainment", title: "娱乐"),
                LXFMenuModel(imageName: "ic_live_home_game", title: "游戏"),
                LXFMenuModel(imageName: "ic_live_home_mobile_game", title: "手游"),
                LXFMenuModel(imageName: "ic_live_home_painting", title: "绘画")
                ])
        ]
        Observable.just(sections).bind(to: categoryView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
    }
    
    private func initUI() {
        // 常规headerView
        let header = LXFHomeLiveHeader.loadFromNib()
        self.header = header
        headerView.addSubview(header)
        header.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // collectionView
        categoryView.register(Reusable.categoryCell)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kScreenW / 5, height: 60)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        categoryView.collectionViewLayout = layout
        
        // 轮播
        let banner = LXFBannerView()
        bannerView.addSubview(banner)
        banner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 刷新轮播图
        bannerArr.asObservable().subscribe(onNext: { (banners) in
            banner.bannerArr.value = banners
        }).disposed(by: rx.disposeBag)
    }
    
}

extension LXFHomeLiveTopHeader: LXFViewHeightProtocol {
    static func viewHeight() -> CGFloat {
        return 220 + LXFHomeLiveHeader.viewHeight()
    }
}
