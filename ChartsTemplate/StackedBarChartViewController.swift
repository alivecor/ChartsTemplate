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
        
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        
        
        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.labelPosition = .bottom
        xAxis.labelCount = 3
        xAxis.valueFormatter = MonthAxisValueFormatter()
        xAxis.labelFont = .boldSystemFont(ofSize: 16)
        
        let l = chartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .bottom
        
        chartView.delegate = self
        return chartView
    }
    
    func setChartData() {
        let values: [[Double]] = [[4, 10, 20, 30], [5, 20, 40, 30], [6, 5, 10, 20]]
        let yVals = values.map { (item) -> BarChartDataEntry in
            return BarChartDataEntry(x: item[0], yValues: [item[1], item[2], item[3]])
        }
        let set = BarChartDataSet(entries: yVals)
        set.colors = [.orange, .green, .yellow]
        set.drawIconsEnabled = false
        

        
        let data = BarChartData(dataSet: set)
        chartView.fitBars = true
        chartView.data = data
        
    }
    
}

// MARK: - ChartViewDelegate

extension StackedBarChartViewController: ChartViewDelegate {
    
}


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
