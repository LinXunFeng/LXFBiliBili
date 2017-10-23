//
//  LXFMenuPageController.swift
//  LXFMenuPageControllerDemo
//
//  Created by LXF on 2016/11/19.
//  Copyright © 2016年 LXF. All rights reserved.
//

import UIKit

private let kSystemOriginColor = UIColor(red: 0.96, green: 0.39, blue: 0.26, alpha: 1.0)
private let kSystemBlackColor = UIColor(red: 0.38, green: 0.39, blue: 0.40, alpha: 1.0)
private let kLXFScreenW = UIScreen.main.bounds.width

protocol LXFMenuPageControllerDelegate: NSObjectProtocol {
    // MARK: 获取当前子控制器的角标
    func lxf_MenuPageCurrentSubController( index: NSInteger, menuPageController: LXFMenuPageController)
    func lxf_MenuPagesDidScroll(menuPageController: LXFMenuPageController , scrollView: UIScrollView, contentOffset: CGPoint)
}

class LXFMenuPageController: UIViewController {

    // MARK:- 对外提供的属性
    /// 代理
    weak var delegate: LXFMenuPageControllerDelegate?
    /// 滑块颜色
    var sliderColor: UIColor = kSystemOriginColor { didSet { updateView() } }
    /// 子标题按钮未选中颜色
    var tipBtnNormalColor : UIColor = kSystemBlackColor { didSet { updateView() } }
    /// 子标题按钮选中颜色
    var tipBtnHighlightedColor : UIColor = kSystemOriginColor { didSet { updateView() } }
    /// 子标题按钮UIFont
    var tipBtnFontSize : CGFloat = 15 { didSet { updateView() } }
    /// 头部视图颜色
    var headerColor: UIColor = UIColor.white { didSet { updateView() } }
    //  contentOffset
    var contentOffset: CGPoint = CGPoint.zero
    //  contentsize
    var contentSize: CGSize { get { return pageScrollView.contentSize } }
    
    
    
    // MARK:- 定义私有属性
    /* ============================================================ */
    /// 所有子控制器
    fileprivate var controllers: [UIViewController] = [UIViewController]()
    /// pageController
    fileprivate var pageVc: UIPageViewController!
    fileprivate var pageScrollView: UIScrollView!
    
    fileprivate var currentPage: Int = 0
    
    /* ============================================================ */
    /// 头部
    fileprivate lazy var headerView: UIView = { [unowned self] in
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kLXFScreenW, height: 40))
        self.view.addSubview(view)
        return view
    }()
    /// 子标题按钮数组
    fileprivate var subTitleBtnArray: [UIButton] = [UIButton]()
    /// 当前被选中的子标题按钮
    fileprivate var currentSelectedBtn: UIButton!
    /// 子标题数组
    fileprivate var titleArray: [String] = [String]()
    /// 滑块高度
    fileprivate var sliderHeight: CGFloat = 2.0
    /// 下方的滑块指示器
    private var sliderIsExist = false
    fileprivate lazy var sliderView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = self.sliderColor
        view.frame = CGRect(x: 0, y: 40 - self.sliderHeight, width: 30, height: self.sliderHeight)
        if !self.sliderIsExist {
            self.sliderIsExist = true
            self.view.addSubview(view)
        }
        return view
   }()
    
    // MARK:- init
    init(controllers: [UIViewController], titles: [String]) {
        super.init(nibName: nil, bundle: nil)
        // 存储数据
        self.controllers = controllers
        self.titleArray = titles
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- 生命周期
    override func viewDidLoad() {
        // 初始化
        setup()
    }
}

