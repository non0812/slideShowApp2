import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slideShow : UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var imageIndex = 0
    var timer : Timer!
    let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow.image = images[0]
    }
    
    // back button
    @IBAction func backImage(_ sender: Any){
        if self.timer == nil {
            if imageIndex == 0 {
                imageIndex = 2
            }
            else {
                imageIndex -= 1
            }
        }
        slideShow.image = images[imageIndex]
    }
    
    // next button
    @IBAction func nextImage(_ sender: Any){
        if self.timer == nil {
            if imageIndex == 2 {
                imageIndex = 0
            }
            else {
                imageIndex += 1
            }
            slideShow.image = images[imageIndex]
        }
    }
    
    // play & stop button
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBAction func playImage(_ sender: Any){
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(onTimer(_:)), userInfo: nil, repeats: true)
            btnPlayPause.setTitle("停止", for: UIControl.State.normal)
            btnNext.isEnabled = false
            btnBack.isEnabled = false
        }
        else {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            btnPlayPause.setTitle("再生", for: UIControl.State.normal)
            btnNext.isEnabled = true
            btnBack.isEnabled = true
        }
    }

    
    @objc func onTimer(_ timer : Timer) {
        if imageIndex == 2 {
            imageIndex = 0
        }
        else {
            imageIndex += 1
        }
        slideShow.image = images[imageIndex]
    }
    
    // DetailViewControllerのimageにslideShowを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        detailViewController.image = slideShow.image
    }
    
    // go to next view
    @IBAction func tapAction(_ sender: Any) {
        // セグエを使用して画面を遷移
        performSegue(withIdentifier: "detail", sender: nil)
       
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
       
        btnPlayPause.setTitle("再生", for: UIControl.State.normal)
        btnNext.isEnabled = true
        btnBack.isEnabled = true
    }
    
    // back to top view
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}
