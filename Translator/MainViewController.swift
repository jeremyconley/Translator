//
//  MainViewController.swift
//  Translator
//
//  Created by Jeremy Conley on 2/8/17.
//  Copyright © 2017 JeremyConley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var sellectingFrom = false
    var sellectingTo = false
    
    var languageFrom = "English"
    var languageTo = "Spanish"
    
    var langArray = [String]()
    let languages = Langs()
    
    let url1 = "https://glosbe.com/gapi/translate?from="
    let url2 = "&dest="
    let url3 = "&format=json&phrase="
    let url4 = "&pretty=true"
    
    let activityIndicator = UIActivityIndicatorView()
    
    let languageFromButton: UIButton = {
        let button = UIButton()
        button.setTitle("English", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let languageToButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spanish", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    let topBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 127/255, blue: 255/255, alpha: 1)
        view.clipsToBounds = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        view.layer.shadowRadius = 1.0
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    let switchImageView: UIImageView = {
        let imgView = UIImageView()
        let image = UIImage(named: "switchIcon")?.withRenderingMode(.alwaysTemplate)
        imgView.image = image
        imgView.tintColor = .white
        return imgView
    }()
    
    let textToTranslateContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 1.0
        
        return view
    }()
    
    let fromLanguageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "ENGLISH"
        return label
    }()
    
    let textToTranslateField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Hello"
        return textField
    }()
    
    let translatedTextContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 127/255, blue: 255/255, alpha: 1)

        view.clipsToBounds = false
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    let toLanguageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "SPANISH"
        return label
    }()
    
    let translatedTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Hola"
        return label
    }()
    
    
    @IBAction func pickLanguage(segue:UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        langArray += languages.langDic.keys
        langArray.sort()
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    func handleDismissKeyboard(){
        textToTranslateField.resignFirstResponder()
    }
    
    func setupViews(){
        self.view.addSubview(topBar)
        topBar.addSubview(languageFromButton)
        topBar.addSubview(languageToButton)
        topBar.addSubview(switchImageView)
        self.view.addSubview(textToTranslateContainerView)
        textToTranslateContainerView.addSubview(fromLanguageLabel)
        textToTranslateContainerView.addSubview(textToTranslateField)
        textToTranslateContainerView.addSubview(activityIndicator)
        self.view.addSubview(translatedTextContainerView)
        translatedTextContainerView.addSubview(toLanguageLabel)
        translatedTextContainerView.addSubview(translatedTextLabel)
        
        activityIndicator.activityIndicatorViewStyle = .gray
        
        languageFromButton.addTarget(self, action: #selector(handleLanguageFromTapped), for: .touchUpInside)
        languageToButton.addTarget(self, action: #selector(handleLanguageToTapped), for: .touchUpInside)
        
        
        topBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        topBar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        textToTranslateField.returnKeyType = .search
        textToTranslateField.delegate = self

        languageFromButton.anchor(topBar.topAnchor, left: topBar.leftAnchor, bottom: nil, right: switchImageView.leftAnchor, topConstant: 40, leftConstant: 35, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        languageToButton.anchor(topBar.topAnchor, left: switchImageView.rightAnchor, bottom: nil, right: topBar.rightAnchor, topConstant: 40, leftConstant: 10, bottomConstant: 0, rightConstant: 35, widthConstant: 0, heightConstant: 0)
        
        let switchImgConstant = (self.view.frame.width / 2) - 20
        
        switchImageView.anchor(topBar.topAnchor, left: topBar.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: switchImgConstant, bottomConstant: 0, rightConstant: 20, widthConstant: 40, heightConstant: 40)
        
        textToTranslateContainerView.anchor(topBar.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.view.frame.width, heightConstant: self.view.frame.width / 3)
        fromLanguageLabel.anchor(textToTranslateContainerView.topAnchor, left: textToTranslateContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        activityIndicator.anchor(fromLanguageLabel.topAnchor, left: nil, bottom: nil, right: textToTranslateContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
        
        textToTranslateField.anchor(fromLanguageLabel.bottomAnchor, left: fromLanguageLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: self.view.frame.width, heightConstant: 0)
        
        translatedTextContainerView.anchor(textToTranslateContainerView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: self.view.frame.width, heightConstant: self.view.frame.width / 3)
        
        toLanguageLabel.anchor(translatedTextContainerView.topAnchor, left: translatedTextContainerView.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        translatedTextLabel.anchor(toLanguageLabel.bottomAnchor, left: toLanguageLabel.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
        
    }
    
    func handleLanguageFromTapped(){
        switchLangFrom()
    }
    
    func handleLanguageToTapped(){
        switchLangTo()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        beginTranslation()
        return true
    }
    
    func beginTranslation(){
        let langFromCode = languages.langDic[languageFrom]
        let langToCode = languages.langDic[languageTo]
        let textToTrans = textToTranslateField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var text = textToTrans?.lowercased()
        
        if text == ""{
            text = "hello"
        }
        
        let url :String = url1 + langFromCode! + url2 + langToCode! + url3 + text! + url4
        getTranslation(url: url)
    }
    
    func getTranslation(url: String){
        activityIndicator.startAnimating()
        let thisUrl = URL(string: url)
        let urlReguest = URLRequest(url: thisUrl!)
        let task = URLSession.shared.dataTask(with: urlReguest as URLRequest) {data,response,error_ in
            if let content = data {
                self.processData(data: content as NSData)
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.translatedTextLabel.text = "Translation not found"
                }
            }
            
            
        }
        
        
        task.resume()
    }
    
    
    func processData(data: NSData){
        print("processing")
        var json: NSDictionary!
        do {
            
            //Convert data to JSON
            json = try JSONSerialization.jsonObject(with: data as Data, options:.allowFragments) as! NSDictionary
            //Get main Data
            //print(json)
            if let tuc = json["tuc"] as? NSArray{
                //print(tuc)
                if tuc.count > 0 {
                    if let goodStuff = tuc[0] as? NSDictionary{
                        if let translatedObj = goodStuff["phrase"] as? NSDictionary{
                            if let translationText = translatedObj["text"]{
                                print(translationText)
                                    DispatchQueue.main.async {
                                    self.translatedTextLabel.text = translationText as? String
                                    self.activityIndicator.stopAnimating()
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.translatedTextLabel.text = "Translation not found"
                                self.activityIndicator.stopAnimating()
                            }
                        }
                    }
                } else {
                    print("Translation not found")
                    DispatchQueue.main.async {
                        self.translatedTextLabel.text = "Translation not found"
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        } catch let error as NSError {
            self.translatedTextLabel.text = "Translation not found"
            self.activityIndicator.stopAnimating()
        }

        
    }
    
    func switchLangFrom() {
        print("Switching from...")
        sellectingFrom = true;
        sellectingTo = false;
        self.performSegue(withIdentifier: "pickLang", sender: self)
    }
    
    func switchLangTo() {
        print("Switching to...")
        sellectingTo = true;
        sellectingFrom = false;
        self.performSegue(withIdentifier: "pickLang", sender: self)
    }
    
    
    func langChanged(){
        languageToButton.setTitle(languageTo, for: UIControlState.normal)
        languageFromButton.setTitle(languageFrom, for: UIControlState.normal)
        
        fromLanguageLabel.text = languageFrom
        toLanguageLabel.text = languageTo
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pickLang"){
            let destinationVC = segue.destination as! LangsTVC
            if (sellectingTo){
                destinationVC.toOrFrom = "To"
            } else {
                destinationVC.toOrFrom = "From"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
