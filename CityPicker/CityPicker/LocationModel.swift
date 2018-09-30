//
//  LocationModel.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import Foundation
import WCDBSwift

public class LocationModel: TableCodable {
    public var country: String!
    public var state: String!
    public var city: String!
    public var country_index: String!
    public var state_index: String!
    public var city_index: String!
    
    public enum CodingKeys: String, CodingTableKey {
        public static let objectRelationalMapping = TableBinding(LocationModel.CodingKeys.self)
        public typealias Root = LocationModel
        case country
        case state
        case city
        case country_index
        case state_index
        case city_index
    }
    
    public var hasChildState: Bool {
        return self.country != self.state
    }
    
    public var hasChildCity: Bool {
        return self.country != self.city || self.state != self.city
    }
}
