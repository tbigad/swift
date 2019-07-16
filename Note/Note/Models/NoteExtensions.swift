import UIKit

extension Note {
    static func parse(json: [String: Any]) -> Note? {
        guard let uid = json["uid"] as? String,
            let content = json["content"] as? String,
            let title = json["title"] as? String,
            let autoRemoveDate = json["autoRemoveDate"] as? Int//
            else {
                return nil
        }
        let colorRGBA:[String: CGFloat]? = json["color"] as? [String: CGFloat]
        let priority : Priority = Priority(rawValue: json["priority"] as? Int ?? Priority.medium.rawValue)!
        let colorUi : UIColor = fromRGBAColor(color: colorRGBA!)
        let note : Note = Note(title, content, priority, uid, Date(timeIntervalSince1970: Double(autoRemoveDate)), colorUi)
        
        return note
    }
    
    var json: [String: Any] {
        get {
            let timeInterval = autoRemoveDate?.timeIntervalSince1970 ?? 0
            let time = Int(timeInterval)
            var dict : [String: Any] = ["uid": uid, "content":content, "title":title, "autoRemoveDate":time]
            if color != UIColor.white {
                let colorRGBA:[String: CGFloat] = Note.toRGBAColor(color: color)
                dict.updateValue(colorRGBA, forKey: "color")
            }
            if priority != Priority.medium {
                dict.updateValue(priority.rawValue, forKey: "priority")
            }
            return dict
        }
    }
    
    static private func toRGBAColor(color: UIColor) -> [String: CGFloat]
    {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let dict : [String: CGFloat] = ["R": red, "G":green, "B":blue, "A":alpha]
        return dict
    }
    
    static private func fromRGBAColor(color: [String: CGFloat]) -> UIColor {
        if color.isEmpty {
            return UIColor.white
        }
        let dColor : UIColor = UIColor(displayP3Red: color["R"] ?? 0,
                                       green: color["G"] ?? 0,
                                       blue: color["B"] ?? 0,
                                       alpha: color["A"] ?? 0)
        return dColor
    }
    
    static func simpleData() -> [Note] {
        var data:[Note] = [Note]()
        data.append(Note("Simple Title", "Text TextText TextText TextText TextText TextText TextText Text"))
        data.append(Note("Simple Title", "Text TextText TextText TextText TextText TextText TextText Text"))
        data.append(Note("Simple Title", "Text TextText TextText TextText TextText TextText TextText Text"))
        data.append(Note("Simple LongLongLongLongLongLongLongLongLong Title", "Text TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText TextText Text"))
        
        return data
    }
    
}
