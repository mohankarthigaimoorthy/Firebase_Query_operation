////
////  docViewController.swift
////  consoleFireBase
////
////  Created by Mohan K on 21/04/23.
////
//
//import UIKit
//import Firebase
//
//class docViewController: UIViewController, UITableViewDataSource{
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    var data: [String] = []
//    var ref: DatabaseReference!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        ref = Database.database().reference()
//
//        ref.observe(.value, with: { snapshot in
//            self.data = []
//            for child in snapshot.children {
//                let value = (child as! DataSnapshot).value as! String
//                self.data.append(value)
//            }
//            self.tableView.reloadData()
//        })
//        // Do any additional setup after loading the view.
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "oneTableViewCell", for: indexPath)
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
//    }
////        if indexPath.row == 0 {
////
////        }
////        let cell = tableView.dequeueReusableCell(withIdentifier: "twoTableViewCell", for: indexPath)
////        cell.textLabel?.text = data[indexPath.row]
////        return cell
////    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//
//
//
//
// 
//
//  
//
//   
//
//   
//
