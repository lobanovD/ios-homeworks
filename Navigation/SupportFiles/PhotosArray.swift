//
//  PhotosArray.swift
//  Navigation
//
//  Created by Dmitrii Lobanov on 14.09.2021.
//

import UIKit

var photosArray:[UIImage] = []

func createPhotosArray() {
    photosArray = (0...19).compactMap { UIImage(named: "IMG\($0)")?.resizeWithWidth(width: 300) }
}


