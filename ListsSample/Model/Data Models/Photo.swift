
import Foundation

struct Photo: Decodable, Comparable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    
    static func <(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.albumId < rhs.albumId
    }
}
