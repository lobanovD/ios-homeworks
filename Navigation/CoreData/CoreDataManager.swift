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
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError()
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.newBackgroundContext()
    
    
    // метод сохранения поста в избранное
    func addPostInFavourite(postIndex: Int) {
        
        context.perform { [weak self] in
            
            guard let self = self else { return }
            
            if let newFavouritePost = NSEntityDescription.insertNewObject(forEntityName: "FavouritePosts", into: self.context) as? FavouritePosts {
                newFavouritePost.post_id = UUID()
                newFavouritePost.post_title = postArray[postIndex].author
                newFavouritePost.post_image = postArray[postIndex].image
                newFavouritePost.post_description = postArray[postIndex].description
                newFavouritePost.post_likes = Int16(postArray[postIndex].likes)
                newFavouritePost.post_views = Int16(postArray[postIndex].views)
            } else {
                fatalError()
            }
            
            do {
                try self.context.save()
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("updateFavouritePosts"), object: nil)
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    // метод удаления поста из избранного
    func deletePostFromFavourite(postIndex: Int) {
        
        let fetchRequest = FavouritePosts.fetchRequest()
        do {
            let favouritePosts = try context.fetch(fetchRequest)
            for i in favouritePosts.indices {
                
                if i == postIndex {
                    context.delete(favouritePosts[i])
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("updateFavouritePosts"), object: nil)
                    }
                }
            }
            
            try context.save()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // метод получения
    func getPostFromFavourite() {
        
        CoreDataManager.favouritePostsArray = []
        
        let fetchRequest = FavouritePosts.fetchRequest()
        
        do {
            
            let favouritePosts = try context.fetch(fetchRequest)
            
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
