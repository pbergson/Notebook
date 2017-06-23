//
//  NoteDetail.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/23/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

struct NoteDetail {
    
    let title: String
    let body: String
    let dateString: String
    let locationName: String?
    let image: UIImage?
    
    init?(note: Note, formatter: DateFormatter) {
        self.title = note.title ?? ""
        self.body = note.body ?? ""
        if let date = note.createdAt {
            self.dateString = formatter.string(from: date as Date)
        } else {
            self.dateString = ""
        }
        
        self.locationName = "" //I would plan to have location be an entity of its own, with a description, coordinates and possibly a photo associated with it
        self.image = nil //Here I would retrieve a file name from core data and grab the image itself from the file system
    }
}

