//
//  DetailsViewController.swift
//  Marvel App
//
//  Created by Jad Ghoson on 05/12/2023.
//

import Foundation
import UIKit
class DetailsViewController: UIViewController{
    
    @IBOutlet weak var charachterID: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    //Types Of Selected Cell
    var id = 0
    var comicsMovies : [items] = []
    var storiesMovies : [items] = []
    var seriesMovies : [items] = []
    var events : [items] = []
    //Section Types
    struct SectionTypes{
        var sectionName : String!
        var sectionObjects :[items]
    }
    var objectsArray = [SectionTypes]()
    let sectionImage = [UIImage(named: "Marvel"),UIImage(named: "Marvel"),UIImage(named: "Marvel"),UIImage(named: "Marvel")]
    
    
    override func viewDidLoad() {
        charachterID.text = "CharacterID:\(id)"
        tableView.delegate = self
        tableView.dataSource = self
        
        objectsArray = [SectionTypes(sectionName: "Comics", sectionObjects: comicsMovies),
                        SectionTypes(sectionName: "Stories", sectionObjects: storiesMovies),
                        SectionTypes(sectionName: "Series", sectionObjects: seriesMovies),
                        SectionTypes(sectionName: "Events", sectionObjects: events)]
    }
}
   //MARK: TableView Methods
extension DetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 0, green: 0.07058823529, blue: 0.2549019608, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row].name
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor =  UIColor.black
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 5, width: 100, height: 35))
        
        imageView.image = sectionImage[section]
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        let label = UILabel()
        label.textColor = UIColor.orange
        label.font = UIFont.italicSystemFont(ofSize: 18.0)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = objectsArray[section].sectionName
        label.frame = CGRectMake(80, 5, 100, 35)
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
