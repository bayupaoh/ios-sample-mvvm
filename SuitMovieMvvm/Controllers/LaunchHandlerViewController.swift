//
//  LaunchHandlerViewController.swift
//  SuitMovieMvvm
//
//  Created by Alam Akbar Muhammad on 04/10/18.
//  Copyright © 2018 Rifat Firdaus. All rights reserved.
//

import UIKit

class LaunchHandlerViewController: UIViewController {

    static func instantiate() -> LaunchHandlerViewController {
        let controller = UIStoryboard.main.instantiateViewController(withIdentifier: "LaunchHandlerViewController") as! LaunchHandlerViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stampDevice()
        let controller = MovieViewController.instantiateNav()
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: false, completion: nil)
    }

    func stampDevice() {
        print("📱 DEVICE NAME : \(UIDevice.current.name)")
        print("📱 DEVICE MODEL : \(UIDevice.current.model)")
        print("📱 DEVICE SYSTEM VERSION : \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
        print("🖥 SCREEN(WxH) : \(UIScreen.main.bounds.width) x \(UIScreen.main.bounds.height)")
    }

}
