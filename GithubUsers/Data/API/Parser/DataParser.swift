//
//  DataParser.swift
//  GithubUsers
//
//  Created by Thong Nguyen on 21/7/24.
//

import Foundation

protocol DataParserProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

class DataParser: DataParserProtocol {
    private var jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }

    func getJsonDataFrom<T: Decodable>(fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Failed to get JSON mock data from \(fileName)")
            return nil
        }
        
        do {
            return try parse(data: data)
        } catch {
            print("Failed to decode JSON from \(fileName) with error \(error.localizedDescription)")
            return nil
        }
    }
}
