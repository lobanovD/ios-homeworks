//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 16.03.2022.
//

import Foundation
import CoreData
import StorageService

struct FavouritePost {
    var title: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    static var favouritePostsArray: [FavouritePost] = []
    
    // Managed Object Model
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "PostModel", withExtension: "momd") else {
            fatalError()
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        return managedObjectModel
    }()
    
    // Persistent Store Coordinator
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let storeName = "PostModel.sqlite"
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError()
        }
        return persistentStoreCoordinator
    }()
    
    // Manage Object Context
    private lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    // метод сохранения поста в избранное
    func addPostInFavourite(postIndex: Int) {
        
        if let newFavouritePost = NSEntityDescription.insertNewObject(forEntityName: "FavouritePosts", into: managedObjectContext) as? FavouritePosts {
            newFavouritePost.post_id = UUID()
            newFavouritePost.post_title = postArray[postIndex].title
            newFavouritePost.post_image = postArray[postIndex].image
            newFavouritePost.post_description = postArray[postIndex].description
            newFavouritePost.post_likes = Int16(postArray[postIndex].likes)
            newFavouritePost.post_views = Int16(postArray[postIndex].views)
        } else {
            fatalError()
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    // метод получения
    func getPostFromFavourite() {
        
        let fetchRequest = FavouritePosts.fetchRequest()
        
        
        do {
            
            let favouritePosts = try managedObjectContext.fetch(fetchRequest)
            
            for i in favouritePosts {

                guard let post_title = i.post_title else { return }
                guard let post_description = i.post_description else { return }
                guard let post_image = i.post_image else { return }
    
                let tempPost = FavouritePost(title: post_title, description: post_description, image: post_image, likes: Int(i.post_likes), views: Int(i.post_views))
                
                CoreDataManager.favouritePostsArray.append(tempPost)
                
            }
        } catch {
            print(error)
        }
    }
}
