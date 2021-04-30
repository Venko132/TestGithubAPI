//
//  GMGithubUserCell.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import UIKit
import AlamofireImage

class GMGithubUserCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet private weak var lblUsername: UILabel!
    @IBOutlet private weak var lblUrl: UILabel!
    @IBOutlet private weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnCheck: UIButton!
    
    //MARK: Properties
    weak var delegateActionInCell: GMProtocolActionInCell? = nil
    
    //MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareParameters()
        clearFields()
    }
    
    override func prepareForReuse() {
        clearFields()
    }

    private func prepareParameters() {
        self.imgAvatar.layer.cornerRadius = GMSelectUserTablePresenter.cellHeight / 2 - 7
        self.imgAvatar.layer.masksToBounds = true
        self.imgAvatar.layer.borderColor = UIColor.gray.cgColor
        self.imgAvatar.layer.borderWidth = 2
        self.imgAvatar.contentMode = .scaleAspectFill
        self.imgAvatar.backgroundColor = .blue
        
        self.btnCheck.setImage(UIImage.init(named: "baseline_radio_button_unchecked"), for: .normal)
        self.btnCheck.setImage(UIImage.init(named: "baseline_radio_button_checked"), for: .selected)
        
        clearFields()
    }
    
    private func clearFields() {
        self.imgAvatar.image = nil
        self.lblUrl.text = nil
        self.lblUsername.text = nil
    }
    
    //MARK: Methods
    func configure(_ vm: GMGithubUserCellViewModel) {
        self.lblUsername.text = vm.username()
        self.lblUrl.text = vm.userPageLink()
        guard let url = vm.avatarUrl() else { return }
        self.imgAvatar.af.setImage(withURL: url)
    }
    
    //MARK: Actions
    @IBAction private func actionSelect(_ sender: AnyObject) {
        GMHelperHandler.blockedInteractionEvents()
        
        self.delegateActionInCell?.actionUserPressSender(sender)
    }
}
