//
//  WKAwesomeMenu.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 30.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit

public class WKAwesomeMenu: UIViewController {
    
    // MARK: - Private Variables
    
    private var rootViewController: UIViewController!
    
    private var menuViewController: UIViewController!
    
    private var rootView: UIView! // TODO: fix no user interaction while menu is open
    
    private var menuView: UIView!
    
    private var shadowView: UIView = UIView()
    
    private var canSlide: Bool = false
    
    private var lastTranslation = CGPoint.zero
    
    private var lightStatusBar: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - Public Variables
    
    var options = WKAwesomeMenuOptions.defaultOptions()
    
    var isClosed: Bool = true {
        didSet {
            self.lightStatusBar = !self.isClosed
            self.rootView?.userInteractionEnabled = self.isClosed
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
        root.didMoveToParentViewController(self)
        menu.didMoveToParentViewController(self)
        
        self.setupUI()
        
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: "closeMenu")
        self.shadowView.addGestureRecognizer(tap)
    }
    
    func setupUI() {
        if self.options.backgroundImage != nil {
            let background = UIImageView(image: self.options.backgroundImage)
            self.view.addSubview(background)
            background.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
                toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
                toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal,
                toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: background, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal,
                toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        }
        
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.menuView)
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal,
            toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.options.menuWidth))
        
        self.shadowView.clipsToBounds = true
        self.shadowView.backgroundColor = self.options.shadowColor
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.shadowView)
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        
        self.setupRootViewUI()
    }
    
    func setupRootViewUI() {
        self.rootView.clipsToBounds = true
        self.rootView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.rootView)
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    // MARK: - Internal
    
    func pan(pan: UIPanGestureRecognizer) {
        
        let translation = pan.translationInView(self.view)
        let velocity = pan.velocityInView(self.view)
        
        let locationX = max(0, min(translation.x, self.options.menuWidth))
        let shouldClose = locationX + velocity.x / 2 < self.options.menuWidth / 2
        
        switch pan.state {
        case UIGestureRecognizerState.Began:
            self.canSlide = pan.locationInView(self.view).x <= self.options.menuGripWidth || !self.isClosed
            if !self.canSlide { break }
            
            self.lightStatusBar = true
            pan.setTranslation(self.lastTranslation, inView: self.view)
        case UIGestureRecognizerState.Ended:
            if !self.canSlide { break }
            
            self.isClosed = shouldClose
            self.lastTranslation = CGPoint(x: shouldClose ? 0 : self.options.menuWidth, y: 0)
            
            let duration = Double(min(0.5, self.options.menuWidth / abs(velocity.x)))
            let percentage = locationX / self.options.menuWidth
            
            ProgressTimer.createWithDuration(duration, from: percentage, inverse: shouldClose, callback: { (p) -> Void in
                self.invalidateRootViewWithPercentage(p)
            })
        case UIGestureRecognizerState.Changed:
            if !self.canSlide { break }
            self.invalidateRootViewWithPercentage(locationX / self.options.menuWidth)
            self.lastTranslation = translation
        default:
            break
        }
    }
    
    func invalidateRootViewWithPercentage(percentage: CGFloat) {
        
        let radius = self.options.cornerRadius * percentage
        let scale = 1 - (1 - self.options.rootScale) * percentage
        let translate = CGPoint(x: self.options.menuWidth * percentage, y: 0)
        
        var transform = CGAffineTransformMakeScale(scale, scale)
        transform = CGAffineTransformTranslate(transform, translate.x, translate.y)
        
        self.rootView.transform = transform
        self.rootView.layer.cornerRadius = radius
        
        self.menuView.transform = CGAffineTransformMakeTranslation(self.options.menuParallax * (1 - percentage), 0)
        
        let scale2 = scale * self.options.shadowScale
        let translate2 = CGPoint(
            x: translate.x + self.options.shadowOffset.x * percentage,
            y: translate.y + self.options.shadowOffset.y * percentage)
        
        var transform2 = CGAffineTransformMakeScale(scale2, scale2)
        transform2 = CGAffineTransformTranslate(transform2, translate2.x, translate2.y)
        
        self.shadowView.transform = transform2
        self.shadowView.layer.cornerRadius = radius
    }
    
    // MARK: - Public
    
    func changeRootViewController(vc: UIViewController, withAnimationDuration duration: NSTimeInterval = 0.2) {
        let transform = self.rootView?.transform ?? CGAffineTransformIdentity
        let radius = self.rootView?.layer.cornerRadius ?? 0
        
        let lastVC = self.rootViewController
        
        self.rootViewController = vc
        self.rootView = vc.view
        
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        
        self.setupRootViewUI()
        
        self.rootView.layer.cornerRadius = radius
        self.rootView.transform = transform
        self.rootView.alpha = 0
        
        UIView.animateWithDuration(duration,
            animations: { () -> Void in
                self.rootView.alpha = 1
            }) { [weak lastVC] (complete) -> Void in
                lastVC?.view?.removeFromSuperview()
                lastVC?.removeFromParentViewController()
                self.closeMenu()
        }
    }
    
    public func openMenu() {
        self.openMenuWithDuration(0.2)
    }
    
    public func openMenuWithDuration(duration: NSTimeInterval) {
        if !self.isClosed { return }
        
        self.isClosed = false
        self.lightStatusBar = true
        self.lastTranslation = CGPoint(x: self.options.menuWidth, y: 0)
        
        ProgressTimer.createWithDuration(duration, callback: { (p) -> Void in
            self.invalidateRootViewWithPercentage(p)
        })
    }
    
    public func closeMenu() {
        self.closeMenuWithDuration(0.2)
    }
    
    public func closeMenuWithDuration(duration: NSTimeInterval) {
        if self.isClosed { return }
        
        self.isClosed = true
        self.lightStatusBar = false
        self.lastTranslation = CGPoint.zero
        
        ProgressTimer.createWithDuration(duration, from: 1, inverse: true, callback: { (p) -> Void in
            self.invalidateRootViewWithPercentage(p)
        })
    }
    
    // MARK: - Override
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.lightStatusBar ? UIStatusBarStyle.LightContent : self.rootViewController.preferredStatusBarStyle()
    }
    
    public override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return self.rootViewController.preferredStatusBarUpdateAnimation()
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return self.rootViewController.prefersStatusBarHidden()
    }
    
}
