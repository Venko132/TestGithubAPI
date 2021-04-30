import UIKit

public class GMAlertController: UIAlertController {
    
    private lazy var alertWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = GMAlertController()
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindow.Level.alert
        return window
    }()
    
    public func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        if let rootViewController = alertWindow.rootViewController {
            alertWindow.makeKeyAndVisible()
            
            rootViewController.present(self, animated: flag, completion: completion)
        }
    }
    
}
