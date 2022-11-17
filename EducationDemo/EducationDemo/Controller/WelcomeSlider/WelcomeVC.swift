//
//  WelcomeVC.swift
//  EducationDemo
//
//  Created by ALOK on 16/11/22.
//

import UIKit


class WelcomeVC: UIViewController {
    
    //MARK:- IBOutlets...
    
    @IBOutlet weak var collectionView_slider : UICollectionView!
    @IBOutlet weak var pageControl : UIPageControl!
    
    var sliders_count:Int = 3
    
    var imagesArray = ["1","2","3"]
    
    var textArray = ["Start your journey in University","Start your journey in School","Start your journey in Firm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //pageControl.numberOfPages = sliders_count
        //pageControl.transform = pageControl.transform.scaledBy(x: 1.4, y: 1.4)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        pageControl.updateRadius()
    }
    
  

}



extension WelcomeVC{
    
    @IBAction func registerClicked(_:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func loginClicked(_:UIButton){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension WelcomeVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK:- CollectionView Delegates...
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliders_count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.sliderImage.image = UIImage(named: self.imagesArray[indexPath.row])
        cell.sliderText.text = self.textArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        //return CGSize(width: collectionView_slider.frame.size.width, height: collectionView_slider.frame.size.height)
        return CGSize(width: self.view.frame.size.width, height: collectionView_slider.frame.size.height)
    }
    
}

extension WelcomeVC{
    
    //MARK:- ScrollView Delegates...
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        //self.pageControl.currentPage = Int(offset / collectionView_slider.frame.size.width)
    }
}


extension UIPageControl {

    func updateRadius(){
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.layer.cornerRadius = 0
            }else{
                dotView.layer.cornerRadius = 0
            }
        }
    }
    
    
    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }

}
