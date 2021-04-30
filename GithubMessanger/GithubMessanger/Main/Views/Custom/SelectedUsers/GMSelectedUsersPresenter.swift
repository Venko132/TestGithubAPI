import Foundation
import UIKit

class GMSelectedUsersPresenter : NSObject {
    static let cellWidth: CGFloat = 80.0
    static let cellHeight: CGFloat = 110.0
    
    //MARK: Properties
    private(set) var viewModel: GMSelectUserViewModel
    private(set) var cltView: UICollectionView
    weak var delegate: GMProtocolActionInCell? = nil
    
    //MARK: Init
    init(vm viewModel: GMSelectUserViewModel, collection: UICollectionView, delegate: GMProtocolActionInCell? = nil) {
        self.viewModel = viewModel
        self.cltView = collection
        self.delegate = delegate
        
        super.init()
        self.cltView.delegate = self
        self.cltView.dataSource = self
        
        regiterNib(GMSelectedUserItem.kIdentifier)
    }
    
    //MARK: Methods
    func reloadTable() {
        self.cltView.reloadData()
    }
    
    private func regiterNib(_ identifier: String) {
        let nib = UINib.init(nibName: identifier, bundle: nil)
        self.cltView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension GMSelectedUsersPresenter: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = self.viewModel.selectedUsers.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        cell = configureCell(at: indexPath)
        return cell
    }
    
    private func configureCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.cltView.dequeueReusableCell(withReuseIdentifier: GMSelectedUserItem.kIdentifier, for: indexPath) as! GMSelectedUserItem
        
        let user = Array(self.viewModel.selectedUsers)[indexPath.item]
        cell.configure(GMSelectedUserItemViewModel(data: user))
        cell.delegateActionInCell = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  GMSelectedUsersPresenter.cellWidth, height:  GMSelectedUsersPresenter.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK:- WLProtocolSelectCell
extension GMSelectedUsersPresenter: GMProtocolActionInCell {
    func actionUserPressSender(_ sender: AnyObject) {
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: self.cltView)
        let indexPath = self.cltView.indexPathForItem(at: buttonPosition)
        
        guard let _indexPath = indexPath, _indexPath.item < self.viewModel.listUsers.count else { return }
        self.viewModel.removeSelectedUser(Array(self.viewModel.selectedUsers)[_indexPath.item])
        //self.cltView.reloadData()
        NotificationCenter.default.post(name: Constants.Notification.updateUI.notificationName(), object: nil)
    }
}
