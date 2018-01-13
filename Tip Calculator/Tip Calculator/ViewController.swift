//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Tolga telseren on 09/01/18.
//  Copyright © 2018 Tolga telseren. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,UITextFieldDelegate{
   
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var tipTF: UITextField!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    var lastRefreshedTime:Date?
    var tipPercentage :Double = 5
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addTap()
        initialise()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,object: nil)
        
        // self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initialise(){
        self.title = "Tip Calculator"
        self.tipTF.text = "$ "
        self.totalAmountLabel.text = ""
        self.tipTF.delegate = self
        self.firstButton.tag = 1
        self.secondButton.tag = 2
        self.thirdButton.tag = 3
    }
    
    @objc func applicationDidBecomeActive(){
        checkTime()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewDidAppear")
        self.tipTF.becomeFirstResponder()
    }
    
    func checkTime(){
        if lastRefreshedTime == nil{
            lastRefreshedTime = Date()
        }else{
            let date2 = Date()
            let timeBetweenDates = date2.timeIntervalSince(lastRefreshedTime!)
            //var distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
            if timeBetweenDates > 600{ //ten minutes seconds 600 seconds
                initialise()
                self.tipTF.becomeFirstResponder()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        checkTime()
        if let tipValue = //UserDefaults.standardUserDefaults().objectForKey("yourkey") as? [NSString]
            
            UserDefaults.standard.object(forKey: "tip"){
            tipPercentage = Double(tipValue as! Int)
            calculateTotalAmount(self.tipTF.text!)
            if tipPercentage == 5{
                let sender = self.view.viewWithTag(1) as Any
                setUpButtonUI(sender)

            }else if tipPercentage == 10{
                let sender = self.view.viewWithTag(2) as Any
                setUpButtonUI(sender)

            }else if tipPercentage == 15{
                let sender = self.view.viewWithTag(3) as Any
                setUpButtonUI(sender)
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        let lengthOfText = txtAfterUpdate.characters.count
        
        if(textField == self.tipTF){
            
            if(lengthOfText == 1){
                return false
            }
            else
            {
                calculateTotalAmount(txtAfterUpdate)
                return true
            }
            
        }
    return true
        
    }
    
    
    func calculateTotalAmount(_ texting:String)
    {
        if((texting.characters.count) <= 2)
        {
            self.totalAmountLabel.text = ""
            return
        }
        let index = texting.index((texting.startIndex), offsetBy: 2)
        // var amount = self.tipTextField.text?.substring(fromIndex:index);
        
        let amount =   texting.substring(from: index)
        
        var amountInDouble = Double(amount)
        let amountInDouble1  = (amountInDouble! * tipPercentage )/100
        amountInDouble = (amountInDouble! + amountInDouble1)
        
        self.totalAmountLabel.text = String(describing: amountInDouble!)
       
    }

    
    func setUnselectButton(_ sender:UIButton){
        let button = sender
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.black, for: .normal)
       
    }
    func setSeletedButton(_ sender:UIButton){
        let button = sender
        button.backgroundColor = UIColor(red: 92 / 255.0, green: 71 / 255.0, blue: 189 / 255.0, alpha: 1.0)
        button.setTitleColor(UIColor.white, for: .normal)

    }
    
    func setUpButtonUI(_ sender:Any){
        let tag = (sender as! UIButton).tag
        for i in 1...3{
            if( tag != i){
                setUnselectButton(self.view.viewWithTag(i) as! UIButton)
            }else{
                setSeletedButton(self.view.viewWithTag(i) as! UIButton)
            }
        }
    }
    
    @IBAction func firstButtonTapped(_ sender: Any) {
        setUpButtonUI(sender)
        tipPercentage = 5
        calculateTotalAmount(self.tipTF.text!)
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        setUpButtonUI(sender)
        tipPercentage = 10
        calculateTotalAmount(self.tipTF.text!)
    }
    
    @IBAction func thirdButtonTapped(_ sender: Any) {
        setUpButtonUI(sender)
        tipPercentage = 15
        calculateTotalAmount(self.tipTF.text!)
    }

    @IBAction func settingButtonTapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


