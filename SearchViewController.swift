//
//  SearchViewController.swift
//  righthererightnow
//
//  Created by Nnamdi Okeke on 7/7/15.
//  Copyright (c) 2015 Oluwatobi Adeleye. All rights reserved.
//

import UIKit

var searchOption = ""
var searchOptions = ["Activities","Users"]

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var searchBar:UITextField!
    //var segmentedController:UISegmentedControl = UISegmentedControl()
    
    var segmentedController:UnderlineSegmentedControl!

    var resultTable:UITableView!
    var cancelButton:UIButton!
    var width = CGFloat()
    var height = CGFloat()
    var blackBack:UIView!
    var blackBackImgV:UIImageView!
     var listOfActivities:NSMutableArray!
     var listOfUsers:NSMutableArray!
    var imagMethods:ImageMethods!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar = UITextField()
        //var segmentedController:UISegmentedControl = UISegmentedControl()
        
        self.segmentedController = UnderlineSegmentedControl()
        
        self.resultTable = UITableView()
        self.cancelButton = UIButton()
        
        self.blackBack = UIView()
        self.blackBackImgV = UIImageView()
        self.listOfActivities = NSMutableArray()
        self.listOfUsers = NSMutableArray()
        self.imagMethods = ImageMethods()


        
        
        let scrn = UIScreen.main.bounds
        width = scrn.size.width
        height = scrn.size.height
        
        
        
        setUpBlackBack();
        setUpTable()
        setUpSegment()
        setUpTextField()
        initialPositions()
        setUpBack()
        
        


        // Do any additional setup after loading the view.
    }
    
    
    func setUpTable() {
        
        resultTable.delegate      =   self
        resultTable.dataSource    =   self
        resultTable.backgroundColor = UIColor.clear
        resultTable.separatorColor = UIColor.lightGray
        resultTable.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        resultTable.register(SearchCell.self, forCellReuseIdentifier: "Cell")
      
        
    }
    
    func setUpBlackBack() {
        
        self.blackBackImgV = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        self.blackBackImgV.contentMode = UIViewContentMode.scaleAspectFill
        self.blackBackImgV.clipsToBounds = true
        self.blackBackImgV.layer.masksToBounds = true
        self.blackBackImgV.image = UIImage(named: "city_street.jpg")
        
        self.view.addSubview(self.blackBackImgV)
        
        self.blackBack = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 100))
        self.blackBack.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        self.view.addSubview(self.blackBack)
        
        
    }
    
    
    func setUpBack() {
        
        self.cancelButton.addTarget(self, action: #selector(SearchViewController.back), for: UIControlEvents.touchUpInside)
        
    }
    
    func setUpTextField() {
        searchBar.borderStyle = UITextBorderStyle.roundedRect;
        searchBar.delegate = self
        searchBar.font = UIFont(name: "AvenirNext-Regular", size: 14)
        searchBar.textColor = UIColor.black
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.clear.cgColor
        searchBar.layer.borderWidth = 1;
        searchBar.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = searchBar.frame.size.height/2
        searchBar.backgroundColor = UIColor(white: 1, alpha: 0.3)
        
        if (segmentedController.selectedSegmentIndex==0) {
            
        searchBar.placeholder = "Search Activities"
            
        } else {
            
            searchBar.placeholder = "Search Users"
            
        }
    }
    
    func back() {
         print("dismiss called")
        self.dismiss(animated: true, completion: {
            
           
            
            self.searchBar = nil
            //var segmentedController:UISegmentedControl = UISegmentedControl()
            
            self.segmentedController = nil
            
            self.resultTable = nil
            self.cancelButton = nil
            
            self.blackBack = nil
            self.blackBackImgV = nil
            self.listOfActivities = nil
            self.listOfUsers = nil

            
        })
        
        
    }
    
    func setUpSegment() {
        
        //Segmented Control
        
        segmentedController = UnderlineSegmentedControl(frame: CGRect( x: -width, y: 60 , width: width-40, height: 30))
        segmentedController.items = searchOptions
        segmentedController.selectedSegmentIndex = 0
        
        segmentedController.selectedLabelColor = UIColor.white
        segmentedController.unselectedLabelColor = UIColor.white
        segmentedController.thumbColor = UIColor.white
        segmentedController.font = UIFont(name: "AvenirNext-Regular", size: 13)
        segmentedController.addTarget(self, action: #selector(SearchViewController.segmentedsValueChanged(_:)), for: .valueChanged)
        
    }
    
    //SegmentedControl Function
    func segmentedsValueChanged(_ sender:UISegmentedControl!)
    {
        searchOption = "\(searchOptions[sender.selectedSegmentIndex])"
        
        if (segmentedController.selectedSegmentIndex==0) {
            
            searchBar.placeholder = "Search Activities"
            
        } else {
            
            searchBar.placeholder = "Search Users"
            
        }
        
        self.resultTable.reloadData()
        
    }
    
    
    func initialPositions() {
        
        searchBar.frame = CGRect(x: 15, y: -55, width: width-90, height: 40)
        
        
        resultTable.frame = CGRect(x: 0, y: height, width: width, height: height-100)
        
        cancelButton.frame = CGRect(x: width, y: 10, width: 40, height: 40)
        cancelButton.setTitle("DONE", for: UIControlState())
        cancelButton.tintColor = UIColor.lightGray
        cancelButton.setTitleColor(UIColor.lightGray, for: UIControlState())
        cancelButton.titleLabel?.font = UIFont(name: "AvenirNext-UltraLight", size: 15)
        
        self.view.addSubview(searchBar)
        self.view.addSubview(segmentedController)
        self.view.addSubview(resultTable)
        self.view.addSubview(cancelButton)
    }
    
    func animateIn() {
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.searchBar.frame = CGRect(x: 15, y: 10, width: self.width-75, height: 35)
            self.segmentedController.frame = CGRect(x: 20, y: 60, width: self.width-40, height: 30)
            self.resultTable.frame = CGRect(x: 0, y: 100, width: self.width, height: self.height-100)
            self.cancelButton.frame = CGRect(x: self.width-60, y: 10, width: 60, height: 40)
            
            }, completion: { (complete: Bool) in
             
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateIn()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (segmentedController.selectedSegmentIndex == 0) {
            
            return listOfActivities.count
            
        } else {
            
            return listOfUsers.count
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    
    
    
    deinit {
       //self.listOfUsers.removeAllObjects()
        //self.listOfActivities.removeAllObjects()
        print("deinit called")
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell: SearchCell! = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SearchCell
        
        let cell: SearchCell! = SearchCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        cell.prepareForReuse()
        
        if (tableView == self.resultTable) {
            
            if (segmentedController.selectedSegmentIndex == 0) {
                
                let thisActivity:activity = self.listOfActivities.object(at: (indexPath as NSIndexPath).row) as! activity
                
                let icon:UIImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 60))
                icon.contentMode = UIViewContentMode.scaleAspectFill
                icon.layer.masksToBounds = true
                icon.clipsToBounds = true
                self.imagMethods.setImgVImage_THUM(thisActivity.EventID, link: url, imgV: icon)
                cell.addSubview(icon);
                
                let title:UILabel = UILabel(frame: CGRect(x: 60, y: 10, width: width-60, height: 40))
                title.font = QUICK_SAND_REG_17
                title.textColor = UIColor.darkGray
                title.text = thisActivity.Title
                cell.addSubview(title);
                
                let organizer:UILabel = UILabel(frame: CGRect(x: 60, y: 50, width: width/2, height: 20))
                organizer.font = QUICK_SAND_REG_14
                organizer.textColor = UIColor.gray
                organizer.text = thisActivity.FirstName+" "+thisActivity.LastName
                cell.addSubview(organizer);
                
                if (thisActivity.Hashtag=="") {
               
                } else {
                    
                    let hashtag:UILabel = UILabel(frame: CGRect(x: width-100, y: 50, width: 100, height: 20))
                    hashtag.font = QUICK_SAND_REG_12
                    hashtag.textColor = UIColor.gray
                    hashtag.text = "#"+thisActivity.Hashtag
                    cell.addSubview(hashtag);
                    
                }
                
            } else {
                
                let thisUser:NSDictionary = self.listOfUsers.object(at: (indexPath as NSIndexPath).row) as! NSDictionary
                
                let firstName = thisUser.object(forKey: "FirstName") as! String
                let lastName = thisUser.object(forKey: "LastName") as! String
                let Username = thisUser.object(forKey: "Username") as! String
                let kraneumID = thisUser.object(forKey: "AccountID") as! String
                
                let profilepic:UIImageView = UIImageView(frame: CGRect(x: 10, y: 20, width: 40, height: 40))
                profilepic.contentMode = UIViewContentMode.scaleAspectFill
                profilepic.layer.masksToBounds = true
                profilepic.layer.cornerRadius = profilepic.frame.width/2
                profilepic.layer.borderColor = UIColor.clear.cgColor
                profilepic.layer.borderWidth = 1.0
                self.imagMethods.setImgVImage_THUM(kraneumID, link: url2, imgV: profilepic)
                
                cell.addSubview(profilepic)
                
                
                let usernames:UILabel = UILabel(frame: CGRect(x: 60, y: 10, width: width-60, height: 40))
                usernames.font = QUICK_SAND_REG_17
                usernames.textColor = UIColor.darkGray
                usernames.text = firstName+" "+lastName
                cell.addSubview(usernames);
                
                let username:UILabel = UILabel(frame: CGRect(x: 60, y: 50, width: width/2, height: 20))
                username.font = QUICK_SAND_REG_12
                username.textColor = UIColor.gray
                username.text = Username
                cell.addSubview(username);
                
                
                
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if tableView == self.resultTable {
            
            if segmentedController.selectedSegmentIndex==0 {
                
                let selectedevent = listOfActivities.object(at: (indexPath as NSIndexPath).row) as! activity
                selectedActivity = selectedevent
                
                let storyb:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyb.instantiateViewController(withIdentifier: "selectedEventPage") 
                self.present(vc, animated: true, completion: nil)
                
            } else {
                
                let user = listOfUsers[(indexPath as NSIndexPath).row] as! NSDictionary
                let connectId = user.object(forKey: "AccountID") as! NSString
                let vc = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
                vc.connectID = connectId.intValue
                self.present(vc, animated: true, completion: nil);
                
            }
            
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        
    
            
            if (textField == self.searchBar) {
                if (string != ""){
                let cs:CharacterSet = CharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                
                let filtered = string.rangeOfCharacter(from: cs) == nil
                
                result = filtered
                
                let totalString = textField.text!+string
                
                //Start a background thread so that the app doesnt lag due to processing this function.
                let priority = DispatchQueue.GlobalQueuePriority.default
                DispatchQueue.global(priority: priority).async {
                    
                    let totalContent:NSMutableArray = searchRHRNGlobal(totalString)
                    
                    DispatchQueue.main.async {

                        self.listOfActivities = totalContent.object(at: 0) as! NSMutableArray
                        self.listOfUsers = totalContent.object(at: 1) as! NSMutableArray
                        
                        self.resultTable.reloadData()
                        
                    }
                }
                } else {
                    
                    let index: String.Index = textField.text!.characters.index(textField.text!.startIndex, offsetBy: textField.text!.characters.count-1)
                    
                    let totalString = textField.text!.substring(to: index)
                    
                    //Start a background thread so that the app doesnt lag due to processing this function.
                    let priority = DispatchQueue.GlobalQueuePriority.default
                    DispatchQueue.global(priority: priority).async {
                        
                        let totalContent:NSMutableArray = searchRHRNGlobal(totalString)
                        
                        DispatchQueue.main.async {
                            
                            self.listOfActivities = totalContent.object(at: 0) as! NSMutableArray
                            self.listOfUsers = totalContent.object(at: 1) as! NSMutableArray
                            
                            self.resultTable.reloadData()
                            
                        }
                    }

                    
                }
                
        }
        
        
        return result;
    }
    

    

}
