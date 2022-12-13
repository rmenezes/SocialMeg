import Foundation

struct UserResponse: Decodable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String?
    let company: Company
}

// MARK: - Address

extension UserResponse {
    struct Address: Decodable {
        let street: String
        let suit: String?
        let city: String
        let zipcode: String
        let geo: GeoLocation
    }
}

// MARK: - Geo Location

extension UserResponse {
    struct GeoLocation: Decodable {
        let lat: Double
        let lng: Double
        
        enum CodingKeys: CodingKey {
            case lat
            case lng
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let lat = try container.decode(String.self, forKey: CodingKeys.lat)
            let lng = try container.decode(String.self, forKey: CodingKeys.lng)
            
            self.lat = Double(lat) ?? .zero
            self.lng = Double(lng) ?? .zero
        }
    }
}

// MARK: - Company

extension UserResponse {
    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
