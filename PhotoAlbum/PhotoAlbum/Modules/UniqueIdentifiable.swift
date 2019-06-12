//
//  UniqueIdentifiable.swift
//  PhotoAlbum
//
//  Created by Sergey Vasilyev on 08/06/2019.
//  Copyright © 2019 Sergey Vasilyev. All rights reserved.
//

typealias UniqueIdentifier = Int

protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
