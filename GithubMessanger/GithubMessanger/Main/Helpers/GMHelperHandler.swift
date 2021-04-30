import Foundation
import UIKit

class GMHelperHandler {
    //MARK: Properties
    fileprivate var alertView: GMAlertController?
    
    //MARK: Instance
    static let sharedInstance = GMHelperHandler()
    private init() {
    }
}

//MARK: Methods
extension GMHelperHandler {
    //MARK: Alert
    class func showAlert(title: String? = "Error", message: String?) {
        
        DispatchQueue.main.async (flags: .barrier) {
            
            if GMHelperHandler.sharedInstance.alertView != nil {
                return
            }
            
            GMHelperHandler.sharedInstance.alertView = GMAlertController(title: title, message: message, preferredStyle: .alert)
            GMHelperHandler.sharedInstance.alertView?.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                GMHelperHandler.sharedInstance.alertView = nil
            }))
            GMHelperHandler.sharedInstance.alertView?.show()
        }
    }
    
    //MARK: TopMostViewController
    class func topMostViewController() -> UIViewController? {
        return GMHelperHandler.topViewControllerForRoot(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    class func topViewControllerForRoot(rootViewController:UIViewController?) -> UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        guard let presented = rootViewController.presentedViewController else {
            return rootViewController
        }
        
        switch presented {
        case is UINavigationController:
            let navigationController:UINavigationController = presented as! UINavigationController
            return GMHelperHandler.topViewControllerForRoot(rootViewController: navigationController.viewControllers.last)
            
        case is UITabBarController:
            let tabBarController:UITabBarController = presented as! UITabBarController
            return GMHelperHandler.topViewControllerForRoot(rootViewController: tabBarController.selectedViewController)
            
        default:
            return GMHelperHandler.topViewControllerForRoot(rootViewController: presented)
        }
    }
    
    
    //MARK: Blocked Touches
    class func blockedInteractionEvents(time: Double = 0.3, contentView: UIView? = nil, _ handler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            contentView?.isUserInteractionEnabled = false
            UIApplication.shared.beginIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                UIApplication.shared.endIgnoringInteractionEvents()
                contentView?.isUserInteractionEnabled = true
                if (handler != nil) {
                    handler!()
                }
            }
        }
    }
    
    //MARK: Controller
    class func getController(_ vcIdentifier: String, forStoryboardName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: forStoryboardName, bundle: nil)
        let vcController = storyboard.instantiateViewController(withIdentifier: vcIdentifier)
        
        return vcController
    }
}
