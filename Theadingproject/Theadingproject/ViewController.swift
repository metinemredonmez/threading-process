//
//  ViewController.swift
//  Theadingproject
//
//  Created by Apple on 19.08.2022.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    let urlStrings = ["https://cdn.wallpapersafari.com/92/84/Y0oiFU.jpg","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTE-efb_Cd38NO5v9Xsxq0BC-Ds5YCggmQKxta4kwln2rUZ6IDnKyrippTgANBqG_llpc&usqp=CAU"]
    
    // datayı tanımla
    
    var data =  Data()
    var tracker = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // dogru yazım  dispatch queue !1  kuyruklama sıstemı ana plan ve dıger the. yapılna ıslemler ıcınde kullanılabilir.
        // amac ana thre. bozmamak engellemek !
      
      
        // burada aslında mainde yapmak ıstemıyoruz arka plan ıcın global.async yapmamzı lazım !!
        DispatchQueue.global().async {
            self.data  = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background threa. de
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main threa. de kullanıcının  görecep yerde
            }
            
        }
        
        
         
      
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(changeImage))
        
        
    }
    
    
    @objc func changeImage() {
      
        if tracker == 0 {
            tracker += 1
        }else {
            tracker -= 1
        }
        
        // burada aslında mainde yapmak ıstemıyoruz arka plan ıcın global.async yapmamzı lazım !!
        DispatchQueue.global().async {
            self.data  = try! Data(contentsOf: URL(string: self.urlStrings[self.tracker])!) // background threa. de
            print("backgorund threa.")
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data) // main threa. de kullanıcının  görecep yerde
                print("main threa.")
            }
            
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "threading test"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    

}

