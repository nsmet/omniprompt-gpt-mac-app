public struct Message: Identifiable, Codable {
    public let id = UUID()
    public let message: String
    public let isUser: Bool
    public let date: Date

    public enum CodingKeys: String, CodingKey {
        case message
        case isUser
        case date
    }

    public init(message: String, isUser: Bool, date: Date) {
        self.message = message
        self.isUser = isUser
        self.date = date
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decode(String.self, forKey: .message)
        isUser = try values.decode(Bool.self, forKey: .isUser)
        let dateString = try values.decode(String.self, forKey: .date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        date = dateFormatter.date(from: dateString)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        try container.encode(isUser, forKey: .isUser)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dateFormatter.string(from: date)
        try container.encode(dateString, forKey: .date)
    }
}
