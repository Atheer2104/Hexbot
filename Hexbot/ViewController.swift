//
//  ViewController.swift
//  Hexbot
//
//  Created by Atheer on 2019-06-13.
//  Copyright © 2019 Atheer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var fetchColors = FetchColors()
    var defaultCount = 1
    var count = 1
    var colorTimer: Timer!
    
    var hexValue = "" {
        didSet {
            navigationItem.title = "Hex Value: \(hexValue)"
        }
    }
    
    @IBOutlet var ColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Hex Value:"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshColor))
        
        let startTimerButton = UIBarButtonItem(title: "Start Timer", style: .plain, target: self, action: #selector(startTimerColor))
        
        let stopTimerButton = UIBarButtonItem(title: "Stop Timer", style: .plain, target: self, action: #selector(stopTimerColor))
        
        navigationItem.leftBarButtonItems = [refreshButton, startTimerButton, stopTimerButton]

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fetch new colors", style: .plain, target: self, action: #selector(setupAlertAndFetchColorsInBackground))
        
        setupAlertAndFetchColorsInBackground()
        
    }
    
    @objc func startTimerColor() {
        if colorTimer == nil {
            
            colorTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshColor), userInfo: nil, repeats: true)
        }
    }
    
    @objc func stopTimerColor() {
        if colorTimer != nil {
            colorTimer.invalidate()
            colorTimer = nil
        }
    }
    
    @objc func setupAlertAndFetchColorsInBackground() {
        let ac = UIAlertController(title: "Count", message: "How many colors would you like to fetch", preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Okay", style: .default) {
            [weak self, weak ac] action in
            
            guard let answer = ac?.textFields?[0].text else { return }
            let answerInt = Int(answer) ?? self?.defaultCount
            self?.count = answerInt!
            
            self?.fetchColorsInBackground(count: self!.count)
            }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func refreshColor() {
        fetchColors.colors.shuffle()
        assignColor()
    }
    
    func assignColor() {
        guard let newColor = fetchColors.colors.first?.value else { return }
              
       hexValue = newColor
       UIView.animate(withDuration: 1) {
           self.ColorView.backgroundColor = UIColor(hex: newColor)
       }
    }
    
    func fetchColorsInBackground(count: Int) {
        DispatchQueue.global(qos: .background).async {
            do {
                self.fetchColors.fetchJson(count: count)
            }
            DispatchQueue.main.async {
                self.assignColor()
            }
        }
    }

}

