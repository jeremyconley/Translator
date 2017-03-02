//
//  LauncherAnimationVC.swift
//  Translator
//
//  Created by Jeremy Conley on 2/18/17.
//  Copyright © 2017 JeremyConley. All rights reserved.
//

import UIKit

class LauncherAnimationVC: UIViewController {
    
    let aImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "a")
        return imgView
    }()
    let symbolImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "symbol")
        return imgView
    }()
    
    let lowerArrowImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "arrow2")
        return imgView
    }()
    let upperArrowImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "arrow")
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0/255, green: 127/255, blue: 255/255, alpha: 1)
        
        view.addSubview(symbolImg)
        view.addSubview(aImg)
        view.addSubview(upperArrowImg)
        view.addSubview(lowerArrowImg)
        
        symbolImg.frame = CGRect(x: 0, y: -100, width: 100, height: 100)
        aImg.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: 100, height: 100)
        upperArrowImg.frame = CGRect(x: self.view.frame.width, y: 0, width: 100, height: 100)
        lowerArrowImg.frame = CGRect(x: 0, y: self.view.frame.height, width: 100, height: 100)
        

        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            self.symbolImg.center = CGPoint(x: self.view.center.x - 15, y: self.view.center.y - 15)
            self.aImg.center = CGPoint(x: self.view.center.x + 18, y: self.view.center.y + 15)
            self.aImg.image = #imageLiteral(resourceName: "aCut")
            self.upperArrowImg.center = CGPoint(x: self.view.center.x + 35, y: self.view.center.y - 25)
            self.lowerArrowImg.center = CGPoint(x: self.view.center.x - 35, y: self.view.center.y + 25)
            }) { (completed) in
                
                
                UIView.animate(withDuration: 0.2, delay: 0.5, options: .curveEaseIn, animations: {
                    self.performSegue(withIdentifier: "toRootVC", sender: self)
                })
            }

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
