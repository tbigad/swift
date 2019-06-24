import UIKit

struct Note {
    enum Priority : Int {
        case high = 0
        case medium = 1
        case low = 2
    }
    
    let uid : String
    let content : String
    let title : String
    let color : UIColor
    let autoRemoveDate : Date?
    let priority : Priority
    init(_ header: String, _ text: String,
         _ prior : Priority = Priority.medium,
         _ id: String = UUID().uuidString,
         _ dateToRemove : Date? = nil,
         _ noteColor: UIColor = UIColor.white) {
        uid = id
        title = header
        content = text
        autoRemoveDate = dateToRemove
        color = noteColor
        priority = prior
    }
}