// MARK:- 更新视图
extension LXFMenuPageController {
    fileprivate func updateView() {
        sliderView.backgroundColor = sliderColor
        headerView.backgroundColor = headerColor
        for view in headerView.subviews {
            if view.classForCoder == UIButton.classForCoder() {
                let btn = view as! UIButton
                btn.setTitleColor(tipBtnNormalColor, for: .normal)
                btn.setTitleColor(tipBtnHighlightedColor, for:.selected)
                btn.setTitleColor(tipBtnHighlightedColor, for: [.highlighted, .selected])
                btn.titleLabel?.font = UIFont.systemFont(ofSize: tipBtnFontSize)
            }
        }
        
        // 重新更新滑块的位置
        var sliderFrame = sliderView.frame
        let index = Int(sliderFrame.origin.x / (kLXFScreenW / CGFloat(controllers.count)))
        let btn = subTitleBtnArray[index]
        let silderW = getSliderWidth(with: btn)
        sliderFrame.size.width = silderW
        sliderFrame.origin.x = (btn.frame.width - silderW) * 0.5
        sliderView.frame = sliderFrame
    }
}

// MARK:- 初始化
extension LXFMenuPageController {
    /// 初始化page控制器
    fileprivate func setup() {
        if controllers.count == 0 {return}
        
        /// 配置子标题
        self.configSubTitles()
        
        /// 设置pageController
        let options: [String : Any] = [UIPageViewControllerOptionSpineLocationKey : NSNumber(integerLiteral: UIPageViewControllerSpineLocation.none.rawValue)]
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
        page.delegate = self
        page.dataSource = self
        page.setViewControllers([controllers.first!], direction: .forward, animated: false, completion: nil)
        let pageX: CGFloat = 0
        let pageY: CGFloat = headerView.frame.height
        let pageW: CGFloat = self.view.frame.width
        let pageH: CGFloat = self.view.frame.height - pageY
        page.view.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
        pageVc = page
        
        self.view.addSubview(page.view)
        
        // 查找UIPageViewController里面的UIScrollView
        for subview in page.view.subviews {
            if subview.isKind(of: UIScrollView.classForCoder()) {
                pageScrollView = subview as! UIScrollView
                pageScrollView.delegate = self
                break;
            }
        }
    }
}

// UIPageViewController里面的UIScrollView 的 contentOffset是不会自动改变的，需要我们自己去矫正它～～
extension LXFMenuPageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        for vc in controllers{
            let point = vc.view.convert(CGPoint(), to: view)
            if (point.x) > CGFloat(0.0) && (point.x) < pageWidth{
                let vcPage = CGFloat(controllers.index(of: vc) ?? 0)
                contentOffset = CGPoint(x: vcPage * pageWidth - point.x, y: 0)
            }
        }
        //若不是循环，最后一个找不到左边距
        if contentOffset.x >= CGFloat(controllers.count - 1) * pageWidth{
            let point = controllers[controllers.count - 1].view.convert(CGPoint(), to: view)
            contentOffset = CGPoint(x: CGFloat((controllers.count)-1) * pageWidth - point.x, y: 0)
        }
        
        self.delegate?.lxf_MenuPagesDidScroll(menuPageController: self, scrollView: scrollView, contentOffset: contentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = view.frame.width
        currentPage = Int(round(contentOffset.x/pageWidth))
        if currentPage < 0 {
            currentPage = controllers.count - 1
        }
        contentOffset = CGPoint(x: CGFloat(currentPage) * pageWidth, y: 0)
        delegate?.lxf_MenuPageCurrentSubController(index: currentPage, menuPageController: self)
    }
}

// MARK:- 配置子标题
extension LXFMenuPageController {
    fileprivate func configSubTitles() {
        // 每一个titleBtn的宽度
        let btnW = kLXFScreenW / CGFloat(titleArray.count)
        
        for index in 0..<titleArray.count {
            let title = titleArray[index]
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(tipBtnNormalColor, for: .normal)
            btn.setTitleColor(tipBtnHighlightedColor, for:.selected)
            btn.setTitleColor(tipBtnHighlightedColor, for: [.highlighted, .selected])
            let btnH: CGFloat = headerView.frame.height - sliderHeight
            btn.frame = CGRect(x: CGFloat(index) * btnW, y: 0, width: btnW , height: btnH)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: tipBtnFontSize)
            btn.adjustsImageWhenDisabled = false
            btn.addTarget(self, action: #selector(subTitleClick(_ :)), for: .touchUpInside)
            subTitleBtnArray.append(btn)
            headerView.addSubview(btn)
        }
        
        guard let firstBtn = subTitleBtnArray.first else {return}
        selectedAtBtn(firstBtn, isFirstStart: true)
    }
    
