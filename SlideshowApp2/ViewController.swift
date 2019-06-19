import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slideShow : UIImageView!
    var imageIndex = 0
    var timer : Timer!
    let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 受け取った画像をImageViewに設定する
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
    //引数がsenderだ！！next imageというアクションが起きたany型のUIbuttumがsenderに入る
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
    @IBAction func playImage(_ sender: Any){
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(onTimer(_:)), userInfo: nil, repeats: true)
            //ここ解説https://pg-happy.jp/swift-scheduledtimer.html
        }
        else {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
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
    
    // ①セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        detailViewController.image = slideShow.image
    }
    }
    
    // go to next view
    @IBAction func tapAction(_ sender: Any) {
        // セグエを使用して画面を遷移
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    // back to top view
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}
