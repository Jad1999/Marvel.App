//
//  ViewController.swift
//  Marvel App
//
//  Created by Jad Ghoson on 29/11/2023.
//

import UIKit
import Alamofire
import CryptoSwift
import SDWebImage

class ViewController: UIViewController{
    
    @IBOutlet weak var spinnerLoading: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    var newData : [results] = []
    //Properties Of Transfer Data
    var charachterID : Int = 0
    var comide : [items] = []
    var events : [items] = []
    var stories : [items] = []
    var series : [items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerLoading.hidesWhenStopped = true
        spinnerLoading.color = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SpecialCell", bundle: nil), forCellReuseIdentifier: "specialCell")
       
        
        //Navigation Custome
        if let navigationBar = self.navigationController?.navigationBar{
            let font = UIFont.boldSystemFont(ofSize: 16)
            let attributes: [NSAttributedString.Key: Any] = [
                .font:font,
                .foregroundColor: UIColor.white]
            navigationBar.largeTitleTextAttributes = attributes
            
        }

       
    //MARK: Calling API Methods
                getData { data in
                    self.newData = data
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                }
        
    }
      
    //MARK: API Charachter Details
    
    func getData(completion: @escaping ([results]) -> ()){
        let publicKey = "908e7f4455208685df47713b2b3664d3"
        let privateKey = "af9bdca73c822232ecb9c3b982e5e8f3150f9c51"
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        let baseURL = "https://gateway.marvel.com/v1/public/characters?"
        let api = "\(baseURL)apikey=\(publicKey)&hash=\(hash)&ts=\(ts)"
        let url = URL(string: api)
        guard url != nil else{
            print("error apiLink")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil , data != nil {
                let decoder = JSONDecoder()
                do{
                   let result = try decoder.decode(MarvelData.self, from: data!)
                    completion(result.data.results)
                  
                  
                }catch{
                    print("error")
                }
            }
        }
        dataTask.resume()
      }
    //MARK: Scroll Loading
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let activationThreshold: CGFloat = 100
      
        if maximumOffset - currentOffset <= activationThreshold {
            
            spinnerLoading.startAnimating()
            spinnerLoading.hidesWhenStopped = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0 ){
            self.spinnerLoading.stopAnimating()
            self.spinnerLoading.hidesWhenStopped = true
        }
       
    }
}
//MARK: API Images

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
    //MARK: TableView Methods
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  newData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specialCell", for: indexPath) as! SpecialCell
        let user = newData[indexPath.row]
        let imageURL = "\(user.thumbnail.path)/portrait_xlarge.jpg"
        _ = URL(string: imageURL)
        
        if user.description == ""{
            tableView.rowHeight = 150
        }else{
            tableView.rowHeight = UITableView.automaticDimension

        }
        
        
        
        cell.titleLabel?.text = user.name
        
        cell.bodyLabel?.text = user.description
        
        cell.imageCharacter.downloaded(from: imageURL)
       
        return cell
        
    }
    
    //MARK: Transfer Data to Selected Charachter
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        charachterID = newData[indexPath.row].id
        comide = newData[indexPath.row].comics.items
        events = newData[indexPath.row].events.items
        stories = newData[indexPath.row].stories.items
        series = newData[indexPath.row].series.items
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        performSegue(withIdentifier: "GoToDetails", sender: self)
    }
       override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "GoToDetails"{
                if let destinationcVC = segue.destination as? DetailsViewController{
                    destinationcVC.id = charachterID
                    destinationcVC.comicsMovies = comide
                    destinationcVC.storiesMovies = stories
                    destinationcVC.seriesMovies = series
                    destinationcVC.events = events
                
                }
            }
        }
    }

