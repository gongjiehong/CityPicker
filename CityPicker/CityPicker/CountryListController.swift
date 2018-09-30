//
//  CountryListController.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit
import WCDBSwift

public class CountryListController: LocationListBaseController {
    
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

    override public func viewDidLoad() {
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

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sectionKeysArray[indexPath.section]
        
        if let dataArray = locationInfos[key] {
            let dataModel = dataArray[indexPath.row]
            if dataModel.hasChildState {
                let statiesList = StateListController()
                statiesList.country = dataModel
                statiesList.callbackBlock = { [weak self] (resultModel) -> Void in
                    guard let weakSelf = self else { return }
                    if let callbackBlock = weakSelf.callbackBlock {
                        callbackBlock(resultModel)
                    }
                }
                self.navigationController?.pushViewController(statiesList, animated: true)
            } else if dataModel.hasChildCity {
                let citiesList = CityListController()
                citiesList.state = dataModel
                citiesList.callbackBlock = { [weak self] (resultModel) -> Void in
                    guard let weakSelf = self else { return }
                    if let callbackBlock = weakSelf.callbackBlock {
                        callbackBlock(resultModel)
                    }
                }
                self.navigationController?.pushViewController(citiesList, animated: true)
            } else {
                if let callbackBlock = self.callbackBlock {
                    callbackBlock(dataModel)
                }
            }
        }
    }
}

