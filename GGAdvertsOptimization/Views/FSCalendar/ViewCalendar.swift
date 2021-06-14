//
//  ViewCalendar.swift
//  YTeThongMinh
//
//  Created by ThuNQ on 6/6/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit
import FSCalendar

class ViewCalendar: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var viewBack: UIView!
    @IBOutlet var viewForward: UIView!
    @IBOutlet weak var calendarView: FSCalendar!
    
    // MARK: - Properties
    let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 260, height: 500))
    var currenDate = Date()
    var selectedDate = Date()
    var maxDate: Date?
    var minDate: Date?
    
    // MARK: - Closures
    var didSelect: ((_ date: Date) -> Void)?
    
    // MARK: - ViewController's life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.calendarHeaderView.backgroundColor = UIColor(hexa: "495A72")
        calendar.calendarWeekdayView.backgroundColor = UIColor(hexa: "495A72")
        calendar.appearance.headerTitleColor = UIColor.white
        calendar.appearance.headerTitleFont = .robotoBold(size: 14)
        calendar.appearance.weekdayTextColor = UIColor.white
        calendar.appearance.weekdayFont = .robotoRegular(size: 12)
        calendar.appearance.todayColor = UIColor("6FD3D5")
        viewBack.addSingleTapGesture(target: self, selector: #selector(backCalender))
        viewForward.addSingleTapGesture(target: self, selector: #selector(nextCalender))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customView(viewCustom: calendarView)
        calendar.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        view.addSubview(calendar)
        calendar.addSubview(viewBack)
        calendar.addSubview(viewForward)
        viewBack.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        viewForward.frame = CGRect(x: calendar.width - 60, y: 0, width: 60, height: 30)
        self.calendarView = calendar
        calendar.select(selectedDate, scrollToDate: true)
        calendar.locale = Locale.init(identifier: "vi_VN")
        calendar.firstWeekday = 2
    }
}

extension ViewCalendar {
    // Func setup click next and forward calendar
    @objc func nextCalender(){
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
        
    }
    
    @objc func backCalender(){
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }
}

extension ViewCalendar {
    // Function setup View
    private func customView(viewCustom: UIView){
        viewCustom.layer.cornerRadius = 3
        viewCustom.layer.borderWidth = 1
        viewCustom.layer.borderColor = UIColor(hexa: "5C6C7F").cgColor
    }
    
    // Function get next month
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    // Function get pervious month
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
}


extension ViewCalendar : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        didSelect?(date)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.remove()
        })
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if let minDate = self.minDate {
            return date >= minDate
        }
        if let maxDate = self.maxDate {
            return date <= maxDate
        }
        
        return date <= currenDate
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        //Do some checks and return whatever color you want to.
        return UIColor.purple
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        if date > currenDate {
            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        }
        return nil
    }
}

