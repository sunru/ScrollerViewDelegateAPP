//
//  ScrollMethodViewController.swift
//  ScrollerViewDelegateAPP
//
//  Created by 廖晨如 on 2022/12/24.
//

import UIKit

class ScrollMethodViewController: UIViewController {

    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet var starImageView: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func changeImage(_ sender: UIPageControl) {
        //用Scroll View的寬乘以當前頁數，得到Scroll View應該捲動到的x座標
        let newPoint = CGPoint(x: imageScrollView.bounds.width * CGFloat(sender.currentPage), y: 0)
        //設定Scroll View應該捲動到的新座標為剛剛算出來newPoint
        imageScrollView.setContentOffset(newPoint, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScrollMethodViewController: UIScrollViewDelegate{// called when scroll view grinds to a halt
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //偵測滑動止時到第幾頁去更新page control
        //contentOffset.x是ScrollView捲動的值，除以ScrollView 的寬就可以得到現在應該是捲動到第幾頁
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        //設定currentPage更新為捲動到的頁數
        imagePageControl.currentPage = Int(page)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView?{ // return a view that will be scaled. if delegate returns nil, nothing happens
        //以Page Control的所在頁數判斷現在是哪一張圖片要進行縮放動作
        return starImageView[imagePageControl.currentPage]
    }
}

