//
//  GMComposeMessageController.swift
//  GithubMessanger
//
//  Created by Dream Store on 29.04.2021.
//

import UIKit
import MultilineTextField
import IQKeyboardManagerSwift

class GMComposeMessageController: GMBaseController {

    //MARK: IBOutlets
    @IBOutlet private weak var vwSelectedUsers: GMSelectedUsersView!
    @IBOutlet private weak var vwPlaceholder: UIView!
    @IBOutlet private weak var txtField: MultilineTextField!
    @IBOutlet private weak var btnSend: UIButton!
    
    //MARK: Properties
    var viewModel: GMSelectUserViewModel!
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.tintColor = UIColor.black
        
        toolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(actionDone))
        
        toolbar.items = [flexBarButton, doneBarButton]
        
        return toolbar
    }()
    
    //MARK: LifeCyce
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure(vm: GMSelectUserViewModel) {
        self.viewModel = vm
    }
    
    override func prepareParameters() {
        NotificationCenter.default.addObserver(self, selector: #selector(upateUI), name: Constants.Notification.updateUI.notificationName(), object: nil)
        
        self.txtField.isEditable = true
        
        IQKeyboardManager.shared.registerTextFieldViewClass(MultilineTextField.self, didBeginEditingNotificationName: UITextField.textDidBeginEditingNotification.rawValue, didEndEditingNotificationName: UITextField.textDidEndEditingNotification.rawValue)
        
        self.txtField.inputAccessoryView = self.toolbar
        self.txtField.delegate = self
        
        self.btnSend.setTitleColor(UIColor.lightGray, for: .disabled)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(pressBack))
        self.navigationItem.title = "Compose Message"
        
        
        self.vwPlaceholder.layer.borderWidth = 1.0
        self.vwPlaceholder.layer.borderColor = UIColor.lightGray.cgColor
        
        self.vwSelectedUsers.configure(vm: self.viewModel)
        upateUI()
    }
    
    @objc private func upateUI() {
        self.btnSend.isEnabled = self.viewModel.atLeastOneUserIsSelected()
        self.vwSelectedUsers.upateUI()
    }
    
    @objc private func pressBack() {
        actionBack()
    }

    //MARK: Actions
    @IBAction private func actionSend(_ sender: AnyObject) {
        GMHelperHandler.blockedInteractionEvents()
        
        startProgress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self]() in
            guard let weakSelf = self else { return }
            
            weakSelf.endProgress()
            weakSelf.viewModel.deselectAllUsers()
            
            NotificationCenter.default.post(name: Constants.Notification.updateUI.notificationName(), object: true)
            
            weakSelf.actionBack()
        }
    }
    
    @objc private func actionDone() {
        GMHelperHandler.blockedInteractionEvents()
        self.txtField.resignFirstResponder()
    }
}

//MARK:- UITextViewDelegate
extension GMComposeMessageController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let textFieldRange = NSRange(location: 0, length: textView.text?.count ?? 0)
        self.btnSend.isEnabled = NSEqualRanges(range, textFieldRange) && text.count == 0 ? false : true
        
        return true
    }
}
