//
//  ViewController.swift
//  yCheck
//
//  Created by Hint Desktop on 01/10/2017.
//  Copyright © 2017 Yacine.M. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    final let SourcesUrl = URL(string: "https://newsapi.org/v1/sources?language=en")
    private var sources = [Sources]()
    private var sourceID = String()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        // Init
        super.viewDidLoad()
        // Json Parsing
        getSources()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getSources() {
        guard let DownloadUrl = SourcesUrl else { return }
        
        URLSession.shared.dataTask(with: DownloadUrl) { (data, urlResponse, error) in
            guard let _ = data, error == nil else {
                print("Request Error")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let downloadedSources = try jsonDecoder.decode(SourceList.self, from: data!)
                self.sources = downloadedSources.sources
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Parsing Error")
            }
        }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SourcesCell") as? SourcesTableViewCell else { return UITableViewCell()}
        
        cell.NameLabel.text = "   \(sources[indexPath.row].name)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let NewsController = segue.destination as! NewsViewController
        NewsController.sourcesID = sourceID
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sourceID = sources[indexPath.row].id
        performSegue(withIdentifier: "GoToNews", sender: nil)
    }
    
    // Hide Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

