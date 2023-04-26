//
//  MyViewController.swift
//  consoleFireBase
//
//  Created by Mohan K on 21/04/23.
//

import UIKit
import Firebase
import FirebaseFirestore

struct MyObject {
    var city : String
    var colors : [String]
    var count : String
    var id : Int
    var name : String
    var state : String
    var type : String
}
class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var mytable: UITableView!
    
    let uuide = UUID().uuidString
    let db = Firestore.firestore()
    var objects: [MyObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mytable.dataSource = self
        mytable.delegate = self
        
        
        
        fetchData()
        // Do any additional setup after loading the view.
        
    }
    
    
    func  fetchData(){
        
        let colref = db.collection("animal")
        
        colref.getDocuments { (querySnapshot, error) in
            if let error = error  {
                print("Error getting Documents: \(error)")
            }
            else {
                for document in querySnapshot!.documents {
                    //                    guard let data = document.data() else {return}
                    let data = document.data()
                    let city = data["city"] as? String
                    let colors = data["colors"] as? [String]
                    let count = data ["count"] as? String
                    let id = data ["id"] as? Int
                    let name = data["name"] as? String
                    let state = data["state"] as? String
                    let type = data["type"]as? String
                    self.objects.append(MyObject(city: city ?? "", colors: colors ?? ["\("")"], count: count ?? "", id: id ?? Int(), name: name ?? "", state: state ?? "", type: type ?? ""))
                }
                
                self.mytable.reloadData()
            }
        }
        
        listenData()
        
    }
    
    
    func listenData() {
        
        db.collection("animal").addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetchhing document:\(error!) ")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                let data = diff.document.data()
                let id = data["id"] as? Int

                if (diff.type == .added) {
                    print("match found index : \(diff.type)")

                    if(diff.type == .added){
                                         print("match found index : \(diff.type)")
                        
                        self.objects.append(MyObject.init(city: "trichy", colors: ["white"], count: "four", id: 278, name: "revi", state: "nasik", type: "voks vegon"))
                        
                                     }
                                         else {
                                            print("match doc not found")
                                        }


                }
           else   if (diff.type == .modified) {
                    print("match found index : \(diff.type)")

                  if let index = self.objects.firstIndex(where: {$0.id == id}){
                       print("match found index : \(index)")

                       let city = data["city"] as? String ?? ""
                       let colors = data["colors"] as? [String] ?? [""]
                       let count = data ["count"] as? String ?? ""
                       let id = data ["id"] as? Int ?? 0
                       let name = data["name"] as? String ?? ""
                       let state = data["state"] as? String ?? ""
                       let type = data["type"]as? String ?? ""

                       self.objects[index] = MyObject(city: city, colors: colors, count: count, id: id, name: name, state: state, type: type)

                       DispatchQueue.main.async {
                           self.mytable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                       }

                   } else {
                       print("match doc not found")
                   }

                }

//            if (diff.type == .removed) {
//                    print("match found index : \(diff.type)")
//
//                   if let index = self.objects.firstIndex(where: {$0.id == id}) {
//                                          print("match foun index : \(index)")
//
//                                          let city = data["city"] as? String ?? ""
//                                          let colors = data["colors"] as? [String] ?? [""]
//                                          let count = data ["count"] as? String ?? ""
//                                          let id = data ["id"] as? Int ?? 0
//                                          let name = data["name"] as? String ?? ""
//                                          let state = data["state"] as? String ?? ""
//                                          let type = data["type"]as? String ?? ""
//
//                                          self.objects[index] =  MyObject(city: city, colors: colors, count: count, id: id, name: name, state: state, type: type)
//                                          DispatchQueue.main.async {
////                                              self.objects.remove(at: index)
////                                              self.mytable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
//                                              self.mytable.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
//                                              self.mytable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
//
//                                          }
//                                      }
//                                      else {
//                                          print("match not doc found")
//                                      }
//                }
                else {
                    print("updated document data: \(diff.document.data())")
                }
            }

            }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = mytable.dequeueReusableCell(withIdentifier: "twoTableViewCell", for: indexPath) as! twoTableViewCell
            let object = objects[indexPath.row]
            cell.textFieldone.text = "\(object.id)"
            cell.textFieldtwo.text = object.name
            cell.textFieldthree.text = object.count
            cell.textFieldfour.text = object.type
            cell.textFieldfive.text = object.city
            cell.textFieldsix.text = object.state
            return cell
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 400
    }
    
    @IBAction func updateBtn(_ sender: Any) {
     
    }
    
}
