//
//  NewsViewController.swift
//  yCheck
//
//  Created by Hint Desktop on 01/10/2017.
//  Copyright © 2017 Yacine.M. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var sourcesID = String()
    private var SourcesUrl = URL(string: String())
    private var articles = [Articles]()
    private var articleSort = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view.
        if (articleSort) {
         SourcesUrl = URL(string: "https://newsapi.org/v1/articles?source=\(sourcesID)&apiKey=[APIKEY]")
        } else {
            SourcesUrl = URL(string: "https://newsapi.org/v1/articles?source=\(sourcesID)&sortBy=latest&apiKey=6[APIKEY]")
        }
        getArticles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticles() {
        guard let DownloadUrl = SourcesUrl else { return }
        
        URLSession.shared.dataTask(with: DownloadUrl) { (data, urlResponse, error) in
            guard let _ = data, error == nil else {
                print("Request Error")
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let downloadedSources = try jsonDecoder.decode(ArticlesList.self, from: data!)
                self.articles = downloadedSources.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Parsing Error for URL: \(String(describing: self.SourcesUrl!))")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticlesTableViewCell else { return UITableViewCell()}
        
        cell.Author.text = articles[indexPath.row].author
        cell.Title.text = articles[indexPath.row].title
        cell.Description.text = articles[indexPath.row].description
        cell.Date.text = articles[indexPath.row].publishedAt
        
        if (indexPath.row % 2 != 0) {
            cell.contentView.backgroundColor = UIColor.darkGray
        } else {
            cell.contentView.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let link = NSURL(string: articles[indexPath.row].url)
        UIApplication.shared.open(link! as URL, options: [:])
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        performSegue(withIdentifier: "GoToSources", sender: nil)
    }
    
    // Hide Status Bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Set First Responder
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // On Shake Detection
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        var AlertMessage = String()
        if motion == .motionShake {
            if (articleSort) {
                AlertMessage = "News are now sorted by the most viewed"
                self.articleSort = false
            } else {
                AlertMessage = "News are now sorted by the most recent"
                self.articleSort = true
            }
            let alertView = UIAlertController(title: "Shake Detection", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert)
            alertView.addAction(UIAlertAction(title: "I get it", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertView, animated: true, completion: nil)
            viewDidLoad()
        }
    }
    
}
