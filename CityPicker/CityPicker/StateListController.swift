//
//  StateListController.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/29.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit

public class StateListController: LocationListBaseController {

    public var country: LocationModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "States"
        
        self.locationType = .state
        
        getStateInfo()
    }
    
    
    func getStateInfo() {
        guard let country = country else {return}
        let statesArray = LocationInfoHelper().getStateList(withCountryName: country.country)
        for state in statesArray {
            if !sectionKeysArray.contains(state.state_index) {
                sectionKeysArray.append(state.state_index)
            }
            if var tempArray = self.locationInfos[state.state_index] {
                tempArray.append(state)
                self.locationInfos[state.state_index] = tempArray
            } else {
                self.locationInfos[state.state_index] = [state]
            }
        }
        self.listTable.reloadData()
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let key = sectionKeysArray[indexPath.section]
        
        if let dataArray = locationInfos[key] {
            let dataModel = dataArray[indexPath.row]
            if dataModel.hasChildCity {
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
