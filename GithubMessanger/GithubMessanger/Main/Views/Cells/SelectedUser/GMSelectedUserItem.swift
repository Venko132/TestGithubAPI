//
//  GMSelectedUserItem.swift
//  GithubMessanger
//
//  Created by Dream Store on 30.04.2021.
//

import UIKit

class GMSelectedUserItem: UICollectionViewCell {

    //MARK: IBOutlets
    @IBOutlet private weak var lblUsername: UILabel!
    @IBOutlet private weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnRemove: UIButton!
    
    //MARK: Properties
    weak var delegateActionInCell: GMProtocolActionInCell? = nil
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareParameters()
        clearFields()
    }

    override func prepareForReuse() {
        clearFields()
    }
    
    private func prepareParameters() {
        self.imgAvatar.layer.cornerRadius = GMSelectedUsersPresenter.cellWidth / 2 - 5
        self.imgAvatar.layer.masksToBounds = true
        self.imgAvatar.layer.borderColor = UIColor.gray.cgColor
        self.imgAvatar.layer.borderWidth = 2
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.backgroundColor = .blue
        
    }
    
    private func clearFields() {
        self.imgAvatar.image = nil
        self.lblUsername.text = nil
    }
    
    //MARK: Methods
    func configure(_ vm: GMSelectedUserItemViewModel) {
        self.lblUsername.text = vm.username()
        guard let url = vm.avatarUrl() else { return }
        self.imgAvatar.af.setImage(withURL: url)
    }
    
    //MARK: Actions
    @IBAction private func actionRemove(_ sender: AnyObject) {
        GMHelperHandler.blockedInteractionEvents()
        
        self.delegateActionInCell?.actionUserPressSender(sender)
    }
}
