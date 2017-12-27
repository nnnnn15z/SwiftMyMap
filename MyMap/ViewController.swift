//
//  ViewController.swift
//  MyMap
//
//  Created by ryo.takahashi on 2017/12/27.
//  Copyright © 2017年 ryo.takahashi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを引っ込める
        textField.resignFirstResponder()
        
        // テキストフィールドに入力された値を取り出す
        let searchKeyword = textField.text!
        
        print(searchKeyword)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKeyword, completionHandler: {
            (placemarks: [CLPlacemark]?,error:Error?) in
            // placemarksに検索結果リストが出る
            // 0番目が最も近い場所の位置情報
            if let placemark = placemarks?[0] {
                if let targetCoordinate = placemark.location?.coordinate {
                    // 位置情報データ
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = searchKeyword
                    
                    // ピンのアノテーション
                    self.displayMap.addAnnotation(pin)
                    //　表示する範囲
                    self.displayMap.region =
                        MKCoordinateRegionMakeWithDistance(targetCoordinate, 500.0, 500.0)
                    
                    
                }
            }
        })
        
        return true
    }


}

