//
//  HiChart.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 5/30/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation
import UIKit
import Highcharts

class HiChartView {
    
    var zoomChart:(() -> Void)?
    
    @objc func zoomOut(){
        zoomChart?()
    }
    
    func initChart(chartView : HIChartView,dataChart: [[Any]],minY: Int,titleChart: String,max: Int,min: Int,sys: Int,dia: Int,isShowRight: Bool = true,isDay: Bool = false){
        
        chartView.plugins = ["series-label"]
        let viewRight = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        viewRight.backgroundColor = UIColor.white
        chartView.addSubview(viewRight)
        viewRight.frame = CGRect(x: chartView.width - 50, y: 0, width: 60, height: 30)
        if isShowRight {
            let imageButton = ImageButton(frame: CGRect(x: -15, y: 0, width: 50, height: 50))
            imageButton.iconImage = UIImage(named: "icon_zoom")
            viewRight.addSubview(imageButton)
            imageButton.addSingleTapGesture(target: self, selector: #selector(zoomOut))
        }
        let chart = HIChart()
        let options = HIOptions()
        
        let data = HIData()
        data.columns = dataChart
        
        let credits = HICredits()
        credits.enabled = false
        options.credits = credits
        options.title = HITitle()
        options.title.text = ""
        
        let title = HITitle()
        title.text = titleChart
        title.align = "left"
        
        let xaxis = HIXAxis()
        xaxis.tickWidth = 0
        xaxis.crosshair = HICrosshair.init()
        xaxis.title = HITitle()
        xaxis.labels = HILabels()
        xaxis.title.text = ""
        xaxis.labels.text = ""
        xaxis.type = "datetime"
        if !isDay {
            xaxis.tickInterval =  NSNumber(value: 24 * 3600 * 1000 )
        }else{
            xaxis.tickInterval = NSNumber(value: 60 * 1000)
        }
        xaxis.dateTimeLabelFormats = HIDateTimeLabelFormats()
        xaxis.dateTimeLabelFormats.day = HIDay()
        xaxis.dateTimeLabelFormats.hour = HIHour()
        xaxis.dateTimeLabelFormats.day.main = "%d/%m"
        xaxis.dateTimeLabelFormats.hour.main = "%H:%M"
        
        let yaxis1 = HIYAxis()
        yaxis1.title = HITitle()
        yaxis1.labels = HILabels()
        if titleChart != "Nhịp tim"
        {
            yaxis1.max = NSNumber(value: max + 10)
            yaxis1.min = NSNumber(value: min - 10)
            yaxis1.tickInterval = 10
        }
        yaxis1.title.text = ""
        var lines:[HIPlotLines] = [HIPlotLines]()
        
        let hiPlotLines = HIPlotLines()
        hiPlotLines.value = NSNumber(value: sys)
        hiPlotLines.width = 1.5
        hiPlotLines.color = HIColor(name: "#d34836")
        hiPlotLines.dashStyle = "shortdash"
        
        let hiPlotLines2 = HIPlotLines()
        hiPlotLines2.value = NSNumber(value: dia)
        hiPlotLines2.width = 1.5
        hiPlotLines2.color = HIColor(name: "#239389")
        hiPlotLines2.dashStyle = "shortdash"
        
        lines.append(hiPlotLines)
        lines.append(hiPlotLines2)
        yaxis1.plotLines = lines
        
        let legend = HILegend()
        legend.enabled = false
        
        let tooltip = HITooltip()
        tooltip.shared = NSNumber(value: true)
        tooltip.borderColor = HIColor.init(hexValue: "#D6D6D6")
        tooltip.dateTimeLabelFormats = HIDateTimeLabelFormats()
        tooltip.dateTimeLabelFormats.day = HIDay()
        tooltip.dateTimeLabelFormats.hour = HIHour()
        if isDay {
            tooltip.dateTimeLabelFormats.day.main = "%H:%M Ngày %d/%m/%Y"
            tooltip.xDateFormat = "%H:%M Ngày %d/%m/%Y"
        }else{
            tooltip.dateTimeLabelFormats.day.main = "Ngày %d/%m/%Y"
            tooltip.xDateFormat = "Ngày %d/%m/%Y"
        }
        tooltip.dateTimeLabelFormats.hour.main = "%H:%M"
        
        let plotoptions = HIPlotOptions()
        plotoptions.series = HISeries()
        plotoptions.series.cursor = "pointer"
        plotoptions.series.point = HIPoint()
        plotoptions.series.marker = HIMarker()
        if minY == 2 {
            plotoptions.series.marker.enabled = true
        }else{
            plotoptions.series.marker.enabled = false
        }
        plotoptions.column = HIColumn()
        plotoptions.column.colorByPoint = true
        if titleChart == "Nhịp tim"
        {
            options.colors = [UIColor.clear.color(),UIColor.clear.color(),"#026DC3"]
        }else{
            options.colors = ["#FF5733","#239389",UIColor.clear.color()]
        }
        
        let series = HISeries()
        series.lineWidth = NSNumber(value: 1)
        series.marker = HIMarker()
        if minY == 2 {
            series.marker.enabled = true
        }else{
            series.marker.enabled = false
        }
        let export = HIExporting()
        export.enabled = false
        
        options.time = HITime()
        options.time.useUTC =  false
        options.exporting = export
        options.chart = chart
        options.data = data
        options.title = title
        options.xAxis = [xaxis]
        options.yAxis = [yaxis1]
        options.legend = legend
        options.tooltip = tooltip
        options.plotOptions = plotoptions
        options.series = [series]
        
        chartView.options = options
    }
    
}
