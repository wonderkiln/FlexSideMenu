//
//  WKAwesomeMenu.swift
//  WKAwesomeMenu
//
//  Created by Adrian Mateoaea on 30.01.2016.
//  Copyright © 2016 Wonderkiln. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func changeViewController(vc: UIViewController) {
        if let am = self.parentViewController as? WKAwesomeMenu {
            am.changeRootViewController(vc)
        }
    }
    
}

public class WKAwesomeMenu: UIViewController {
    
    var rootViewController: UIViewController!
    
    var menuViewController: UIViewController!
    
    var rootView: UIView!
    
    var shadowView: UIView = UIView()
    
    var menuView: UIView!
    
    var options = WKAwesomeMenuOptions.defaultOptions()
    
    public convenience init(rootViewController root: UIViewController, menuViewController menu: UIViewController, options: WKAwesomeMenuOptions) {
        self.init()
        
        self.options = options
        
        self.rootViewController = root
        self.menuViewController = menu
        
        self.rootView = root.view
        self.menuView = menu.view
        
        self.addChildViewController(root)
        self.addChildViewController(menu)
        
        root.didMoveToParentViewController(self)
        menu.didMoveToParentViewController(self)
        
        self.setupUI()
        
        pan = UIPanGestureRecognizer(target: self, action: "pan:")
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    var pan: UIPanGestureRecognizer!
    
    func changeRootViewController(vc: UIViewController) {
        let transform = self.rootView.transform
        let radius = self.rootView.layer.cornerRadius
        
        let x = self.rootView
        let xx = self.rootViewController
        
        self.rootViewController = vc
        self.rootView = vc.view
        
        self.addChildViewController(vc)
        vc.didMoveToParentViewController(self)
        

        
        self.rootView.alpha = 0
        self.rootView.clipsToBounds = true
        self.rootView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.rootView)
        
        
        self.rootView.layer.cornerRadius = radius
        self.rootView.transform = transform
        
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.rootView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        
        UIView.animateWithDuration(0.2,
            animations: { () -> Void in
                self.rootView.alpha = 1
            }) { (complete) -> Void in
                x?.removeFromSuperview()
                xx?.removeFromParentViewController()
                
                self.closeMenu()
            }
    }
    
    func setupUI() {
        
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
        
//        self.menuView.clipsToBounds = true
//        self.menuView.subviews.first?.frame = CGRectMake(0, 0, 200, self.view.bounds.height)
        self.menuView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.menuView)
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.menuView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal,
            toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: self.options.menuWidth))
        
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
        
        self.shadowView.clipsToBounds = true
        self.shadowView.backgroundColor = self.options.shadowColor
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(self.shadowView, belowSubview: self.rootView)
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.shadowView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal,
            toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        
        let tap = UITapGestureRecognizer(target: self, action: "closeMenu")
        self.rootView.addGestureRecognizer(tap)
    }
    
    func closeMenu() {
        self.closeMenuWithDuration(0.3)
    }
    
    func closeMenuWithDuration(duration: NSTimeInterval) {
        if self.isClosed { return }
        
        self.isClosed = true
        self.lightStatusBar = false
        self.lastTranslation = CGPoint.zero
        
        ProgressTimer.createWithDuration(duration, from: 1, inverse: true, callback: { (p) -> Void in
            self.invalidateRootViewWithPercentage(p)
        })
    }
    
    var lastTranslation = CGPoint.zero
    
    var isClosed: Bool = true {
        didSet {
            self.lightStatusBar = !self.isClosed
        }
    }
    
    var canSlide: Bool = false
    
    func pan(pan: UIPanGestureRecognizer) {
        
        let translation = pan.translationInView(self.view)
        let velocity = pan.velocityInView(self.view)
        
        let locationX = max(0, min(translation.x, self.options.menuWidth))
        let shouldClose = locationX + velocity.x / 2 < self.options.menuWidth / 2
        
        switch pan.state {
        case UIGestureRecognizerState.Began:
            self.canSlide = pan.locationInView(self.view).x <= self.options.edgeGrip || !self.isClosed
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
        let scale = 1 - (1 - self.options.viewScale) * percentage
        let translate = CGPoint(x: self.options.menuWidth * percentage, y: 0)
        
        var transform = CGAffineTransformMakeScale(scale, scale)
        transform = CGAffineTransformTranslate(transform, translate.x, translate.y)
        
        self.rootView.transform = transform
        self.rootView.layer.cornerRadius = radius
        
        self.menuView.transform = CGAffineTransformMakeTranslation(-40 * (1 - percentage), 0)
        
        let scale2 = scale * self.options.shadowScale
        let translate2 = CGPoint(
            x: translate.x + self.options.shadowOffset.x * percentage,
            y: translate.y + self.options.shadowOffset.y * percentage)
        
        var transform2 = CGAffineTransformMakeScale(scale2, scale2)
        transform2 = CGAffineTransformTranslate(transform2, translate2.x, translate2.y)
        
        self.shadowView.transform = transform2
        self.shadowView.layer.cornerRadius = radius
    }
    
    var lightStatusBar: Bool = false {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.lightStatusBar ? UIStatusBarStyle.LightContent : self.rootViewController.preferredStatusBarStyle()
    }
    
    public override func preferredStatusBarUpdateAnimation() -> UIStatusBarAnimation {
        return UIStatusBarAnimation.Fade
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
}
