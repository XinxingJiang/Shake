//
//  ViewController.swift
//  BlankParseProject
//
//  Created by Xinxing Jiang on 10/14/15.
//  Copyright © 2015 iosjjj. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Subviews
    
    var label: UILabel!
    
    // MARK: - VC life cycles
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = Constants.BackgtoundColor
        initLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    // MARK: - Init label
    
    private func initLabel() {
        label = UILabel()
        label.text = Constants.LabelTextStatic
        label.textColor = Constants.LabelTextColor
        self.view.addSubview(label)
        
        // constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        let centerXCon = NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0)
        let centerYCon = NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0)
        self.view.addConstraints([centerXCon, centerYCon])
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // MARK: - Shake motion recognizer
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            label.text = Constants.LabelTextDynamic
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            // vibrate, make sure your cell phone is not in silence mode
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // generate a random numebr
            if let randomNumber = MathUtil.randomNumber(low:Constants.LowerBound, high: Constants.HighBound) {
                label.text = "\(Constants.LabelTextReslt) \(randomNumber)"
            }
        }
    }
    
    // MARK: - Constants
    
    struct Constants {
        static let BackgtoundColor = UIColor.blackColor()
        
        static let LabelTextStatic = "Shake your phone!"
        static let LabelTextColor = UIColor.whiteColor()
        static let LabelTextDynamic = "I'm shaking!"
        static let LabelTextReslt = "Here you go:"
        
        static let LowerBound = 1
        static let HighBound = 10
    }
}

