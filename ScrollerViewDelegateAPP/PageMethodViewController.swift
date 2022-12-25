//
//  PageMethodViewController.swift
//  ScrollerViewDelegateAPP
//
//  Created by 廖晨如 on 2022/12/25.
//

import UIKit

class PageMethodViewController: UIViewController, pageViewControllerDelegate {
    
    

    @IBOutlet weak var pageControl: UIPageControl!
    var pageViewController: pageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //透過 prepare(for:sender:) 代理 pageViewControllerDelegate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destinationPageViewController = segue.destination as? pageViewController {
                // 代理自定義的 pageViewControllerDelegate
                pageViewController = destinationPageViewController
                pageViewController.pageViewControllerDelegate = self
            }
        }
    
    //實作 pageViewControllerDelegate function
    func numberOfPage(numberOfPage: Int) {//設定總頁數
        pageControl.numberOfPages = numberOfPage
    }
    
    func pageIndex(index: Int) {//設定當前頁數
        pageControl.currentPage = index
    }
    
    
    @IBAction func changePage(_ sender: UIPageControl) {
        //讀取點選Page Control後，sender回傳的頁數
        let currentPageIndex = sender.currentPage
        pageViewController.goToPage(index: currentPageIndex)
        
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