    /// 当前选中了某一个按钮
    fileprivate func selectedAtBtn(_ btn: UIButton, isFirstStart: Bool) {
        btn.isSelected = true
        currentSelectedBtn = btn
        let sliderW: CGFloat = getSliderWidth(with: btn)
        let sliderH: CGFloat = self.sliderHeight
        let sliderX: CGFloat = btn.frame.origin.x + btn.frame.width * 0.5 - sliderW * 0.5
        let sliderY: CGFloat = headerView.frame.height - self.sliderHeight
        if !isFirstStart {
            UIView.animate(withDuration: 0.25, animations: { [unowned self] in
                self.sliderView.frame = CGRect(x: sliderX, y: sliderY, width: sliderW, height: sliderH)
                // 矫正contentOffset
                self.contentOffset = CGPoint(x: CGFloat(self.subTitleBtnArray.index(of: btn)!) * kLXFScreenW, y: 0)
            })
        } else {
            sliderView.frame = CGRect(x: sliderX, y: sliderY, width: sliderW, height: sliderH)
        }
        unSelectedAllBtn(btn)
    }
    
    /// 对所有非选中的按钮执行反选操作
    fileprivate func unSelectedAllBtn(_ btn: UIButton) {
        for sbtn in subTitleBtnArray {
            if sbtn == btn {
                continue
            }
            sbtn.isSelected = false
        }
    }
    
    /// 获取滑块的长度
    fileprivate func getSliderWidth(with btn: UIButton) -> CGFloat {
        guard let str = btn.titleLabel?.text as NSString? else {
            return 0
        }
        let strSize = str.size(withAttributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: tipBtnFontSize)])
        return strSize.width
    }
    
    @objc private func subTitleClick(_ btn: UIButton) {
        if btn == currentSelectedBtn {
            return
        }
        selectedAtBtn(btn, isFirstStart: false)
        
        // 设置当前子控制器
        if let btnIndex = subTitleBtnArray.index(of: btn) {
            setCurrentSubControllerWith(index: btnIndex)
        }
    }
}


// MARK:- 控制 pageController 的方法
extension LXFMenuPageController {
    // MARK: 设置当前子控制器
    fileprivate func setCurrentSubControllerWith(index: NSInteger) {
        pageVc.setViewControllers([controllers[index]], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: pageController的代理与数据源
extension LXFMenuPageController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    /// 前一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.index(of: viewController) else {return nil}
        if index == 0 || index == NSNotFound {
            return nil
        }
        return controllers[index - 1]
    }
    
    /// 后一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.controllers.index(of: viewController) else {return nil}
        if index == NSNotFound || index == controllers.count - 1 {
            return nil
        }
        return controllers[index + 1]
    }
    
    /// 返回控制器数量
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    /// 跳转到另一个控制器界面时调用
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = pageViewController.viewControllers?[0] else {return}
        let index = indexForViewController(controller: vc)
        
        delegate?.lxf_MenuPageCurrentSubController(index: index, menuPageController: self)
        
        // 设置当前子标题按钮
        let btn = subTitleBtnArray[index]
        selectedAtBtn(btn, isFirstStart: false)
        
    }
    
    /// 获取当前子控制器的角标
    private func indexForViewController(controller: UIViewController) -> NSInteger {
        currentPage = controllers.index(of: controller)!
        return currentPage
    }

}



