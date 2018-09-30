//
//  LocationListBaseController.swift
//  CityPicker
//
//  Created by 龚杰洪 on 2018/9/28.
//  Copyright © 2018年 龚杰洪. All rights reserved.
//

import UIKit

public class LocationListBaseController: UIViewController {
    internal weak var listTable: UITableView!
    internal var locationInfos: [String: [LocationModel]] = [:]
    internal var sectionKeysArray: [String] = []
    
    public typealias CompleteCallbackBlock = (LocationModel) -> Void
    
    public var callbackBlock: CompleteCallbackBlock?
    
    public enum Style {
        case normal
        case dark
    }
    
    public enum LocationType {
        case country
        case state
        case city
    }
    
    public var locationType: LocationType = .country
    
    public var style: Style = .normal
    
    private struct Reuse {
        static var LocationListCell = "LocationListCell"
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupListTable()
    }
    
    private func setupListTable() {
        let tempTableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        listTable = tempTableView
        listTable.translatesAutoresizingMaskIntoConstraints = false
        listTable.delegate = self
        listTable.dataSource = self
        listTable.register(LocationListCell.self, forCellReuseIdentifier: Reuse.LocationListCell)
        listTable.sectionIndexTrackingBackgroundColor = UIColor.clear
        listTable.sectionIndexBackgroundColor = UIColor.clear
        listTable.sectionIndexColor = UIColor.gray
        listTable.backgroundColor = UIColor.white
        listTable.estimatedSectionHeaderHeight = 0
        listTable.estimatedSectionFooterHeight = 0
        listTable.estimatedRowHeight = 0
        if #available(iOS 11.0, *) {
            listTable.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(listTable)
        listTable.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        listTable.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            listTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            listTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            listTable.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            listTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }
}

extension LocationListBaseController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionKeysArray.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sectionKeysArray[section]
        
        if let dataArray = locationInfos[key] {
            return dataArray.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: LocationListCell
        if let tempCell = tableView.dequeueReusableCell(withIdentifier: Reuse.LocationListCell,
                                                        for: indexPath) as? LocationListCell
        {
            cell = tempCell
        } else {
            cell = LocationListCell(style: UITableViewCell.CellStyle.default,
                                    reuseIdentifier: Reuse.LocationListCell)
        }
        let key = sectionKeysArray[indexPath.section]
        
        if let dataArray = locationInfos[key] {
            let dataModel = dataArray[indexPath.row]
            
            switch locationType {
            case .country:
                cell.textLabel?.text = dataModel.country
                break
            case .state:
                cell.textLabel?.text = dataModel.state
                break
            case .city:
                cell.textLabel?.text = dataModel.city
                break
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor.black
        headerLabel.text = "   " + sectionKeysArray[section]
        headerLabel.backgroundColor = UIColor.gray
        
        if style == .normal {
            
        } else {
            
        }
        
        return headerLabel
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionKeysArray
    }
}
