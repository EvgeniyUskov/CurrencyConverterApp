//
//  URLRequest + Extension.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T> {
    let url: URL
}

extension URLRequest {

    static func load<T: Decodable> (resource: Resource<T>) -> Observable<T> {
        return Observable.just(resource.url)
            .flatMap{
                url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map {
                response, data -> T in
                if 200 ..< 300 ~= response.statusCode {
                    return try JSONDecoder().decode(T.self, from: data)
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }
    }
    
    static func loadRates<T: Decodable> (resource: Resource<T>) -> Observable<[String: AnyObject]> {
        return Observable.just(resource.url)
            .flatMap{
                url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.response(request: request)
            }.map {
                response, data -> [String: AnyObject] in
                if 200 ..< 300 ~= response.statusCode {
                    return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                } else {
                    throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                }
            }
    }
}

