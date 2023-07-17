//
//  Target.swift
//  ReFree
//
//  Created by 이주훈 on 2023/07/17.
//

import UIKit
import Alamofire

public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias ParameterEncoding = Alamofire.ParameterEncoding
public typealias JSONEncoding = Alamofire.JSONEncoding

protocol Target: URLRequestConvertible {
    var baseURL: String { get }
    var url: URLConvertible { get }
    var method: HTTPMethod { get }
    var header: HTTPHeaders { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var images: [UIImage] { get }
}

extension Target {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.absoluteString + path, method: method)
        urlRequest.headers = header
        
        return urlRequest
    }
}


