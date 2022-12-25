//
//  pageViewController.swift
//  ScrollerViewDelegateAPP
//
//  Created by 廖晨如 on 2022/12/25.
//

import UIKit
//宣告一個自定義的 protocol，用來傳遞頁數總共幾頁、當前頁數的資訊給在 Root View Controller 的 Page Control
protocol pageViewControllerDelegate: AnyObject{
    
    func numberOfPage(numberOfPage: Int) //總頁數
    func pageIndex(index: Int) //當前頁數
}
class pageViewController: UIPageViewController {
    //宣告儲存子畫面 View Controller 的 Array
    var viewControllerList = [UIViewController]()
    //宣告 PageViewControllerDelegate
    weak var pageViewControllerDelegate: pageViewControllerDelegate?
    //宣告透過 Storyboard ID 取得子畫面 View Controller 的 function
    func getViewController( _ storyboardID: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }
    //設定點選 Page Control 時子畫面的翻頁的方向
    func goToPage(index: Int) {
        //讀取當前頁面
        let currentViewController = viewControllers!.first!
        //讀取當前頁數
        let currentViewControllerIndex = viewControllerList.firstIndex(of: currentViewController)!
        //如果點選Page Control所得到的index值大於當前頁數的值，代表應該繼續往後翻
        if index > currentViewControllerIndex{
            setViewControllers([viewControllerList[index]], direction: .forward, animated: true, completion: nil)
        //如果點選Page Control所得到的index值小於當前頁數的值，代表應該往前翻
        }else if index < currentViewControllerIndex{
            setViewControllers([viewControllerList[index]], direction: .reverse, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //在 viewDidLoad 中用 Storyboard ID 生成子畫面 View Controller，加到剛剛宣告的 Array 中
        viewControllerList.append(getViewController("FirstViewController"))
        viewControllerList.append(getViewController("SecondViewController"))
        viewControllerList.append(getViewController("ThirdViewController"))
        //設定首頁
        setViewControllers([viewControllerList[0]], direction: .forward, animated: true, completion: nil)
        
        //設定 pageViewController 本身代理 dataSource(UIPageViewControllerDataSource)
        self.dataSource = self
        //設定 pageViewController 本身代理 delegate(UIPageViewControllerDelegate)
        self.delegate = self
        
        //儲存總頁數到自定義 Delegate 的 numberOfPage -> 回傳到 Root View Controller
        pageViewControllerDelegate?.numberOfPage(numberOfPage: viewControllerList.count)
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

extension pageViewController: UIPageViewControllerDataSource{
    //往前翻頁的邏輯
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //取得當前的頁數
        if let currentPageIndex = viewControllerList.firstIndex(of: viewController){
            //如果等於0，表示當前已經是第一頁，往前翻不產生動作
            if currentPageIndex == 0{
                return nil
            }else{//如果不等於0，往前翻
                return viewControllerList[currentPageIndex - 1]
            }
        }else{
            return nil
        }
    }
    //往後翻頁的邏輯
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //取得當前的頁數
        if let currentPageIndex = viewControllerList.firstIndex(of: viewController){
            //如果等於0，表示當前已經是最後一頁，往後翻不產生動作
            if currentPageIndex == viewControllerList.count - 1{
                return nil
            }else{//如果不是最後一頁，往後翻
                return viewControllerList[currentPageIndex + 1]
            }
        }else{
            return nil
        }
    }
    
    
}

extension pageViewController: UIPageViewControllerDelegate{
    //設定翻頁完執行的動作
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        //讀取當前的子畫面
        let currentPageViewController = (viewControllers?.first)!
        //讀取當前的頁數
        let currentIndex = viewControllerList.firstIndex(of: currentPageViewController)!
        //儲存當前頁數到自定義 Delegate 的 pageIndex -> 回傳到 Root View Controller
        pageViewControllerDelegate?.pageIndex(index: currentIndex)
        
    }
}
