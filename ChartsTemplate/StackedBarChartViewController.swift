//
//  StackedBarChartViewController.swift
//  ChartsTemplate
//
//  Created by Rex Hsu on 1/31/23.
//

import Foundation
import UIKit
import Charts

class StackedBarChartViewController: UIViewController {
    
    var chartView: BarChartView!
    
    private enum Constants {
        static let charWidth: CGFloat = UIScreen.main.bounds.width - 10
        static let chartHeight: CGFloat = 300
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        title = "Stacked Bar Chart"
        
        setChartData()
    }
    
}

// MARK: - Private

private extension StackedBarChartViewController {
    
    func configureSubviews() {
        view.backgroundColor = .white
        chartView = createChartView()
        view.addSubview(chartView)
    }
    
    func createChartView() -> BarChartView {
        let chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: Constants.charWidth, height: Constants.chartHeight))
        chartView.chartDescription.enabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 3
        xAxis.valueFormatter = MonthAxisValueFormatter()
        xAxis.labelFont = .boldSystemFont(ofSize: 16)

        return chartView
    }
    
    func setChartData() {
        let values: [[Double]] = [[4, 0, 1, 0], [5, 20, 40, 30], [6, 5, 10, 200]]
        let yVals = values.map { (item) -> BarChartDataEntry in
            return BarChartDataEntry(x: item[0], yValues: [item[1], item[2], item[3]])
        }
        let set = BarChartDataSet(entries: yVals)
        set.colors = [.orange, .green, .red]
        set.drawIconsEnabled = false
        set.valueFont = .boldSystemFont(ofSize: 14)
        
        let data = BarChartData(dataSet: set)
        data.setValueFormatter(StackedBarChartValueFormatter())
        
        chartView.fitBars = true
        chartView.data = data
    }
    
}

// MARK: - StackedBarChartValueFormatter

class StackedBarChartValueFormatter: ValueFormatter {
    
    func stringForValue(_ value: Double, entry: Charts.ChartDataEntry, dataSetIndex: Int, viewPortHandler: Charts.ViewPortHandler?) -> String {
        
        guard let barChartDataEntry = entry as? BarChartDataEntry else {
            return ""
        }
        
        var nonZeroYValues : [Double] = []
        barChartDataEntry.yValues?.forEach { yValue in
            if yValue != 0.0 {
                nonZeroYValues.append(yValue)
            }
        }
        
        if nonZeroYValues.last == value {
            return String(Int(entry.y))
        }
        else {
            return ""
        }
    }
}
 
// MARK: - MonthAxisValueFormatter
class MonthAxisValueFormatter: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        guard value > 0, value < 13 else {
            assertionFailure("invalid month: \(value)")
            return "???"
        }
        let dateFormatter = DateFormatter()
        let month = dateFormatter.monthSymbols[Int(value-1)]
        return month
    }
}
