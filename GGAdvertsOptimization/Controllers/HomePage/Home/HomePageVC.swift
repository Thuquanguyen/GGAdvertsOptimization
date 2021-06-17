//
//  HomePageVC.swift
//  YTeThongMinh
//
//  Created by DatTV on 5/26/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import UIKit

class HomePageVC: UIViewController {
    // MARK: - Properties
    // MARK: - ViewController's life cycle
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[String] = ["Facebook Conversions API: Everything Marketers Need to Know","Top Facebook Updates You Can’t Miss (May 2021 Edition)","5 Ways to Improve Your Facebook Ad Conversion Rates","12 Facebook Ad Targeting Tips to Increase Your ROAS","15 Call To Action Examples (and How to Write the Perfect CTA)","How to Increase Facebook Engagement (Free Calculator)","12 of the Most Common Facebook Ad Mistakes Marketers Must Avoid","Understanding the Facebook Algorithm in 2021: Ranking Signals and Tips","Why You Need a Facebook Ads Audit (+ How To Do It in 6 Steps)","Facebook Automated Ads: Everything You Need to Know to Get Started","Facebook Ads Reporting 101: 6 Metrics You Should be Tracking","The Ultimate Facebook Ads Budgets Breakdown (+ Free Calculator)"]
    var dataSearch:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.dataSearch = dataSource
    }
    
    @IBAction func textChangeEdit(_ sender: UITextField) {
        if sender.text?.isEmpty ?? false{
            dataSearch = dataSource
            tableView.reloadData()
        }else{
            dataSearch = dataSource.filter{($0.lowercased().contains(sender.text?.trimWhiteSpacesAndNewLines.lowercased() ?? ""))}
            tableView.reloadData()
        }
        print("textkakakaka : \(sender.text ?? "")")
    }
    
}

extension HomePageVC{
    private func setupTableView(){
        tableView.registerNibCellFor(type: ArticlCell.self)
    }
}

extension HomePageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: ArticlCell.self, for: indexPath)
        cell.selectionStyle = .none
        cell.initData(title: dataSearch[indexPath.row],index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleDetailVC()
        vc.titleArticle = dataSearch[indexPath.row]
        vc.indexArticle = indexPath.row
        self.push(vc)
    }
    
}
