//
//  Target.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit
import Alamofire

public typealias URLConvertible = Alamofire.URLConvertible
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias JSONEncoding = Alamofire.JSONEncoding

protocol Target {
    var baseURL: String { get }
    var url: URLConvertible { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
    var path: String { get }
    var parameters: Data? { get }
    var encoding: ParameterEncoding { get }
}

protocol ImageTarget {
    var baseURL: String { get }
    var url: URLConvertible { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var imageData: [ImageData] { get }
}

struct RequestQuery {
    let key: String
    let value: Any
    
    init(_ key: String,_ value: Any) {
        self.key = key
        self.value = value
    }
}

struct ImageData {
    let image: UIImage
    let withName: String
    let fileName: String?
    let mimeType: String = "image/jpg"
}

extension Target {
    func setQuery(url: String, query: [RequestQuery]?) -> String{
        guard let query else { return url }
        var url = "\(url)?"
        query.forEach {
            url.append("\($0.key)=\($0.value)&")
        }
        if let last = url.last,
           last == "&" {
            url.removeLast()
        }
        return url
    }
}
