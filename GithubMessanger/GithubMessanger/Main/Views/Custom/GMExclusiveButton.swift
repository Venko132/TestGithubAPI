import UIKit

class GMExclusiveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareParameters()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareParameters()
    }
    
    func prepareParameters() {
        self.layer.masksToBounds = true
        self.isExclusiveTouch = true
    }
    
}
