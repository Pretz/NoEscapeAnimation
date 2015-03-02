//
//  ViewController.swift
//  NoEscapeAnimationExample
//
//  Created by Alex Pretzlav on 3/1/15.
//  Copyright (c) 2015 Alex Pretzlav. All rights reserved.
//

import UIKit
import NoEscapeAnimation

class ViewController: UIViewController {

    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var blueBox: UIView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        animationLoop()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func animationLoop() {
        animateViews(
            duration: 2.0,
            animations: {
                subview.frame.origin.x += 100
                subview.frame.origin.y += 100
            }, completion: { _ in
                self.view.setNeedsLayout()
                animateViews(
                    duration: 0.5,
                    animations: {
                        self.view.layoutIfNeeded()
                    }, completion: { _ in
                        self.animationLoop()
                })
        })
        
        animateViews(duration: 0.5, curve: .EaseOut,
            animations: {
                blueBox.frame.origin.y -= 100
        })
    }
    
}

