//
//  CountryListController.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit
import WCDBSwift

class CountryListController: LocationListBaseController {
    
    lazy var hotCountries: [String] = {
        if languageIsChinese() {
            return ["中国", "美国", "英国", "澳大利亚", "加拿大"]
        } else {
            return ["Australia",
                    "Canada",
                    "China",
                    "United Kingdom",
                    "United States"]
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Country"
        
        
        
        sectionKeysArray.append("")
        sectionKeysArray.append("Hot")
        
        getCountryInfo()
    }
    
    func getCountryInfo() {
        let countriesArray = LocationInfoHelper().getCountryList()
        var hotCountriesInfoArray = [LocationModel]()
        for country in countriesArray {
            if hotCountries.contains(country.country) {
                hotCountriesInfoArray.append(country)
            } else {
                if !sectionKeysArray.contains(country.country_index) {
                    sectionKeysArray.append(country.country_index) 
                }
                if var tempArray = self.locationInfos[country.country_index] {
                    tempArray.append(country)
                    self.locationInfos[country.country_index] = tempArray
                } else {
                    self.locationInfos[country.country_index] = [country]
                }
            }
        }
        self.locationInfos["Hot"] = hotCountriesInfoArray
        
        
        
        self.listTable.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sectionKeysArray[indexPath.section]
        
        if let dataArray = locationInfos[key] {
            let dataModel = dataArray[indexPath.row]
            if dataModel.hasChildState {
                
            } else if dataModel.hasChildCity {
                
            } else {
                
            }
        }
    }
}

