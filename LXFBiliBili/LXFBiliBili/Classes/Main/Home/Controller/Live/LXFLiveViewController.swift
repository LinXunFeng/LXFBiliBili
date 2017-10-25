//
//  LXFLiveViewController.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/21.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxAlamofire
import SwiftyJSON
import ReusableKit
import MJRefresh

class LXFLiveViewController: UIViewController, Refreshable {
    
    var refreshHeader: MJRefreshHeader!
    
    // viewModel
    private var viewModel = LXFLiveViewModel()
    private var vmOutput: LXFLiveViewModel.LXFLiveOutput?

    // View
    private var liveCollectionView: UICollectionView!
    
    var dataSource : RxCollectionViewSectionedReloadDataSource<LXFLiveSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
        
        refreshHeader.beginRefreshing()
        
        liveCollectionView.rx.modelSelected(LXFLiveModel.self).subscribe(onNext: { (model) in
            let vc = LXFPlayViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

extension LXFLiveViewController {
    private func bindUI() {
        dataSource = RxCollectionViewSectionedReloadDataSource<LXFLiveSection>(configureCell: {(ds, cv, indexPath, item) in
            let cell = cv.dequeue(Reusable.homeLiveCell, for: indexPath)
            if indexPath.section < 2 {
                cell.iconView.kf.setImage(with: URL(string: item.cover?.src ?? ""))
                cell.areaLabel.text = item.area_v2_name
            } else {
                cell.iconView.kf.setImage(with: URL(string: item.user_cover))
                cell.areaLabel.text = item.area_name
            }
            cell.titleLabel.text = item.title
            cell.onlineLabel.text = "\(item.online)"
            return cell
        }, configureSupplementaryView: { (ds, cv, kind, indexPath) in
            /* =============================== header ============================= */
            
            if kind == UICollectionElementKindSectionHeader {
                let dsSection = ds[indexPath.section]
                if indexPath.section == 0 {
                    let topBannerView = cv.dequeue(Reusable.homeLiveTopHeader, kind: .header, for: indexPath)
                    let bannerArr = dsSection.banner?.map({ (model) -> String in
                        return model.img
                    }) ?? []
                    topBannerView.bannerArr.value = bannerArr
                    topBannerView.header.iconView.kf.setImage(with: URL(string: dsSection.normalHeader?.sub_icon?.src ?? ""))
                    topBannerView.header.titleLabel.text = dsSection.normalHeader?.name ?? ""
                    topBannerView.header.setliveCount(dsSection.normalHeader?.count ?? 0)
                    return topBannerView
                } else if indexPath.section == 1 {
                    let bannerDataHeader = cv.dequeue(Reusable.homeLiveBannerDataHeader, kind: .header, for: indexPath)
                    let bannerData = dsSection.BannerDataHeader
                    bannerDataHeader.iconView.kf.setImage(with: URL(string: bannerData?.cover?.src ?? ""))
                    bannerDataHeader.titleLabel.text = bannerData?.title
                    return bannerDataHeader
                }
                let headerView = cv.dequeue(Reusable.homeLiveHeader, kind: .header, for: indexPath)
                headerView.iconView.kf.setImage(with: URL(string: dsSection.normalHeader?.sub_icon?.src ?? ""))
                headerView.titleLabel.text = dsSection.normalHeader?.name
                headerView.setliveCount(dsSection.normalHeader?.count ?? 0)
                return headerView
            }
            
            /* =============================== footer ============================= */
            
            if indexPath.section == 5 {
                return cv.dequeue(Reusable.homeLiveBottomFooter, kind: .footer, for: indexPath)
            }
            return cv.dequeue(Reusable.homeLiveFooter, kind: .footer, for: indexPath)
        })
        
        // viewModel
        vmOutput = viewModel.transform(input: LXFLiveViewModel.LXFLiveInput())
        // 订阅cell的数据
        vmOutput?.sections.asDriver().drive(liveCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        refreshHeader = initRefreshHeader(liveCollectionView) { [weak self] in
            self?.vmOutput?.requestCommand.onNext(())
        }
        vmOutput?.autoSetRefreshHeaderStatus(header: refreshHeader, footer: nil).disposed(by: rx.disposeBag)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension LXFLiveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 0
        if section == 0 {
            height = LXFHomeLiveTopHeader.viewHeight()
        } else if section == 1{
            height = LXFHomeLiveBannerDataHeader.viewHeight()
        } else {
            height = LXFHomeLiveHeader.viewHeight()
        }
        return CGSize(width: kScreenW, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }
        var height: CGFloat = 0
        height = section == 5 ? LXFHomeLiveBottomFooter.viewHeight() : LXFHomeLiveFooter.viewHeight()
        return CGSize(width: kScreenW, height: height)
    }
}

// MARK:- 没必要关心的
extension LXFLiveViewController {
    private func initUI() {
        self.view.backgroundColor = kThemeBackgroundColor
        // 裁剪上方左右的圆角
        let direction = UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue
        self.view.clipRectCorner(direction: UIRectCorner(rawValue: direction), cornerRadius: 5)
        
        // collectionView
        let layout = LXFFlowLayout()
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: view.height - kTabbarH)
        let liveCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.liveCollectionView = liveCollectionView
        liveCollectionView.backgroundColor = kThemeBackgroundColor
        liveCollectionView.showsVerticalScrollIndicator = false
        view.addSubview(liveCollectionView)
        // 布局
        liveCollectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kTabbarH)
        }
        // 设置代理
        liveCollectionView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        
        // 注册cell
        liveCollectionView.register(Reusable.homeLiveCell)
        liveCollectionView.register(Reusable.homeLiveHeader, kind: SupplementaryViewKind.header)
        liveCollectionView.register(Reusable.homeLiveTopHeader, kind: SupplementaryViewKind.header)
        liveCollectionView.register(Reusable.homeLiveBannerDataHeader, kind: SupplementaryViewKind.header)
        liveCollectionView.register(Reusable.homeLiveFooter, kind: SupplementaryViewKind.footer)
        liveCollectionView.register(Reusable.homeLiveBottomFooter, kind: SupplementaryViewKind.footer)
    }
}

private enum Reusable {
    static let homeLiveTopHeader = ReusableView<LXFHomeLiveTopHeader>(identifier: "LXFHomeLiveTopHeader", nibName: "LXFHomeLiveTopHeader")
    static let homeLiveBannerDataHeader = ReusableView<LXFHomeLiveBannerDataHeader>(identifier: "LXFHomeLiveBannerDataHeader", nibName: "LXFHomeLiveBannerDataHeader")
    static let homeLiveHeader = ReusableView<LXFHomeLiveHeader>(identifier: "LXFHomeLiveHeader", nibName: "LXFHomeLiveHeader")
    static let homeLiveFooter = ReusableView<LXFHomeLiveFooter>(identifier: "LXFHomeLiveFooter", nibName: "LXFHomeLiveFooter")
    static let homeLiveBottomFooter = ReusableView<LXFHomeLiveBottomFooter>(identifier: "LXFHomeLiveBottomFooter", nibName: "LXFHomeLiveBottomFooter")
    static let homeLiveCell = ReusableCell<LXFHomeLiveCell>(nibName: "LXFHomeLiveCell")
}
