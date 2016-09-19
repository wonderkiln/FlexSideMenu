//
//  ProgressTimer.swift
//  
//
//  Created by Adrian Mateoaea on 30.01.2016.
//
//

import UIKit

class ProgressTimer: NSObject {
    
    var animationDuration: TimeInterval = 0.5
    
    var animationFrom: CGFloat = 0
    
    var animationInverse: Bool = false
    
    var startTime: CFTimeInterval = 0
    
    var callback: ((CGFloat) -> Void)?
    
    static func createWithDuration(_ duration: TimeInterval, from: CGFloat = 0, inverse: Bool = false, callback: @escaping (CGFloat) -> Void) {
        let timer = ProgressTimer()
        timer.animationDuration = duration
        timer.animationFrom = inverse ? 1 - from : from
        timer.animationInverse = inverse
        timer.callback = callback
        timer.start()
    }
    
    func start() {
        self.startTime = CACurrentMediaTime()
        let link = CADisplayLink(target: self, selector: #selector(ProgressTimer.tick(_:)))
        link.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    func tick(_ link: CADisplayLink) {
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
