//
//  PhotosArray.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.09.2021.
//

import UIKit

func createPhotosArray() {
    var photosArray:[UIImage] = []
    photosArray = (0...19).compactMap { UIImage(named: "IMG\($0)") }
    print(photosArray)
}


