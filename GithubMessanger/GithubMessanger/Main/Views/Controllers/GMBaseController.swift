import UIKit
import MBProgressHUD

class GMBaseController: UIViewController, GMProtocolProgress {
    
    //MARK: Properties
    public private(set) var progressHUD: MBProgressHUD?
    public private(set) lazy var refreshControl: UIRefreshControl = {
        let _refresh = UIRefreshControl()
        _refresh.addTarget(self, action: #selector(listPulledDown(_:)), for: .valueChanged)
        return _refresh
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardOnTapEmptySpace()
        prepareParameters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func hideKeyboardOnTapEmptySpace() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    //MARK: Methods
    func prepareParameters() {
    }
    
    func configureBackButton() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: UIBarButtonItem.Style.done, target: nil, action: nil)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: WLProtocolProgress
    func startProgress() {
        guard self.progressHUD == nil else { return }
        self.progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func endProgress() {
        self.progressHUD?.hide(animated: true)
        self.progressHUD = nil
    }
    
    func startProgressWithTitle(_ title: String?) {
        guard self.progressHUD == nil else { return }
        self.progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.progressHUD?.label.text = title
    }

    func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Pull refresh
    @objc public func listPulledDown(_ sender: UIRefreshControl) {
        
    }
}
