//
//  ViewController.swift
//  consoleFireBase
//
//  Created by Mohan K on 20/04/23.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UIContextMenuInteractionDelegate {
    
    
    @IBOutlet weak var menuBar: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var documentId: UITextView!
    @IBOutlet weak var documentData: UITextView!
    var db: Firestore!
    
    let ref = Firestore.firestore()
    let docId = UUID().uuidString
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        views()

        let interaction = UIContextMenuInteraction(delegate:  self)
        menuBar.addInteraction(interaction)
        menuBar.isUserInteractionEnabled = true
        menuBar.layer.cornerRadius = 10
     
    }
    func views() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemMint.cgColor, UIColor.systemCyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        view.layer.insertSublayer(gradientLayer, at: 0)
        view.backgroundColor = .clear

    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
            
        }
    }
    
    func updateData() {
        let documentRef = db.collection("animal").document("mammal")
        documentRef.updateData([:])
        { error in
            if let error = error {
                print("Error updating document: \(error)")
            }
            else {
                print("Document successfully updated")
            }
        }
    }
    func createContextMenu() -> UIMenu {
        
        let createAction = UIAction(title: "create", image: UIImage(systemName: "paperplane.fill")) { _ in
            
            //MARK : - ADD a DATA IN NORMAL
            self.ref.collection("animal").document("bird").setData([
                            "name": "Peacock",
                            "type": "Herbivore",
                            "colors": ["Green", "White", "Blue", "Black"]
                        ])
            
            //MARK : - ADD a DATA IN NORMAL USING A MERGE IT WILL GENERATE NEW PARAM DATA
                        self.ref.collection("animal").document("mammal").setData([
                            "name": "Bat",
                            "type": "Herbivore",
                            "norturnal": true,
                            "colors": ["Brown", "Black"]
                        ], merge: true)
            self.ref.collection("animal").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
            
        }
        
        let hashAction = UIAction(title: "createDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
            
            //MARK: -  HASH ACTION IS NORMAL STATE THAT AUTO GENERATE COLLECTION WITH ID.
                        let conref = self.ref.collection("class").addDocument(data: [
                            "name": "reguvaraa",
                            "gender": "male"
            
                        ])
          

                        {
                            err in
                            if let err = err
                            {
                                print("Error adding document: \(err)")
                            }
                            else
                            {
                                print("Document added with ref: \(self.ref)")
                            }
                        }
            //
            self.ref.collection("class").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
        }
        
        let updateAction = UIAction(title: "updateDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
            //MARK : using a merge update a data
                        self.ref.collection("animal").document("bird").setData(["type": "Carnivore"], merge: true)
            
            //MARK : - USING A NORMAL STATE MERGE A UPDATE A DATA
//
//                        let conref = self.ref.collection("animal").document("bird")
//                        conref.updateData([
//                            "type": "Omnivore"
//                        ]) { err in
//                            if let err = err {
//                                print("Error updating document, reason: \(err)")
//                            } else {
//                                print("Document successfully updated")
//                            }
//                        }
            
                        let conref = self.ref.collection("class").document("JeNEPMRUVdcoemLGlsBH")
                           conref.updateData([
                               "name": "Bill Jobs"
                           ]) { err in
                               if let err = err {
                                   print("Unable to update data, reason: \(err)")
                               } else {
                                   print("Data updated successfully")
                               }
                           }
            self.ref.collection("class").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
        }
        
        let deleteAction = UIAction(title: "deletDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
//            Mark : - delete entire collection using these function
                            self.ref.collection("animal").document("bird").delete() { err in
                                if let err = err {
                                    print("Unable to delete document, reason: \(err)")
                                } else {
                                    print("Data deleted successfully")
                                }
                            }
            
//             MARK : - delete a field value collection using function
            
                            self.ref.collection("animal").document("mammal").updateData(["norturnal": FieldValue.delete()]) { err in
                                if let err = err {
                                    print("Unable to delete document, reason: \(err)")
                                } else {
                                    print("Data deleted successfully")
                                }
                            }
            self.ref.collection("animal").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
        }
        
        let transactionAction = UIAction(title: "TransDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
//
            let conref = self.ref.collection("animal").document("mammal")
            self.ref.runTransaction({ (transaction, errPointer) -> Any? in
                let dosSnapshot: DocumentSnapshot

                // get the document via transaction
                do {
                    try dosSnapshot = transaction.getDocument(conref)
                } catch let fetchError as NSError {
                    errPointer?.pointee = fetchError
                    return nil
                }

                // get the counter value
                guard let counter = dosSnapshot.data()?["count"] as? String else {
                    let err = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve counter"])
                    errPointer?.pointee = err
                    return nil
                }

                // update counter value via transaction
                transaction.updateData(["count": counter + "two"], forDocument: conref)
                return nil
            }) { (object, err) in
                if let err = err {
                    print("Transaction failed, reason: \(err)")
                } else {
                    print("Transaction success")
                }
            }

            self.ref.collection("animal").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
            
        }
        let batchwriteAction = UIAction(title: "batchDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
            
                        let batch = self.ref.batch()
            
                        let mammalRef = self.ref.collection("animal").document("mammal")
                        batch.updateData(["name": "Tarsius"], forDocument: mammalRef)
            
                        let birdRef = self.ref.collection("animal").document("bird")
                        batch.deleteDocument(birdRef)
            
                        batch.commit() { err in
                            if let err = err {
                                print("Batch write failed, reason: \(err)")
                            } else {
                                print("Batch write succeeded.")
                            }
                        }
            
            self.ref.collection("animal").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
        }
        let getdatawriteAction = UIAction(title: "getdataDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
            let conref = self.ref.collection("animal").document("mammal")
            conref.getDocument { (snapshot, err) in
                if let data = snapshot?.data() {
                    print(data["name"])
                } else {
                    print("Couldn't find the document")
                }
            }
       
            let collectionRef = self.ref.collection("animal")
            collectionRef.getDocuments { (querySnapshot, err) in
                if let docs = querySnapshot?.documents {
                    for docSnapshot in docs {
                        print(docSnapshot.data())
                    }
                }
            }
            
            let query = self.ref.collection("animal").whereField("name", isEqualTo: "Peacock")
            // or
//             query = db.collection("animal").whereField("colors", arrayContains: "Black")
            // to filter data by an array value

            query.getDocuments { (querySnapshot, err) in
                if let docs = querySnapshot?.documents {
                    for docSnapshot in docs {
                        print(docSnapshot.data())
                    }
                }
            }
        
        self.ref.collection("animal").getDocuments { (snapshot, error) in
            for document in snapshot!.documents {
                if let error = error {
                    print("Error getting documents: \(error)")
                    
                } else {
                    for document in snapshot!.documents {
                        self.documentId.text.append(contentsOf:"\(document.documentID) ")
                        self.documentData.text.append(contentsOf:"\(document.data())")
                        
                    }
                }
            }
        }
        }
        
        let getrealtimedatawriteAction = UIAction(title: "getreaaltimedataDocument", image: UIImage(systemName: "paperplane.fill")) { _ in
            
            self.ref.collection("animal").document("mammal").addSnapshotListener { (snapshot, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }

                if let data = snapshot?.data() {
                    print(data)
                }
            }
            
            // Listen to multiple documents changes
            let collectionRef = self.ref.collection("animal")
            collectionRef.addSnapshotListener { (querySnapshot, err) in

            }

            // Listen fo filtered documents changes
            let query = self.ref.collection("animal").whereField("name", isEqualTo: "Peacock")
            query.getDocuments { (querySnapshot, err) in
           
            }
            self.ref.collection("animal").getDocuments { (snapshot, error) in
                for document in snapshot!.documents {
                    if let error = error {
                        print("Error getting documents: \(error)")
                        
                    } else {
                        for document in snapshot!.documents {
                            self.documentId.text.append(contentsOf:"\(document.documentID) ")
                            self.documentData.text.append(contentsOf:"\(document.data())")
                            
                        }
                    }
                }
            }
        }
        return UIMenu(title: "", children: [ createAction,
                                             hashAction,
                                             updateAction,
                                             deleteAction,
                                             transactionAction,
                                             batchwriteAction,
                                             getdatawriteAction,
                                             getrealtimedatawriteAction])
    }
    
    
    @IBAction func buttonMenu(_ sender: Any) {
    }
    
    @IBAction func buttonRefresh(_ sender: Any) {
        documentId.text = ""
        documentData.text = ""
    }
    
    
}

