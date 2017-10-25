//
//  LXFRecommendController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/24.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources
import ReusableKit
import MJRefresh
import Timepiece

class LXFRecommendController: UIViewController, Refreshable {
    
    // viewModel
    private var viewModel = LXFRecommendViewModel()
    private var vmOutput: LXFRecommendViewModel.LXFRecommendOutput?
    
    // View
    private var recommendCollectionView: UICollectionView!
    private var refreshHeader: MJRefreshHeader?
    
    var dataSource : RxCollectionViewSectionedReloadDataSource<LXFRecommendSection>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
        
        refreshHeader?.beginRefreshing()
    }
}

extension LXFRecommendController {
    private func bindUI() {
        dataSource = RxCollectionViewSectionedReloadDataSource<LXFRecommendSection>(configureCell: { (ds, cv, ip, item) in
            var isAd = false
            var cell: UICollectionViewCell!
            // ["login", "ad_web_s", "av", "article_s", "bangumi"]
            if item.goto! == "login" {
                cell = cv.dequeue(Reusable.homeRecLoginCell, for: ip)
            } else if item.goto! == "ad_web_s" {
                isAd = true
                cell = cv.dequeue(Reusable.homeRecAdCell, for: ip)
            } else if item.goto! == "av" {
                if item.rcmd_reason != nil {
                    cell = cv.dequeue(Reusable.homeRecRecommendCell, for: ip)
                } else {
                    cell = cv.dequeue(Reusable.homeRecBangumiCell, for: ip)
                }
            } else if item.goto! == "article_s" {
                cell = cv.dequeue(Reusable.homeRecArticleCell, for: ip)
            } else if item.goto! == "bangumi" {
                cell = cv.dequeue(Reusable.homeRecBangumiCell, for: ip)
            }
            
            let baseView = (cell as! LXFHomeRecBaseCellable).baseView
            let date = Date(timeIntervalSinceNow: TimeInterval(item.ctime))
            baseView?.timeLabel.text = String(format: "%02d:%02d", date.hour, date.minute)
            baseView?.iconView.kf.setImage(with: URL(string: item.cover ?? ""))
            baseView?.playCountLabel.text = "\(item.play)"
            baseView?.danmukuCountLabel.text = "\(item.danmaku)"
            baseView?.titleLabel.text = item.title
            
            baseView?.timeLabel.isHidden = isAd
            baseView?.danmukuCountLabel.isHidden = isAd
            baseView?.playCountLabel.isHidden = isAd
            baseView?.playIconView.isHidden = isAd
            baseView?.danmukuIconView.isHidden = isAd
            
            return cell
        }, configureSupplementaryView: { (ds, cv, kind, ip) in
            // return cv.dequeue(Reusable.homeRecBannerHeader, kind: kind, for: ip)
            guard let header = ds[ip.section].header, let goto = header.goto, kind != UICollectionElementKindSectionFooter else {
                return cv.dequeue(Reusable.homeRecBannerHeader, kind: kind, for: ip)
            }
            // ["topic", "special", "banner", "converge", "rank", "tag"]
            if goto == "banner" {    // 轮播
                let banner = cv.dequeue(Reusable.homeRecBannerHeader, kind: kind, for: ip)
                let bannerImgs = header.banner_item?.map({ (item) -> String in
                    return item.image ?? ""
                }) ?? []
                 banner.bannerArr.value = bannerImgs
                return banner
            } else { // 话题 小视频
                let normalHeader = cv.dequeue(Reusable.homeRecNormalHeader, kind: kind, for: ip)
                normalHeader.iconView.kf.setImage(with: URL(string: header.cover ?? ""))
                return normalHeader
            }
        })
        
        vmOutput = viewModel.transform(input: LXFRecommendViewModel.LXFRecommendInput())
        
        vmOutput?.sections.drive(recommendCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        refreshHeader = initRefreshHeader(recommendCollectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(true)
        }
        let refreshFooter = initRefreshFooter(recommendCollectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(false)
        }
        
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: refreshFooter).disposed(by: rx.disposeBag)
    }
}

extension LXFRecommendController {
    private func initUI() {
        self.view.backgroundColor = kThemeBackgroundColor
        
        // topView
        let topView = LXFRecommendTopView.loadFromNib()
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(LXFRecommendTopView.viewHeight())
        }
        
        // collectionView
        let recommendCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: LXFFlowLayout())
        self.recommendCollectionView = recommendCollectionView
        recommendCollectionView.backgroundColor = kThemeBackgroundColor
        recommendCollectionView.showsVerticalScrollIndicator = false
        view.addSubview(recommendCollectionView)
        // 布局
        recommendCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabbarH)
        }
        // 设置代理
        recommendCollectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // 注册
        // cell
        recommendCollectionView.register(Reusable.homeRecAdCell)
        recommendCollectionView.register(Reusable.homeRecNormalCell)
        recommendCollectionView.register(Reusable.homeRecRecommendCell)
        recommendCollectionView.register(Reusable.homeRecArticleCell)
        recommendCollectionView.register(Reusable.homeRecBangumiCell)
        recommendCollectionView.register(Reusable.homeRecLoginCell)
        // header
        recommendCollectionView.register(Reusable.homeRecNormalHeader, kind: SupplementaryViewKind.header)
        recommendCollectionView.register(Reusable.homeRecBannerHeader, kind: SupplementaryViewKind.header)
        
    }
}

extension LXFRecommendController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let header = dataSource[section].header, let goto = header.goto else {
            return CGSize.zero
        }
        let height = goto == "banner" ? LXFHomeRecBannerHeader.viewHeight() : LXFHomeRecNormalHeader.viewHeight()
        return CGSize(width: kScreenW, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

private enum Reusable {
    // cell
    static let homeRecAdCell = ReusableCell<LXFHomeRecAdCell>()
    static let homeRecNormalCell = ReusableCell<LXFHomeRecNormalCell>()
    static let homeRecRecommendCell = ReusableCell<LXFHomeRecRecommendCell>()
    static let homeRecArticleCell = ReusableCell<LXFHomeRecArticleCell>()
    static let homeRecBangumiCell = ReusableCell<LXFHomeRecBangumiCell>()
    static let homeRecLoginCell = ReusableCell<LXFHomeRecLoginCell>(nibName: "LXFHomeRecLoginCell")
    
    // header
    static let homeRecNormalHeader = ReusableView<LXFHomeRecNormalHeader>(identifier: "LXFHomeRecNormalHeader", nibName: "LXFHomeRecNormalHeader")
    static let homeRecBannerHeader = ReusableView<LXFHomeRecBannerHeader>()
}
