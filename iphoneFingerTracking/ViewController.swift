//
//  ViewController.swift
//  iphoneFingerTracking
//
//  Created by jay★ on 2016-10-05.
//  Copyright © 2016 jay★. All rights reserved.
//

import UIKit

let circleRadius: CGFloat = 60.0

struct touchValues {
    var view : UIView
    let color: UIColor
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var touchArray = [UITouch:touchValues]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("began")
        for touch in touches {
            let touchLocation = touch.location(in: self.view)
            let color = UIColor.red
            let touchView = drawTouch(touchPoint: touchLocation, color: color)
            let touchObject = touchValues(view: touchView, color: color)
            touchArray[touch] = touchObject
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("moved")
        for touch in touches {
            let newTouchLocation = touch.location(in: self.view)
            let object = touchArray[touch]
            object?.view.center = newTouchLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ended")
        for touch in touches {
            let object = touchArray[touch]
            object?.view.removeFromSuperview()
            touchArray.removeValue(forKey: touch)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("cancelled")
        // TODO: fix bug where touchesBegan, touchesMoved, touchesEnded do not get called when 6+ touches are detected
        for touch in touches {
            let object = touchArray[touch]
            object?.view.removeFromSuperview()
            touchArray.removeValue(forKey: touch)
        }
    }
    
    func drawTouch(touchPoint:CGPoint, color:UIColor) -> UIView {
        let touchView = UIView()
        touchView.backgroundColor = color
        touchView.frame = CGRect(x: (touchPoint.x - circleRadius), y: (touchPoint.y - circleRadius), width: (circleRadius * 2), height: (circleRadius * 2))
        touchView.layer.cornerRadius = circleRadius
        self.view.addSubview(touchView)
        return touchView
    }
    
}
