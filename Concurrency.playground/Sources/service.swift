import Foundation

public struct Service {
    
    public init() {}
    
    public func retrieveSample(from url: String) async throws -> String {
        guard let url = URL(string: url) else {
            throw ServiceError.urlIssue
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw ServiceError.statusIssue
            }
            
            guard let result = String(data: data, encoding: .utf8)  else {
                throw ServiceError.decodingIssue
            }
            
            return result
        } catch {
            throw error
        }
    }
}

enum ServiceError: Error {
    case urlIssue
    case statusIssue
    case decodingIssue
}
