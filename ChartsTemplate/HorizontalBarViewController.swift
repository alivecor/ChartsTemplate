//
//  HorizontalBarViewController.swift
//  ChartsTemplate
//
//  Created by Rex Hsu on 1/31/23.
//

import Foundation
import UIKit
import Charts

class HorizontalBarViewController: UIViewController {
    
    struct BarItem {
        let title: String
        let count: Int
    }
    
    private enum Constants {
        static let charWidth: CGFloat = UIScreen.main.bounds.width - 10
        static let chartHeight: CGFloat = 500
    }
    
    var chartView: HorizontalBarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Horizontal Bar Chart"
        view.backgroundColor = .white
        
        configureSubviews()
        setChartData()
    }
    
}

private extension HorizontalBarViewController {
    
    func createChartView() -> HorizontalBarChartView {
        
        let chartView = HorizontalBarChartView(frame: CGRect(x: 0, y: 100, width: Constants.charWidth, height: Constants.chartHeight))
        chartView.legend.enabled = false
        // draw the value outside the bar if drawValueAboveBarEnabled == true.
        chartView.drawValueAboveBarEnabled = true
        chartView.drawBarShadowEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.centerAxisLabelsEnabled = true
        xAxis.enabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = EmptyLabelFormatter()
        xAxis.axisMinimum = -5
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.enabled = false
        
        let rightAxis = chartView.rightAxis
        rightAxis.drawZeroLineEnabled = false
        rightAxis.drawGridLinesEnabled = false
        rightAxis.valueFormatter = EmptyLabelFormatter()
    
        
        chartView.fitBars = true
    
        
        return chartView
    }
    
    func configureSubviews() {
        chartView = createChartView()
        view.addSubview(chartView)
    }
    
    func setChartData() {
        let barWidth: Double = 9
        let spaceForBar: Double = 10
        
        let items = [
            BarItem(title: "Atrial Fibrillation with Anxiety", count: 100),
            BarItem(title: "Normal Sinus Rhythm with Anxiety", count: 16),
            BarItem(title: "Tachycardia with Exercise", count: 39),
            BarItem(title: "Atrial Fibrillation with Caffeine", count: 7),
            BarItem(title: "Other", count: 46)]
        // Because the order of the drawing is from the bottom to the top, if we want draw the item from top to the bottom, we need to reverse the entries.
        let yVals = items.reversed().enumerated().map { (index, item) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(index) * spaceForBar, y: Double(item.count), data: item.title)
        }
        
        let set1 = BarChartDataSet(entries: yVals)
        set1.colors = [.lightGray]
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(.systemFont(ofSize: 16))
        data.barWidth = barWidth

        chartView.data = data
        
    }
}

// MARK: - EmptyLabelFormatter

class EmptyLabelFormatter: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: Charts.AxisBase?) -> String {
        return ""
    }
}
