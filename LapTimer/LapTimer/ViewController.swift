//
//  ViewController.swift
//  LapTimer
//
//  Created by Pavel N on 8/9/19.
//  Copyright © 2019 Pavel N. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lapBtn: UIButton!
    @IBOutlet var stopBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.beginRefreshing()
        // Do any additional setup after loading the view.
        createContainer{ container in
            self.context = container.viewContext
        }
        timeLabel.isHidden = true
        lapBtn.isHidden = true
    }
    
    
    @IBAction func startBtnPressed(_ sender: UIButton) {
        isRunning = !isRunning
        timeLabel.isHidden = !isRunning
        lapBtn.isHidden = !isRunning
        if isRunning
        {
            startTime = Date()
            stopBtn.setTitle("Stop", for: .normal)
        }
        else
        {
            stopBtn.setTitle("Start", for: .normal)
            removeData()
            fetchData()
        }
    }
    @IBAction func lapBtnPressed(_ sender: Any) {
        guard let ctx = self.context else {return}
        let laps = NSEntityDescription.insertNewObject(forEntityName: "Laps", into: ctx) as? Laps
        let diff = Date().timeIntervalSince(startTime!)
        do {
            laps?.time = diff
            try ctx.save()
        } catch  {
            print("save faled")
        }
        fetchData()
    }
    
    func createContainer(completition: @escaping (NSPersistentContainer) -> () ) {
        let container = NSPersistentContainer(name: "LapsTimeModel")
        container.loadPersistentStores(completionHandler: {_, error in
            guard error == nil else {fatalError("Failed to load store")}
            DispatchQueue.main.async {
                completition(container)
            }
        })
    }
    func fetchData() {
        let request = NSFetchRequest<Laps>(entityName: "Laps")
        do {
            laps = try context.fetch(request)
        } catch {
            return
        }
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func removeData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Laps")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            // Error Handling
        }
    }
    
    private let cellIdentifier = "TimerCell"
    fileprivate var laps = [Laps] ()
    private var startTime:Date?
    private var context:NSManagedObjectContext!
    {
        didSet{
            context.reset()
            fetchData()
        }
    }
    private var isRunning:Bool = false
}

extension ViewController : UITableViewDelegate {}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let time = laps[indexPath.row].time
        cell.textLabel?.text = String(time.stringFromTimeInterval())
        return cell
    }
}

extension TimeInterval{
    
    func stringFromTimeInterval() -> String {
        
        let time = NSInteger(self)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}
