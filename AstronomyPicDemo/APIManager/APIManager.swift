//
//  APIManager.swift
//  AstronomyPicDemo
//
//  Created by Arthur on 2021/3/5.
//

import Foundation

enum APIRouter: String{
    case baseUrl = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
}

enum RequestMethod: String{
    case get = "GET"
    case post = "POST"
}

enum APIError: Error{
    case noData
    case decoreError
    case domainError
    
    func errorMassage() -> String{
        switch self{
        case .noData:
            return "Do not have data in this response,"
        case .decoreError:
            return "Decode error,"
        case .domainError:
            return "Domain error,"
        }
    }
}

struct HttpRequest {
    
    var headers: [String: String] = [:]
    var body: Data? = nil
    var urlString: String{
        return APIRouter.baseUrl.rawValue
    }
    var methodType: RequestMethod
    
    var method: String {
        return methodType.rawValue
    }
}

class APIManager{
    
    static let sharedInstance = APIManager()
    private init() {}
    
    func makeRequest(_ httpRequest: HttpRequest) -> URLRequest{
        let urlEncodeString = httpRequest.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: urlEncodeString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = httpRequest.headers
        if let body = httpRequest.body{
            request.httpBody = body
        }
        request.httpMethod = httpRequest.method
        return request
    }
    
    func taskWithDecoder<T: Codable>(_ httpRequest: HttpRequest, decoder: JSONDecoder = JSONDecoder(), type: T.Type, completion: @escaping (_ error:Error?, _ result: T?) -> Void){
        self.taskRequest(httpRequest) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    do{
                        let response = try decoder.decode(T.self, from: data)
                        completion(nil, response)
                    }catch let error{
                        print(APIError.decoreError.errorMassage())
                        completion(error, nil)
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                    completion(error, nil)
                }
            }
        }
    }
    
    func taskRequest(_ httpRequest: HttpRequest, completion: @escaping(Result<Data, Error>) -> Void){
        URLSession.shared.dataTask(with: makeRequest(httpRequest), completionHandler: {  (data, response, error) in
            guard error == nil else {
                return completion(Result.failure(error!))
            }
            guard let data = data, let _ = response else{
                return completion(Result.failure(APIError.noData))
            }
            DispatchQueue.main.async {
                completion(Result.success(data))
            }
        }).resume()
    }
    func getImageRequest(_ httpRequest: URLRequest, completion: @escaping(Result<Data, Error>) -> Void){
        URLSession.shared.dataTask(with: httpRequest, completionHandler: {  (data, response, error) in
            guard error == nil else {
                return completion(Result.failure(error!))
            }
            guard let data = data, let _ = response else{
                return completion(Result.failure(APIError.noData))
            }
            DispatchQueue.main.async {
                completion(Result.success(data))
            }
        }).resume()
    }
}
