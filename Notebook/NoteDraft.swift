//
//  NoteDraft.swift
//  Notebook
//
//  Created by Pamela Bergson on 6/16/17.
//  Copyright © 2017 Bergson. All rights reserved.
//

import UIKit

struct NoteDraft {
    
    let title: String
    let body: String
    let date: Date
    let author: String //You can imagine that different people might want to be able to write notes about the same field, and send them to each other, or have them synched through the farm's account. For the sake of time I'm not going to do that, though.
}
