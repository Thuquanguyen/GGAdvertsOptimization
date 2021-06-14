//
//  PieChartCustomView.swift
//  CTT_BN
//
//  Created by PhuongTHN-D1 on 5/1/19.
//  Copyright © 2019 VietHD-D3. All rights reserved.
//

import UIKit
import Highcharts

protocol DidSelectPieDelegate: class {
    func numberOfBar(x: Int?, name: Int?)
    func numberOfPie(number: Int?)
}

class PieChartCustomView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var hiChartView: HIChartView!
    
    // MARK: - Properties
    var isEmer = false
    var innerSize = 200
    var isShowInLegend = true
    
    // MARK: - Delegates
    var didSelectedPie : ((_ index: Int?, _ value: Double?) -> ())?
    weak var delegate: DidSelectPieDelegate?
    
    // MARK: - View's life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        initContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initContentView()
    }
    
    fileprivate func initContentView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        hiChartView = nib.instantiate(withOwner: self, options: nil).first as? HIChartView
        hiChartView.frame = bounds
        hiChartView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,
                                        UIView.AutoresizingMask.flexibleHeight]
        addSubview(hiChartView)
    }
    
    func showChart(title: String = " ",  data: [PieChartCustomViewData], tooltip: HITooltip? = nil, legend: HILegend? = nil, isInner: Bool = false, colors: [String]? = nil, completion: (()->Void)? = nil) {
        
        let options = HIOptions()
        
        let chart = HIChart()
        chart.plotBackgroundColor = HIColor()
        chart.plotBorderWidth = NSNumber()
        chart.plotShadow = NSNumber(value: false)
        chart.type = "pie"
        
        let chartTitle = HITitle()
        chartTitle.text = title
        
        let tooltip = HITooltip()

        tooltip.pointFormat = "{series.name}: <b>{point.percentage:.1f}%</b>"        
        
        let plotoptions = HIPlotOptions()
        plotoptions.pie = HIPie()
        plotoptions.pie.allowPointSelect = NSNumber(value: true)
        plotoptions.pie.cursor = "pointer"
        plotoptions.pie.dataLabels = HIDataLabelsOptionsObject()
        plotoptions.pie.dataLabels.enabled = NSNumber(value: false)
        plotoptions.pie.showInLegend = NSNumber(value: isShowInLegend)

        plotoptions.pie.animation = HIAnimationOptionsObject()
        plotoptions.pie.animation.duration = NSNumber(value: 500)
        plotoptions.pie.animation.complete = HIFunction(closure: { _ in
            completion?()
        })
        
        let pie = HIPie()
        if isInner {
            pie.innerSize = innerSize
        }
        pie.name = "Tỉ lệ"

        var dataForChart: [[String:Any]] = []
        
        for i in 0...data.count - 1 {
            dataForChart.append(["name": data[i].name, "y": data[i].value])
        }
        
        pie.data = dataForChart

        // disable open highcharts forums
        let navigation = HINavigation()
        let buttonOptions = HIButtonOptions()
        buttonOptions.enabled = false
        navigation.buttonOptions = buttonOptions
        options.navigation = navigation
        
        let credits = HICredits()
        credits.enabled = false
        options.credits = credits
        options.credits.enabled = false
        options.chart = chart
        
        if let colors = colors {
            options.colors = colors
        } else {
            options.colors = ["#3998FF", "#0649DB", "#0649DB", "#75DC53" , "#FFD139", "#C8C8C8"]
        }
        
        options.title = chartTitle
        options.tooltip = tooltip
        options.plotOptions = plotoptions
        options.series = [pie]
        
        options.series.forEach { seri in
            let hifunction = HIFunction(closure: { context in
                self.didSelectedPie?(context?.getProperty("this.x") as? Int,
                                     context?.getProperty("this.y") as? Double)
            }, properties: ["this.x", "this.y"])
            
            let events = HIEvents()
            events.click = hifunction
            let point = HIPoint()
            seri.point = point
            point.getParams()
            seri.point.events = events
        }
        
        if isEmer {
            let event = HIEvents()
            event.click = HIFunction(closure: { (context) in
                self.delegate?.numberOfPie(number: context?.getProperty("this.x") as? Int)
            }, properties: ["this.x"])
            
            let point = HIPoint()
            point.events = event
            options.series.forEach { serie in
                serie.point = point
            }
        }
        
        hiChartView.options = options
    }
}

struct PieChartCustomViewData {
    var name: String
    var value: Double
}
