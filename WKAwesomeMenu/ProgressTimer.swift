//
//  ProgressTimer.swift
//  
//
//  Created by Adrian Mateoaea on 30.01.2016.
//
//

import UIKit

class ProgressTimer: NSObject {
    
    var animationDuration: NSTimeInterval = 0.5
    
    var animationFrom: CGFloat = 0
    
    var animationInverse: Bool = false
    
    var startTime: CFTimeInterval = 0
    
    var callback: ((CGFloat) -> Void)?
    
    static func createWithDuration(duration: NSTimeInterval, from: CGFloat = 0, inverse: Bool = false, callback: (CGFloat) -> Void) {
        let timer = ProgressTimer()
        timer.animationDuration = duration
        timer.animationFrom = inverse ? 1 - from : from
        timer.animationInverse = inverse
        timer.callback = callback
        timer.start()
    }
    
    func start() {
        self.startTime = CACurrentMediaTime()
        let link = CADisplayLink(target: self, selector: "tick:")
        link.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func tick(link: CADisplayLink) {
        let elapsed = link.timestamp - self.startTime
        var percent = self.animationFrom + CGFloat((elapsed / self.animationDuration))
        
        if self.animationInverse {
            percent = 1 - percent
            if percent <= 0 {
                percent = 0
                link.invalidate()
            }
        } else if percent >= 1 {
            percent = 1
            link.invalidate()
        }
        
        self.callback?(percent)
    }
    
}
