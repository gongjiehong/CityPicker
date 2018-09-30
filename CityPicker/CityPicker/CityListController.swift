//
//  CityListController.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit

public class CityListController: LocationListBaseController {

    public var state: LocationModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cities"
        
        self.locationType = .city
        
        getCitiesInfo()
    }
    
    func getCitiesInfo() {
        guard let state = state else {
            return
        }
        
        let citiesArray = LocationInfoHelper().getCityList(withCountryName: state.country,
                                                           stateName: state.state)
        for city in citiesArray {
            if !sectionKeysArray.contains(city.city_index) {
                sectionKeysArray.append(city.city_index)
            }
            if var tempArray = self.locationInfos[city.city_index] {
                tempArray.append(city)
                self.locationInfos[city.city_index] = tempArray
            } else {
                self.locationInfos[city.city_index] = [city]
            }
        }
        self.listTable.reloadData()
    }

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sectionKeysArray[indexPath.section]
        
        if let dataArray = locationInfos[key] {
            let dataModel = dataArray[indexPath.row]
            if let callbackBlock = self.callbackBlock {
                callbackBlock(dataModel)
            }
        }
    }
    
}
