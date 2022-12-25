//
//  CollectionMethodViewController.swift
//  ScrollerViewDelegateAPP
//
//  Created by 廖晨如 on 2022/12/24.
//

import UIKit

class CollectionMethodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    func setupFlowLayout(){
            let flowLayout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.itemSize = imageCollectionView.bounds.size //項目的預設大小為collection view的大小
            flowLayout?.estimatedItemSize = .zero
            flowLayout?.minimumInteritemSpacing = 0 //同一行項目間的最小距離
            flowLayout?.minimumLineSpacing = 0 //行跟行之間的最小距離
            flowLayout?.sectionInset = .zero //section的邊距
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        setupFlowLayout()
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //圖片數量
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionMethodViewCell.self)", for: indexPath) as? CollectionMethodViewCell else{
            fatalError("dequeueReusableCell CollectionMethodViewCell failed")
        }
            
        cell.moonImageView.image = UIImage(named: "moon\(indexPath.item + 1)")
        return cell
    }
    
    //UICollectionViewDelegate optional func: 會在物件被加進去之前先呼叫此 function，我們可以在這裡對物件做額外的設置
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        guard let collectionViewCell = cell as? CollectionMethodViewCell else{
            fatalError("willDisplay UICollectionViewCell failed")
        }
        collectionViewCell.updateScrollerViewZoom()
        //呼叫updateScrollerViewZoom function設定cell要顯示的初始狀態
        //updateScrollerViewZoom的function寫在CollectionMethodViewCell的Class中
    }
   
    
    
    @IBAction func chagePage(_ sender: UIPageControl) {
        
        //畫面捲動是靠collection view執行，所以用collection View的寬乘以當前頁數，來得到collection view應該捲動到的x座標
        let newPoint = CGPoint(x: imageCollectionView.bounds.width * CGFloat(sender.currentPage), y: 0)
        //設定collection View應該捲動到的新座標為剛剛算出來newPoint
        imageCollectionView.setContentOffset(newPoint, animated: true)
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
extension CollectionMethodViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        imagePageControl.currentPage = Int(page)
    }
}
