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

class LXFRecommendController: UIViewController {
    
    // viewModel
    private var viewModel = LXFRecommendViewModel()
    
    
    // View
    private var recommendCollectionView: UICollectionView!
    
    var dataSource : RxCollectionViewSectionedReloadDataSource<LXFRecommendSection>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindUI()
    }
}

extension LXFRecommendController {
    private func bindUI() {
        dataSource = RxCollectionViewSectionedReloadDataSource<LXFRecommendSection>(configureCell: { (ds, cv, ip, item) in
            let cell = cv.dequeue(Reusable.homeRecLoginCell, for: ip)
            return cell
        }, configureSupplementaryView: { (ds, cv, kind, ip) in
            return cv.dequeue(Reusable.homeLiveTopHeader, kind: kind, for: ip)
        })
        
        
        
        let output = viewModel.transform(input: LXFRecommendViewModel.LXFRecommendInput())
       
        output.sections.drive(recommendCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        output.requestCommand.onNext(())
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
        recommendCollectionView.register(Reusable.homeRecAdCell)
        recommendCollectionView.register(Reusable.homeRecNormalCell)
        recommendCollectionView.register(Reusable.homeRecRecommendCell)
        recommendCollectionView.register(Reusable.homeRecArticleCell)
        recommendCollectionView.register(Reusable.homeRecBangumiCell)
        recommendCollectionView.register(Reusable.homeRecLoginCell)
        
        recommendCollectionView.register(Reusable.homeLiveTopHeader, kind: SupplementaryViewKind.header)
        
    }
}

extension LXFRecommendController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return
         CGSize.zero
    }
}

private enum Reusable {
    static let homeRecAdCell = ReusableCell<LXFHomeRecAdCell>()
    static let homeRecNormalCell = ReusableCell<LXFHomeRecNormalCell>()
    static let homeRecRecommendCell = ReusableCell<LXFHomeRecRecommendCell>()
    static let homeRecArticleCell = ReusableCell<LXFHomeRecArticleCell>()
    static let homeRecBangumiCell = ReusableCell<LXFHomeRecBangumiCell>()
    static let homeRecLoginCell = ReusableCell<LXFHomeRecLoginCell>(nibName: "LXFHomeRecLoginCell")
    
    static let homeLiveTopHeader = ReusableView<LXFHomeLiveTopHeader>(identifier: "LXFHomeLiveTopHeader", nibName: "LXFHomeLiveTopHeader")
}
