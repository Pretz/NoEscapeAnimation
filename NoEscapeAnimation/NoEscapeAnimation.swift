//
//  NoEscapeAnimation.swift
//  NoEscapeAnimation
//
//  Created by Alex Pretzlav on 3/1/15.
//  Copyright (c) 2015 Alex Pretzlav. All rights reserved.
//

import UIKit

private var delegates = Set<AnimationDelegate>()

public func animateViews(
    #duration: NSTimeInterval,
    delay: NSTimeInterval = 0,
    curve: UIViewAnimationCurve? = nil,
    @noescape #animations: () -> Void,
    completion: (Bool -> Void)? = nil) {
        
        var wrapper: AnimationDelegate? = nil
        if let completion = completion {
            wrapper = AnimationDelegate(callback: completion)
            delegates.insert(wrapper!)
        }
        UIView.beginAnimations(nil, context: nil)
        
        UIView.setAnimationDuration(duration)
        UIView.setAnimationDelay(delay)
        if let curve = curve {
            UIView.setAnimationCurve(curve)
        }
        
        UIView.setAnimationDelegate(wrapper)
        UIView.setAnimationDidStopSelector("animationDidStop:finished:context:")
        
        animations()
        
        UIView.commitAnimations()
}

final class AnimationDelegate: NSObject {
    let callback: Bool -> Void
    init(callback: Bool -> Void) {
        self.callback = callback
    }
    
    func animationDidStop(animationId: String?, finished: NSNumber, context: UnsafeMutablePointer<Void>) {
        self.callback(finished.boolValue)
        delegates.remove(self)
    }
}