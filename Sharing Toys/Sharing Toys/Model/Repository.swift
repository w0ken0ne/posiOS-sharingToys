//
//  Repository.swift
//  Sharing Toys
//
//  Created by Willian S. on 04/01/22.
//

import Foundation
import Firebase

enum Response {
    case sucess
    case failure
}

class Repository {
    
    private let collectionName = "sharingToys"
    private lazy var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true

        let firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    
    static var shared: Repository {
        return Repository()
    }
    
    private init() {
    }
    
    func delete(toy: Toy, completion: @escaping (Response) -> Void ) {
        firestore.collection(collectionName).document(toy.id).delete { error in
            error != nil ? completion(.failure) : completion(.sucess)
        }
    }
    
    func addListener( completion: @escaping (QuerySnapshot?, Error?) -> Void  ) {//-> ListenerRegistration {
        firestore.collection(collectionName).order(by: "name", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { snapshot, error in
            completion(snapshot, error)
        })
    }
    
    func save(_ toy: Toy?, _ data: [String: Any], completion: @escaping (Response) -> Void ) {
        if let toy = toy {
            firestore.collection(collectionName).document(toy.id).updateData(data) { error in
                error != nil ? completion(.failure) : completion(.sucess)
            }
        } else {
            firestore.collection(collectionName).addDocument(data: data) { error in
                error != nil ? completion(.failure) : completion(.sucess)
            }
        }
    }
    
    
    
}
