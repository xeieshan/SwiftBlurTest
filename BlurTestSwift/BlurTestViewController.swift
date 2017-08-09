//
//  ViewController.swift
//  BlurTestSwift
//
//  Created by Zeeshan Haider on 20/06/2017.
//  Copyright © 2017 <#Project Team#>. All rights reserved.
//

import UIKit

class BlurTestViewController : UIViewController {
    
    @IBOutlet weak var label2: UILabel?
    @IBOutlet weak var image2: UIImageView?
    @IBOutlet weak var label1: UILabel?
    @IBOutlet weak var image1: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Initializations
        self.initializations()
        //SetupView
        self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img1: UIImage = image1!.image!
        let img2: UIImage = image2!.image!
        let isblur1: Bool = OpenCVWrapper.isImageBlurry(img1)
        let isblur2: Bool = OpenCVWrapper.isImageBlurry(img2)
        if isblur1 {
            label1?.text = "Blur Test Passed"
            label1?.textColor = UIColor.green
        } else {
            label1?.text = "Blur Test Failed"
            label1?.textColor = UIColor.red
            
        }
        if isblur2 {
            label2?.text = "Blur Test Passed"
            label2?.textColor = UIColor.green
        } else {
            label2?.text = "Blur Test Failed"
            label2?.textColor = UIColor.red
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setUpView() {
    }
    
    func initializations() {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

