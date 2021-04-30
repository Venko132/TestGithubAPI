import Foundation
import UIKit

class GMSelectUserCoordinator {
    
    //MARK: Properties
    fileprivate weak var navController: UINavigationController?
    
    //MARK: LifeCycle
    init(navController: UINavigationController?) {
        self.navController = navController
    }
    
    func routeToComposeMessage(vm: GMSelectUserViewModel) {
        let vc = GMHelperHandler.getController(GMComposeMessageController.kIdentifier, forStoryboardName: "Main") as! GMComposeMessageController
        
        vc.configure(vm: vm)
        self.navController?.pushViewController(vc, animated: true)
    }
}
