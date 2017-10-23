//
//  LXFMenuView.swift
//  LXFBiliBili
//
//  Created by 林洵锋 on 2017/10/19.
//  Copyright © 2017年 LinXunFeng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import RxDataSources
import ReusableKit
import NSObject_Rx
import RxGesture

fileprivate enum Reusable {
    static let Cell = ReusableCell<LXFMenuViewCell>(nibName: "LXFMenuViewCell")
}

fileprivate let menuWidth: CGFloat = 280
fileprivate let translationDuration: TimeInterval = 0.4

class LXFMenuView: UIView {
    fileprivate let bgView = UIView().then {
        $0.backgroundColor = UIColor.clear
    }
    let tableView = UITableView().then {
        $0.rowHeight = 44.0
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.tableFooterView = UIView()
        $0.backgroundColor = UIColor.white
        $0.register(Reusable.Cell)
    }
    let viewModel = LXFMenuViewModel()
    
    var dataSource : RxTableViewSectionedReloadDataSource<LXFMenuSection>!
    var menuViewOutput : LXFMenuViewModel.LXFMenuViewOutput?
    
    init() {
        super.init(frame: CGRect(x: -kScreenW, y: 0, width: kScreenW, height: kScreenH))
        
        initUI()
        bindUI()
        loadData()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LXFMenuView {
    private func loadData() {
        menuViewOutput?.requestCommand.onNext(())
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }
}

extension LXFMenuView {
    private func bindUI() {
        // RxDataSources升级到3.0后需要在声明时初始化了。。
        dataSource = RxTableViewSectionedReloadDataSource<LXFMenuSection>(configureCell: { (ds, tv, indexPath, item) in
            let cell = tv.dequeue(Reusable.Cell, for: indexPath)
            
            cell.iconView.image = UIImage(named: "ic_nav_\(item.imageName)")
            cell.titleLabel.text = item.title
            return cell
        })
        
        let input = LXFMenuViewModel.LXFMenuViewInput()
        let output = viewModel.transform(input: input)
        self.menuViewOutput = output
        
        output.sections.asDriver().drive(tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(LXFMenuModel.self).subscribe(onNext: { (item) in
            LXFLog("我选中了\(item)")
            self.hideMenu()
        }).disposed(by: rx.disposeBag)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
}

extension LXFMenuView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 6 {
            return 25
        }
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        var height: CGFloat = 5
        if section == 6 {
            height = 25
            header.frame = CGRect(x: 0, y: 0, width: kScreenW, height: height)
            header.backgroundColor = UIColor.white
            let lineLayer = CAShapeLayer()
            lineLayer.path = UIBezierPath(rect: CGRect(x: 0, y: header.height * 0.5, width: header.width, height: 0.5)).cgPath
            lineLayer.fillColor = kRGBA(r: 0, g: 0, b: 0, a: 0.06).cgColor
            header.layer.addSublayer(lineLayer)
        }
        return header
    }
    
}

extension LXFMenuView {
    private func initUI() {
        let topView = LXFMenuTopView.loadFromNib()
        let bottomView = LXFMenuBottomView.loadFromNib()
        self.addSubview(bgView)
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(tableView)
        
        bgView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(menuWidth)
        }
        
        topView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview()
            make.width.equalTo(menuWidth)
            make.height.equalTo(LXFMenuTopView.viewHeight())
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(menuWidth)
            make.height.equalTo(LXFMenuBottomView.viewHeight())
        }
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(menuWidth)
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        // 添加拖拽手势
        self.rx.panGesture().subscribe(onNext: {
            let trans = $0.translation(in: $0.view)
            if trans.x < 0 {
                self.transform = CGAffineTransform(translationX: trans.x + kScreenW, y: 0)
            }
            if $0.state == .ended {
                if trans.x < -self.tableView.width * 0.5 {
                    UIView.animate(withDuration: translationDuration, animations: {
                        self.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                } else {
                    UIView.animate(withDuration: translationDuration, animations: {
                        self.transform = CGAffineTransform(translationX: kScreenW, y: 0)
                    })
                }
            }
        }).disposed(by: rx.disposeBag)
        // 点击事件 菜单消失
        bgView.rx.tapGesture().subscribe(onNext: { (_) in
            self.hideMenu()
        }).disposed(by: rx.disposeBag)
        // 处理通知
        handleNotificaiton()
    }
    // 处理点击导航栏头像的通知
    private func handleNotificaiton() {
        NotificationCenter.default.rx.notification(NSNotification.Name(kLXFNavAvatarableNote))
            .subscribe(onNext: { (_) in
            self.showMenu()
        }).disposed(by: rx.disposeBag)
    }
    
    // MARK: 显示和隐藏
    func showMenu() {
        UIView.animate(withDuration: translationDuration) {
            self.transform = CGAffineTransform(translationX: kScreenW, y: 0)
        }
    }
    func hideMenu() {
        UIView.animate(withDuration: translationDuration) {
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
