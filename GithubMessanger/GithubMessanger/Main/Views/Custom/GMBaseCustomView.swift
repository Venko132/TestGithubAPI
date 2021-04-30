import Foundation
import UIKit

class GMBaseCustomView: UIView {
    
    //MARK: IBOutlets
    @IBOutlet weak private(set) var vwView: UIView!
    
    //MARK: Properties
    
    //MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        prepareParameters()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        prepareParameters()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: Prepare parameters
    func prepareParameters() { }
    
    //MARK: Setup view
    func setupView() {
        
        let view = loadNib()
        self.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let dicViews = Dictionary(dictionaryLiteral: ("view", view))
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|-0.0-[view]-0.0-|", options: [], metrics: nil, views: dicViews)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0.0-[view]-0.0-|", options: [], metrics: nil, views: dicViews)
        
        self.addConstraints(hConstraints)
        self.addConstraints(vConstraints)
        
        self.vwView = view
    }
    
    func loadNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nameOfClass, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
