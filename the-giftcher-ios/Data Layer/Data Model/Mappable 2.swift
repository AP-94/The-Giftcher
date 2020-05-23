
import Foundation

protocol Mappable: Codable {
    init?(jsonData: Data?)
    init?(jsonString: String)
}

extension Mappable {
    
    init?(jsonData: Data?) {
        
        guard let data = jsonData else { return nil }
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        }
        catch {
            return nil
        }
    }
    
    init?(jsonString: String) {
        
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        self.init(jsonData: data)
    }
    
    var jsonString: String {
        
        let encoder = JSONEncoder()
        //encoder.outputFormatting = .sortedKeys
        let json = try? encoder.encode(self)
        if let data = json, let str = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\\", with: "") {
            return str
        }
        else { return ""}
    }
}
