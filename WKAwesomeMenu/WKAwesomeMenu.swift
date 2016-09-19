//
//  WKAwesomeMenu.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 30.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit

open class WKAwesomeMenu: UIViewController {
    
    // MARK: - Private Variables
    
    fileprivate var rootViewController: UIViewController!
    
    fileprivate var menuViewController: UIViewController!
    
    fileprivate var rootView: UIView! // TODO: fix no user interaction while menu is open
    
    fileprivate var menuView: UIView!
    
    fileprivate var shadowView: UIView = UIView()
    
    fileprivate var canSlide: Bool = false
    
    fileprivate var lastTranslation = CGPoint.zero
    
    fileprivate var lightStatusBar: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Public Variables
    
    var options = WKAwesomeMenuOptions.defaultOptions()
    
    var isClosed: Bool = true {
        didSet {
            self.lightStatusBar = !self.isClosed
            self.rootView?.isUserInteractionEnabled = self.isClosed
        }
    }
    
    // MARK: - Initialization
    
    public convenience init(rootViewController root: UIViewController, menuViewController menu: UIViewController, options: WKAwesomeMenuOptions? = nil) {
        self.init()
        
        if let options = options {
            self.options = options
        }
        
        self.rootViewController = root
        self.menuViewController = menu
        self.rootView = root.view
        self.menuView = menu.view
        
        self.addChildViewController(root)
        self.addChildViewController(menu)
        root.didMove(toParentViewController: self)
        menu.didMove(toParentViewController: self)
        
        // Disable top to scroll up for the menu
        // in order to scroll the root view controller
        (menu as? UITableViewController)?.tableView.scrollsToTop = false
        
        self.setupUI()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(WKAwesomeMenu.pan(_:)))
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(WKAwesomeMenu.closeMenu))
        self.shadowView.addGestureRecognizer(tap)
    }
    
    func setupUI() {
        if self.options.backgroundImage != nil {
            let background = UIImageView(image: self.options.backgroundImage)
            self.view.addSubview(background)
            background.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal,
                toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal,
                toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal,
                toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
                toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
        }
        
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.menuView)
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal,
            toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.options.menuWidth))
        
        self.shadowView.clipsToBounds = true
        self.shadowView.backgroundColor = self.options.shadowColor
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.shadowView)
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
        
        self.setupRootViewUI()
    }
    
    func setupRootViewUI() {
        self.rootView.clipsToBounds = true
        self.rootView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.rootView)
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
            toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0))
    }
    
    // MARK: - Internal
    
    func pan(_ pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: self.view)
        let velocity = pan.velocity(in: self.view)
        
        let locationX = max(0, min(translation.x, self.options.menuWidth))
        let shouldClose = locationX + velocity.x / 2 < self.options.menuWidth / 2
        
        switch pan.state {
        case UIGestureRecognizerState.began:
            self.canSlide = pan.location(in: self.view).x <= self.options.menuGripWidth || !self.isClosed
            if !self.canSlide { break }
            
            self.lightStatusBar = true
            pan.setTranslation(self.lastTranslation, in: self.view)
        case UIGestureRecognizerState.ended:
            if !self.canSlide { break }
            
            self.isClosed = shouldClose
            self.lastTranslation = CGPoint(x: shouldClose ? 0 : self.options.menuWidth, y: 0)
            
            let duration = Double(min(0.5, self.options.menuWidth / abs(velocity.x)))
            let percentage = locationX / self.options.menuWidth
            
            ProgressTimer.createWithDuration(duration, from: percentage, inverse: shouldClose, callback: { (p) -> Void in
                self.invalidateRootViewWithPercentage(p)
            })
        case UIGestureRecognizerState.changed:
            if !self.canSlide { break }
            self.invalidateRootViewWithPercentage(locationX / self.options.menuWidth)
            self.lastTranslation = translation
        default:
            break
        }
    }
    
    func invalidateRootViewWithPercentage(_ percentage: CGFloat) {
        
        let radius = self.options.cornerRadius * percentage
        let scale = 1 - (1 - self.options.rootScale) * percentage
        let translate = CGPoint(x: self.options.menuWidth * percentage, y: 0)
        
        var transform = CGAffineTransform(scaleX: scale, y: scale)
        transform = transform.translatedBy(x: translate.x, y: translate.y)
        
        self.rootView.transform = transform
        self.rootView.layer.cornerRadius = radius
        
        self.menuView.transform = CGAffineTransform(translationX: self.options.menuParallax * (1 - percentage), y: 0)
        
        let scale2 = scale * self.options.shadowScale
        let translate2 = CGPoint(
            x: translate.x + self.options.shadowOffset.x * percentage,
            y: translate.y + self.options.shadowOffset.y * percentage)
        
        var transform2 = CGAffineTransform(scaleX: scale2, y: scale2)
        transform2 = transform2.translatedBy(x: translate2.x, y: translate2.y)
        
        self.shadowView.transform = transform2
        self.shadowView.layer.cornerRadius = radius
    }
    
    // MARK: - Public
    
    func changeRootViewController(_ vc: UIViewController, withAnimationDuration duration: TimeInterval = 0.2) {
        let transform = self.rootView?.transform ?? CGAffineTransform.identity
        let radius = self.rootView?.layer.cornerRadius ?? 0
        
        let lastVC = self.rootViewController
        
        self.rootViewController = vc
        self.rootView = vc.view
        
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        
        self.setupRootViewUI()
        
        self.rootView.layer.cornerRadius = radius
        self.rootView.transform = transform
        self.rootView.alpha = 0
        
        UIView.animate(withDuration: duration,
            animations: { () -> Void in
                self.rootView.alpha = 1
            }) { [weak lastVC] (complete) -> Void in
                lastVC?.view?.removeFromSuperview()
                lastVC?.removeFromParentViewController()
                self.closeMenu()
        }
    }
    
    open func openMenu() {
        self.openMenuWithDuration(0.2)
    }
    
    open func openMenuWithDuration(_ duration: TimeInterval) {
        if !self.isClosed { return }
        
        self.isClosed = false
        self.lightStatusBar = true
        self.lastTranslation = CGPoint(x: self.options.menuWidth, y: 0)
        
        ProgressTimer.createWithDuration(duration, callback: { (p) -> Void in
            self.invalidateRootViewWithPercentage(p)
        })
    }
    
    open func closeMenu() {
        self.closeMenuWithDuration(0.2)
    }
    
    open func closeMenuWithDuration(_ duration: TimeInterval) {
        if self.isClosed { return }
        
        self.isClosed = true
        self.lightStatusBar = false
        self.lastTranslation = CGPoint.zero
        
        ProgressTimer.createWithDuration(duration, from: 1, inverse: true, callback: { (p) -> Void in
            self.invalidateRootViewWithPercentage(p)
        })
    }
    
    // MARK: - Override
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return self.lightStatusBar ? UIStatusBarStyle.lightContent : self.rootViewController.preferredStatusBarStyle
    }

    override open var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return self.rootViewController.preferredStatusBarUpdateAnimation
    }
    override open var prefersStatusBarHidden: Bool {
        return self.rootViewController.prefersStatusBarHidden
    }
    
}
