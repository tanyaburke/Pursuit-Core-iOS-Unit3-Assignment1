//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

      @IBOutlet weak var tableView:UITableView!
      
      var appleStockDay = [[StockInfo]](){
          didSet{
              tableView.reloadData()
          }
      }
      
      override func viewDidLoad() {
          super.viewDidLoad()
          loadData()
          tableView.dataSource = self
      }
      
      func loadData(){
          appleStockDay = StockInfo.getStockDataAsMatrix()
      }
      
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          guard let applDVC = segue.destination as? StockDetailController, let indexPath = tableView.indexPathForSelectedRow else {
              fatalError("failed to segue to detail view controller")
          }
          let appleDayHistory  = appleStockDay[indexPath.section][indexPath.row]
          applDVC.passedApplDay = appleDayHistory
      }

  }

  extension ViewController:UITableViewDataSource{
      //cell functions
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return appleStockDay[section].count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
          let appleDayHistory  = appleStockDay[indexPath.section][indexPath.row]
          cell.textLabel?.text = appleDayHistory.date
          cell.detailTextLabel?.text = appleDayHistory.open.description
          return cell

      }
      
      //section functions
      
      func numberOfSections(in tableView: UITableView) -> Int {
          return appleStockDay.count
      }
      
      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          let average = StockInfo.averageForMonth(section: appleStockDay[section])
          return "\(appleStockDay[section].first!.date.convertDateStringtoString()) Average: \(String(format: "$%.02f", average))"
      }
  }
