//
//  ViewManager.swift
//
//  Created by Rifat Firdaus on 4/3/18.
//  Copyright © 2018 Suitmedia. All rights reserved.
//

import UIKit

class ViewManager: NSObject {

    static func createNavigationController(rootController controller: UIViewController, transparent: Bool = true) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.navigationBar.barStyle = .black
        nav.navigationBar.tintColor = UIColor.black
        if transparent {
            nav.navigationBar.backgroundColor = nil
            nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
            nav.navigationBar.shadowImage = UIImage()
            nav.navigationBar.isTranslucent = true
        } else {
            nav.navigationBar.isTranslucent = false
            nav.navigationBar.barTintColor = UIColor.primary()
        }
        return nav
    }
    
    static func createLoadingFullScreen(offset: Int = 0) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor.white
        let stackContainer = UIStackView()
        stackContainer.alignment = .center
        stackContainer.axis = .vertical
        container.addSubview(stackContainer)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: stackContainer)
        container.addConstraintsWithFormat("V:|-0-[v0]-\(offset)-|", views: stackContainer)
        
        let spiner = UIActivityIndicatorView()
        spiner.color = UIColor.darkGray
        stackContainer.addArrangedSubview(spiner)
        
        spiner.startAnimating()
        return container
    }
    
    static func addSubView(loadingView: UIView, to view: UIView) {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: loadingView)
        view.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: loadingView)
    }
    
    static func createLoadingNavbar() -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor.white
        let stackContainer = UIStackView()
        stackContainer.alignment = .fill
        stackContainer.axis = .vertical
//        stackContainer.layoutMargins = UIEdgeInsetsMake(0, 0, 200, 0)
        container.addSubview(stackContainer)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraintsWithFormat("H:|-0-[v0]-(0)-|", views: stackContainer)
        container.addConstraintsWithFormat("V:|-0-[v0]-(32)-|", views: stackContainer)
        
        let spiner = UIActivityIndicatorView()
        spiner.color = UIColor.darkGray
        stackContainer.addArrangedSubview(spiner)
        spiner.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.addConstraintsWithFormat("H:[v0(100@999)]", views: spiner)
        stackContainer.addConstraintsWithFormat("V:[v0(100@999)]", views: spiner)
        
        spiner.startAnimating()
        return container
    }
    
    static func createEmptyState(controller: UIViewController, action: Selector) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(hex: 0xF4F4F4)
        let stackContainer = UIStackView()
        stackContainer.alignment = .fill
        stackContainer.axis = .vertical
        //        stackContainer.layoutMargins = UIEdgeInsetsMake(0, 0, 200, 0)
        container.addSubview(stackContainer)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraintsWithFormat("H:|-0-[v0]-(0)-|", views: stackContainer)
        container.addConstraintsWithFormat("V:|-(>=0)-[v0]-(>=0)-|", views: stackContainer)
        stackContainer.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        let stackImage = UIStackView()
        stackImage.alignment = .center
        stackImage.axis = .vertical
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "empty_state")
        stackImage.addArrangedSubview(imageView)
        stackImage.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackImage.addConstraintsWithFormat("H:[v0(100@999)]", views: imageView)
        stackImage.addConstraintsWithFormat("V:[v0(100@999)]", views: imageView)
        stackContainer.addArrangedSubview(stackImage)
        
        let text = UILabel()
        text.font = UIFont.systemFont(ofSize: 12)
        text.textColor = UIColor.lightGray
        text.numberOfLines = 2
        text.textAlignment = .center
        text.text = "Data belum tersedia"
        stackContainer.addArrangedSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        stackContainer.addArrangedSubview(separator)
        stackContainer.addConstraintsWithFormat("V:[v0(8@999)]", views: separator)
        
        let buttonRefresh = UIButton()
        buttonRefresh.setTitle("Refresh", for: .normal)
        buttonRefresh.setTitleColor(UIColor.black, for: .normal)
        buttonRefresh.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        stackContainer.addArrangedSubview(buttonRefresh)
        buttonRefresh.addTarget(controller, action: action, for: .touchUpInside)
        
        return container
    }
    
    static func createMessageView(message: String?) -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        container.backgroundColor = UIColor.white
        let stackContainer = UIStackView(frame: container.frame)
        stackContainer.alignment = .center
        stackContainer.axis = .vertical
        container.addSubview(stackContainer)
        container.addConstraintsWithFormat("H:|-0-[v0]-0-|", views: stackContainer)
        container.addConstraintsWithFormat("V:|-0-[v0]-0-|", views: stackContainer)
        
        let labelMessage = UILabel()
        labelMessage.font = UIFont.systemFont(ofSize: 14)
        labelMessage.textAlignment = .center
        labelMessage.text = message ?? ""
        
        stackContainer.addArrangedSubview(labelMessage)
        
        return container
    }
    
    static func createPersonView(image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        _ = imageView.addConstraintsWithFormat("H:[v0(30)]", views: imageView)
        _ = imageView.addConstraintsWithFormat("V:[v0(30)]", views: imageView)
        imageView.circlifyImage(opacity: 0, radius: 0, heightOffset: 0)
        
        return imageView
    }
    
    static func createAlert(title: String? = nil, message: String? = nil, singleAction: Bool = true) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    static func createTextDialog(title: String?, message: String?, agreeText: String = "OK", cancelText: String = "Cancel", agreeHandler: ((UIAlertAction) -> Swift.Void)? = nil, cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .emailAddress
            textField.placeholder = "Email"
        }
        alert.addAction(UIAlertAction(title: agreeText, style: .default, handler: agreeHandler))
        alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: cancelHandler))
        return alert
    }
    
    static func createAlertDialog(title: String?, message: String?, agreeText: String = "OK", cancelText: String = "Cancel", agreeHandler: ((UIAlertAction) -> Swift.Void)? = nil, cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: agreeText, style: .default, handler: agreeHandler))
        alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: cancelHandler))
        return alert
    }
    
    static func createActionSheet(title: String? = nil, message: String? = nil,actions: UIAlertAction...) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alertAction in
            alert.addAction(alertAction)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
    
}
