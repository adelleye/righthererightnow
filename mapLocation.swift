//  ViewController.swift
//  googleMapsTest
//
//  Created by Oluwatobi Adeleye on 2015-05-09.
//  Copyright (c) 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

var longz = Double()
var latz = Double()

var steps = String()

var addy = ""
var country_selected = ""



class mapLocation: ServerContactViewController, GMSMapViewDelegate {
    
    var button = UIButton()
    var backbutton = UIButton()
    var selectAddressButton = UIButton()
    
    var marker = GMSMarker()
    var width:CGFloat = CGFloat()
    var height:CGFloat = CGFloat()
    var scrn = UIScreen.main.bounds
    
    
    let gpaViewController = GooglePlacesAutocomplete( apiKey: "AIzaSyCKtrsYWkLOWzLRoOO68qeX-j6CQ0IoTiI",
        placeType: .address)
    //var mapViews = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //println("latitude is \(latz)")
        
        longz = (longitudee as NSString).doubleValue
        latz = (latitudee as NSString).doubleValue

        
        setupMap()
        
           }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
    func setupMap() {
        
        let camera = GMSCameraPosition.camera(withLatitude: latz,
            longitude: longz, zoom: 12)
        let mapViews = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapViews?.delegate = self
        mapViews?.isMyLocationEnabled = true
        self.view = mapViews
        width = scrn.size.width
        height = scrn.size.height
        
        mapViews?.settings.myLocationButton = false
        mapViews?.settings.indoorPicker = true
        mapViews?.settings.compassButton = true
        marker.title = addy
        //marker.snippet = "Australia"
        marker.map = mapViews
        
        gpaViewController.placeDelegate = self
        
        
        button = UIButton(frame: CGRect(x: width*0.5, y: height-100, width: width*0.5, height: 50))
        button.setTitle("Search", for: UIControlState())
        button.setTitle("Search", for: UIControlState.highlighted)
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        button.addTarget(self, action: #selector(mapLocation.mapSearchAction(_:)), for: UIControlEvents.touchUpInside)
        
        
        backbutton = UIButton(frame: CGRect(x: 10, y: 0, width: 80, height: 68))
        backbutton.setTitle("back", for: UIControlState())
        backbutton.setTitle("back", for: UIControlState.highlighted)
        backbutton.setTitleColor(UIColor(red: 56.0/255.0, green: 187.0/255.0, blue: 204.0/255.0, alpha: 1.0), for: UIControlState())
        backbutton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        // backbutton.backgroundColor = UIColor.whiteColor()
        backbutton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        backbutton.addTarget(self, action: #selector(mapLocation.backAction(_:)), for: UIControlEvents.touchUpInside)
        
        
        selectAddressButton = UIButton(frame: CGRect(x: 0, y: height-50, width: width, height: 50))
        selectAddressButton.setTitle("Select Address", for: UIControlState())
        selectAddressButton.setTitle("Select Address", for: UIControlState.highlighted)
        selectAddressButton.setTitleColor(UIColor.white, for: UIControlState())
        selectAddressButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        selectAddressButton.backgroundColor = UIColor(red: 56.0/255.0, green: 187.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        selectAddressButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        selectAddressButton.addTarget(self, action: #selector(mapLocation.selectAddressAction(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        
        mapViews?.addSubview(button)
        mapViews?.addSubview(backbutton)
        mapViews?.addSubview(selectAddressButton)
        
        
        marker.position = CLLocationCoordinate2DMake(latz, longz)
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        //  var panoramaNear = CLLocationCoordinate2DMake(latz, longz)
        
        //var panoView = GMSPanoramaView.panoramaWithFrame(CGRectZero,
        // nearCoordinate:panoramaNear)
        
        // self.view = panoView
        
        
        
        marker.position = CLLocationCoordinate2DMake(latz, longz)
        
       print("ADDRESS : "+addy)
        print(String(format: "LAT : %f", latz))
        print(String(format: "LONG : %f", longz))
        print("COUNTRY : "+country_selected)
        selectedActivityLocation.text = addy
        
        self.setupMap()
        // gpaViewController.placeDelegate = self
        
        // presentViewController(gpaViewController, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapSearchAction(_ sender:UIButton) {
        
        
        present(gpaViewController, animated: true, completion: nil)
        
    }
    
    
    
    func backAction(_ sender:UIButton) {
        
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func selectAddressAction(_ sender:UIButton) {
        //set final addy and lat and long
        
        self.dismiss(animated: true, completion: nil)
        
        selectedActivityLocation.text = addy
    }
}



extension mapLocation: GooglePlacesAutocompleteDelegate {
    func placeSelected(_ place: Place) {
        print(place.description)
        addy = place.description
        
        place.getDetails { details in
            print(details)
        }
    }
    
    func placeViewClosed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
