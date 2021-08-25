//
//  HomeViewController.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var timelineCollectionView: UICollectionView!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    
    //MARK: - Variables
    var weather: Weather!
    var dailyWeathers: [DailyWeather]!
    var timelineWeathers = [AnyObject]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func config() {
        configCollectionView()
    }
    
    func configCollectionView() {
        timelineCollectionView.dataSource = self
        timelineCollectionView.delegate = self
//        timelineCollectionView.register(UINib.init(nibName: "TimelineCell", bundle: nil), forCellWithReuseIdentifier: "TimelineCell")
        timelineCollectionView.registerCell(type: TimelineCell.self)
        
        dailyCollectionView.dataSource = self
        dailyCollectionView.delegate = self
        dailyCollectionView.registerCell(type: DailyCell.self)
    }

    func fetchData() {
        APIService().getWeather { weather in
            if let weather = weather {
                self.weather = weather
                self.processWeather()
                self.updateUI()
                //Update UI
            }
            // UPdate UI with Weather
        }
    }
    
    
    //MARK: - Helper
    
    func processWeather() {
        self.dailyWeathers = self.weather.dailyWeathers
        processTimelineWeathers()
    }
    
    func processTimelineWeathers() {
        timelineWeathers.append(self.weather.currentWeather!)
        timelineWeathers.append(contentsOf: self.weather.hourlyWeathers)
        // Thêm các Object Sunrise và Sunset xuất hiện trong 24 tiếp theo
    }
    
    func updateUI() {
        self.timelineCollectionView.reloadData()
        self.dailyCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == timelineCollectionView {
            return timelineWeathers.count
        } else {
            return dailyWeathers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == timelineCollectionView {
            //collectionView.dequeueReusableCell(withReuseIdentifier: "TimelineCell", for: indexPath)
            let timelineCell = collectionView.dequeueCell(type: TimelineCell.self, indexPath: indexPath)
            timelineCell?.bind(data: timelineWeathers[indexPath.item])
            return timelineCell ?? UICollectionViewCell()
        } else {
            let dailyCell = collectionView.dequeueCell(type: DailyCell.self, indexPath: indexPath)
            dailyCell?.bind(data: dailyWeathers[indexPath.item])
            return dailyCell ?? UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
}

// 1. Implement hoàn thiện giao diện file Xib
// 2. Implement phần UICollectionViewDelegateFlowLayout (Kích thước Cell)
// 3. Set Hướng cho từng collectionView trên file Xib (dọc/ ngang)
// 4. Implement hàm bind(data:__) trong Cell. ( thêm icon/ set text...v..v)


// 5. Thêm Sunrise và Sunset vào timeline
