//
//  MyListSurveysViewController.swift
//  YouTellMeApp
//
//  Created by Utphala on 7/16/17.
//  Copyright © 2017 Utphala. All rights reserved.
//

import UIKit

class MyListSurveysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var surveys: [SurveyPointer] = [SurveyPointer]()
    // Hacky? - need it to update the count after netword call is done.
    var tableViewCopy: UITableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Giving result: \(self.surveys.count)")
        self.tableViewCopy = tableView
        return self.surveys.count;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Load data from service before the view is displayed
        BackendServiceClient().listSurveys(callback: { surveys, flag in
            if flag {
                DispatchQueue.main.async {
                    print("Fetched survey data!")
                    self.surveys = surveys
                    self.tableViewCopy.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    print("Error!")
                    self.surveys = [SurveyPointer]()
                }
            }
        })
        
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.surveys[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        print(currentCell.textLabel!.text!)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
