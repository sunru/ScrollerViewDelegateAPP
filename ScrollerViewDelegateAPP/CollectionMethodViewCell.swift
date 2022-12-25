//
//  CollectionMethodViewCell.swift
//  ScrollerViewDelegateAPP
//
//  Created by 廖晨如 on 2022/12/24.
//

import UIKit

class CollectionMethodViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var moonImageView: UIImageView!
    
    //讓scroll view 內的圖片縮放時維持置中
    func updateScrollerViewContentInset(){
        //讀取圖片的寬跟高
        if let imageWidth = moonImageView.image?.size.width,
            let imageHeight = moonImageView.image?.size.height{
            //計算圖片等比例縮小到能放進顯示框中的時候，圖片寬跟高與顯示框的寬跟高的留白差距，因為置中時圖片左右兩邊或上下兩邊跟顯示框的距離會是一樣的，所以除以2
            let insetWidth = (bounds.width - imageWidth * imageScrollView.zoomScale) / 2
            let insetHeight = (bounds.height - imageHeight * imageScrollView.zoomScale) / 2
            // scroll view 內容的上下左右可加入稱為 contentInset 的空白區塊
            imageScrollView.contentInset = .init(top: max(insetHeight, 0), left: max(insetWidth, 0), bottom: 0, right: 0)
        }
    }
    
    //scroll view 內的圖片縮放
    func updateScrollerViewZoom(){
        if let imageSize = moonImageView.image?.size{
            
            //計算顯示框的寬跟高和圖片的寬跟高的比率
            let widthScale = bounds.size.width / imageSize.width
            let heightScale = bounds.size.height / imageSize.height
            
            //兩者間較小的比率就是圖片能縮放到完整顯示在顯示框的比率
            let scale = min(widthScale, heightScale)
            imageScrollView.minimumZoomScale = scale //scroll view內容最小的縮放範圍
            imageScrollView.maximumZoomScale = max(widthScale, heightScale) //scroll view內容的最大的縮放範圍
            imageScrollView.zoomScale = scale //scroll view內容大小的初始值
            
            //scrollViewDidZoom有可能還沒處發，所以這邊先呼叫一次
            updateScrollerViewContentInset()
        }
    }
}
extension CollectionMethodViewCell: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {// return a view that will be scaled. if delegate returns nil, nothing happens
       return moonImageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView){ // any zoom scale changes
        updateScrollerViewContentInset()
    }
}
