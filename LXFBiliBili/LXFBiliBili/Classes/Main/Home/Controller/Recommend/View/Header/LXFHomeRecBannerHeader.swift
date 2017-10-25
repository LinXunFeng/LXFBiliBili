//
//  LXFHomeRecBannerHeader.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/25.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift

class LXFHomeRecBannerHeader: UICollectionReusableView, LXFViewHeightProtocol {
    
    private let adLabel = UILabel().then {
        $0.text = "广告"
        $0.backgroundColor = UIColor.hexColor(0xCCCCCC)
        $0.textAlignment = .center
        $0.textColor = UIColor.white
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    var bannerArr = Variable<[String]>([])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func viewHeight() -> CGFloat {
        return 120
    }
}

extension LXFHomeRecBannerHeader {
    private func initUI() {
        // bgView
        let bgView = UIView()
        self.addSubview(bgView)
        bgView.layer.cornerRadius = 5
        bgView.layer.masksToBounds = true
//        let direction = UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue
//        bgView.clipRectCorner(direction: UIRectCorner(rawValue: direction), cornerRadius: 2)
        bgView.backgroundColor = kThemePinkColor
        bgView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
        }
        
        // 轮播
        let banner = LXFBannerView()
        bgView.addSubview(banner)
        banner.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 刷新轮播图
        bannerArr.asObservable().subscribe(onNext: { (banners) in
            banner.bannerArr.value = banners
        }).disposed(by: rx.disposeBag)
        
        // 广告
        banner.addSubview(adLabel)
        adLabel.snp.makeConstraints { (make) in
            make.width.equalTo(29)
            make.height.equalTo(18)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-2)
        }
    }
}
