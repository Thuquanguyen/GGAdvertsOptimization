//
//  ColumnChartCustomView.swift
//  AIC Utilities People
//
//  Created by TiemLV on 6/7/19.
//  Copyright © 2019 Rikkeisoft. All rights reserved.
//

import UIKit
import Highcharts

struct ColumnChartCustomViewData {
    var name: String
    var value: Double
}


class ColumnChartCustomView: UIView {

    // MARK: - Outlets
    @IBOutlet weak var hiChartView: HIChartView!
    
    // MARK: - View's life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContentView()
    }
    
    private func initContentView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        hiChartView = nib.instantiate(withOwner: self, options: nil).first as? HIChartView
        hiChartView.frame = bounds
        hiChartView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                        UIView.AutoresizingMask.flexibleHeight]
        addSubview(hiChartView)
    }
    
    func showChart(data: [ColumnChartCustomViewData], colors: [String]? = nil) {
        let options = HIOptions()
        
        let chart = HIChart()
        chart.type = "column"
        options.chart = chart
        
        let exporting = HIExporting() // Remove button menu
        exporting.enabled = false
        options.exporting = exporting
        
        let credits = HICredits()
        credits.enabled = false
        options.credits = credits
        options.title = HITitle()
        options.title.text = ""
        
        let title = HITitle()
        title.text = ""
        options.title = title
        
        let xAxis = HIXAxis()
        xAxis.labels = HILabels()
        xAxis.labels.text = ""
        xAxis.labels.enabled = false
        options.xAxis = [xAxis]
        
        let yAxis = HIYAxis()
        yAxis.min = 0
        yAxis.showFirstLabel = false
        yAxis.title = HITitle()
        yAxis.title.text = ""
        options.yAxis = [yAxis]
        
        
        let legend = HILegend()
        legend.enabled = false
        options.legend = legend
        
        
        let tooltip = HITooltip()
        tooltip.shadow = true
        tooltip.useHTML = true
        tooltip.borderRadius = 8
        tooltip.borderColor = HIColor(hexValue: "FFFFFF")
        tooltip.shape = "<div style=\"border-radius: 10px; padding: 8px 16px 8px 16px; box-shadow: 0px 8px 12px 0px #16000000;\"></div>"
        tooltip.backgroundColor = HIColor(hexValue: "FFFFFF")
        tooltip.headerFormat = ""
        tooltip.pointFormat = "<span style=\"color:{point.color}; width: 8px; height: 8px; margin: 0px 16px 0px 0px;\">" + "\u{25A0}" + "</span>{point.name}<br/><p style=\"font-size: 16px; font-weight:bold; color:#3A454D; margin: 4px 0px 0px 24px;\">{point.y} ý kiến</p>"
        options.tooltip = tooltip

        
        let column = HIColumn()
        column.colorByPoint = true
        
        var listColumn: [Any] = []
        
        data.forEach { (item) in
            listColumn.append([item.name, item.value])
        }
        
        column.data = listColumn
        options.series = [column]
        
        
        if let colors = colors {
            options.colors = colors
        } else {
            options.colors = ["#45ED5C",
                              "#008FFF",
                              "#FFC900",
                              "#E62F10",
                              "#44D7B6",
                              "#6236FF",
                              "#FA6400",
                              "#B620E0",
                              "#0082C8",
                              "#FE7C00",
                              "#2E9067",
                              "#EF6474",
                              "#0091FF",
                              "#1F8FFF",
                              "#007AFF",
                              "#F5BF77",
                              "#44D7B6",
                              "#DBDBDB",
                              "#5CC961",
                              "#E1BF90",
                              "#45ED5C",
                              "#008FFF",
                              "#FFC900",
                              "#E62F10",
                              "#44D7B6",
                              "#6236FF",
                              "#FA6400",
                              "#B620E0"]
        }
        
        hiChartView.options = options
    }

}
