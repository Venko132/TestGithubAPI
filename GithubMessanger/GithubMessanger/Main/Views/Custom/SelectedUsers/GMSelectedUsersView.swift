import Foundation
import UIKit

class GMSelectedUsersView: GMBaseCustomView {
    //MARK: IBOutlets
    @IBOutlet weak var cltUsers: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: Properties
    private var viewModel: GMSelectUserViewModel! = nil
    private var cltPresenter: GMSelectedUsersPresenter!
    
    //MARK: Methods
    override func prepareParameters() {
        super.prepareParameters()
        
        self.lblTitle.text = "No users selected"
        self.cltUsers.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(upateUI), name: Constants.Notification.updateUI.notificationName(), object: nil)
    }
    
    func configure(vm: GMSelectUserViewModel) {
        self.viewModel = vm
        self.cltPresenter = GMSelectedUsersPresenter(vm: self.viewModel, collection: self.cltUsers, delegate: self)
        
        clearFields()
    }
    
    private func clearFields() {
        self.cltUsers.isHidden = self.viewModel.selectedUsers.count == 0 ? true : false
        self.cltPresenter.reloadTable()
    }
    
    @objc func upateUI() {
        clearFields()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK:- GMProtocolActionInCell
extension GMSelectedUsersView: GMProtocolActionInCell {
    func actionUserPressSender(_ sender: AnyObject) {
        
    }
}
