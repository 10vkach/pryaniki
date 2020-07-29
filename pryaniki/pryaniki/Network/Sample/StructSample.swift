import Foundation

struct Sample: Decodable {
    let data: [SampleData]
    let view: [String]
    
    struct SampleData: Decodable {
        let name: String
        let data: DataType
        
        enum DataType: Decodable {
            case text(HZData)
            case picture(PictureData)
            case selector(SelectorData)
            
            init(from decoder: Decoder) throws {
                
                if let selectorData = SelectorData(decoder: decoder) {
                    self = .selector(selectorData)
                    return
                }
                
                if let pictureData = PictureData(decoder: decoder) {
                    self = .picture(pictureData)
                    return
                }
                
                if let hzData = HZData(decoder: decoder) {
                    self = .text(hzData)
                    return
                }
                
                throw SampleError.UnknownDataType
            }
        }

        struct HZData: Codable {
            let text: String
            
            enum CodingKeys: String, CodingKey {
                case text
            }
            
            init?(decoder: Decoder) {
                do {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    text = try container.decode(String.self, forKey: .text)
                } catch {
                    return nil
                }
            }
        }

        struct PictureData: Codable {
            let url: URL
            let text: String
            
            enum CodingKeys: String, CodingKey {
                case url, text
            }
            
            init?(decoder: Decoder) {
                do {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    url = try container.decode(URL.self, forKey: .url)
                    text = try container.decode(String.self, forKey: .text)
                } catch {
                    return nil
                }
            }
        }

        struct SelectorData: Codable {
            let selectedId: Int
            let variants: [Variant]
            
            enum CodingKeys: String, CodingKey {
                case selectedId, variants
            }
            
            struct Variant: Codable {
                let id: Int
                let text: String
            }
            
            init?(decoder: Decoder) {
                do {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    selectedId = try container.decode(Int.self, forKey: .selectedId)
                    variants = try container.decode([Variant].self, forKey: .variants)
                } catch {
                    return nil
                }
            }
        }
    }
}

//MARK: Errors
enum SampleError: Error {
    case UnknownDataType
}
