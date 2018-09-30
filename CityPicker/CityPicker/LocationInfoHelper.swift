//
//  LocationInfoHelper.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import Foundation
import WCDBSwift

func languageIsChinese() -> Bool {
    if (Bundle.main.preferredLocalizations.count > 0 &&
        Bundle.main.preferredLocalizations[0].range(of: "zh-") != nil)
    {
        return true
    }
    return false
}

public class LocationInfoHelper {
    private struct DBConfigs {
        static var dbName = "world_cities.sqlite"
        static var tableName: String {
            if languageIsChinese() {
                return "world_cities_cn"
            } else {
                return "world_cities_en"
            }
        }
    }
    
    private var db: Database!
    
    public init() {
        let documentPath = FileManager.lg_documentDirectoryPath
        let dbFinalPath = documentPath + "/" + DBConfigs.dbName
        
        do {
            if let dbBundlePath = Bundle.main.path(forResource: DBConfigs.dbName, ofType: nil) {
                if !FileManager.default.fileExists(atPath: dbFinalPath) {
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: dbBundlePath),
                                                     to: URL(fileURLWithPath: dbFinalPath))
                }
                
                db = Database(withPath: dbFinalPath)
            }
        } catch {
            #if DEBUG
            debugPrint(error)
            #endif
        }
    }
    
    public func getCountryList() -> [LocationModel] {
        do {
            let select = try db.prepareSelect(of: LocationModel.self, fromTable: DBConfigs.tableName).group(by: LocationModel.CodingKeys.country).order(by: LocationModel.CodingKeys.country_index)
            return try select.allObjects()
        } catch  {
            return []
        }
    }
    
    public func getStateList(withCountryName name: String) -> [LocationModel] {
        do {
            let select = try db.prepareSelect(of: LocationModel.self, fromTable: DBConfigs.tableName).where(LocationModel.CodingKeys.country == name).group(by: LocationModel.CodingKeys.state).order(by: LocationModel.CodingKeys.state_index)
            return try select.allObjects()
        } catch  {
            return []
        }
    }
    
    public func getCityList(withCountryName country: String,stateName state: String) -> [LocationModel] {
        do {
            let select = try db.prepareSelect(of: LocationModel.self, fromTable: DBConfigs.tableName).where(LocationModel.CodingKeys.country == country && LocationModel.CodingKeys.state == state).order(by: LocationModel.CodingKeys.city_index)
            return try select.allObjects()
        } catch  {
            return []
        }
    }
    
}


extension FileManager {
    static var lg_documentDirectoryPath: String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                   FileManager.SearchPathDomainMask.userDomainMask,
                                                   true)[0]
    }
}
