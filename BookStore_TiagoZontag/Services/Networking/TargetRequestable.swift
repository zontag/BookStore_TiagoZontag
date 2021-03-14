//
//  TargetRequestable.swift
//  BookStore_TiagoZontag
//
//  Created by Tiago Zontag on 13/03/21.
//

import Foundation

enum NetworkingMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Target {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkingMethod { get }
    var queryParams: [String: String?] { get }
}

protocol TargetRequestable {
    func request<ResultType>(_ target: Target, completion: @escaping Action1<Result<ResultType, Error>>)  where ResultType: Decodable
}

extension URLSession: TargetRequestable {

    private func makeRequest(_ target: Target) -> Result<URLRequest, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = target.baseURL
        components.queryItems = target.queryParams.compactMap { (param) -> URLQueryItem? in
            guard let value = param.value, !value.isEmpty else { return nil }
            return URLQueryItem(name: param.key, value: value)
        }
        components.path = target.path
        guard let url = components.url
        else {
            return .failure(URLError(.badURL))
        }
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        return .success(request)
    }

    func request<ResultType>(_ target: Target, completion: @escaping Action1<Result<ResultType, Error>>)  where ResultType: Decodable {

        let request: URLRequest
        do {
            request = try makeRequest(target).get()
        } catch let error {
            completion(.failure(error))
            return
        }

        let task = self.dataTask(with: request) { (data, response, url) in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)
            else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data
            else {
                completion(.failure(URLError(.resourceUnavailable)))
                return
            }

            do  {
                let resultType = try JSONDecoder().decode(ResultType.self, from: data)
                completion(.success(resultType))
            } catch let error {
                debugPrint(error)
                completion(.failure(URLError(.cannotParseResponse)))
            }
        }
        task.resume()
    }
}
