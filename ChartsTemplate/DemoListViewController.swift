//
//  DemoListViewController.swift
//  ChartsTemplate
//
//  Created by Rex Hsu on 1/30/23.
//

import UIKit

private struct ItemDef {
    let title: String
    let `class`: AnyClass
}

class DemoListViewController: UITableViewController {
    
    private var itemDefs = [
        ItemDef(title: "Stacked Bar Chart", class: StackedBarChartViewController.self),
        ItemDef(title: "Horizontal Bar Chart", class: HorizontalBarViewController.self)
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Charts Demo"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemDefs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let def = itemDefs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = def.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let def = itemDefs[indexPath.row]
        
        let vcClass = def.class as! UIViewController.Type
        let vc = vcClass.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

