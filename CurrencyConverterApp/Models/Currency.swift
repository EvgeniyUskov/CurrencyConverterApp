//
//  Currency.swift
//  RxClimaAppSKB
//
//  Created by Evgeniy Uskov on 05.02.2021.
//

import Foundation

public struct CurrencyList: Decodable {
    var results: DecodedCurrencyArray<Currency>

    var asArray: [Currency] {
        let resultsArray = results.map {
            $0
        }
        return resultsArray
    }
    
    enum CodingKeys: CodingKey {
        case results
    }
}

public struct Currency: Decodable {
    var currencyName: String
    var currencySymbol: String?
    var id: String
    
    enum CodingKeys: CodingKey {
        case currencyName
        case currencySymbol
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currencyName = try container.decode(String.self, forKey: CodingKeys.currencyName)
        self.currencySymbol = try? container.decode(String.self, forKey: CodingKeys.currencySymbol)
        self.id = try container.decode(String.self, forKey: CodingKeys.id)
    }
    
    public init?(from entity: CurrencyCachedEntity) {
        guard let name = entity.currencyName,
              let id = entity.id else { return nil }
        self.currencyName = name
        self.currencySymbol = entity.currencySymbol
        self.id = id
    }
}

public struct DecodedCurrencyArray<T: Decodable>: Decodable {

    public typealias DecodedArrayType = [T]

    private var array: DecodedArrayType

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = DecodedArrayType()
        for key in container.allKeys {
            let decodedObject = try container.decode(T.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }

        array = tempArray
    }
}

extension DecodedCurrencyArray: Collection {
    public typealias Index = DecodedArrayType.Index
    public typealias Element = DecodedArrayType.Element

    public var startIndex: Index { return array.startIndex }
    public var endIndex: Index { return array.endIndex }

    public subscript(index: Index) -> Iterator.Element {
        get { return array[index] }
    }

    public func index(after i: Index) -> Index {
        return array.index(after: i)
    }
}
