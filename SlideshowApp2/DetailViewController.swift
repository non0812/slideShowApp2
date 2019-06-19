import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var detailImage : UIImageView!
    
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailImage.image = image
    }
    
}
