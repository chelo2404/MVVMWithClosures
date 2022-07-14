//
//  DetailsViewController.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    var bandId = 0
    
    let activityIndicator = UIActivityIndicatorView()
    let detailsViewModel = DetailsViewModel()
    @IBOutlet weak var bandName: UILabel!
    @IBOutlet weak var bandThumbnail: UIImageView!
    @IBOutlet weak var bandGenre: UILabel!
    @IBOutlet weak var bandInformation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Information"
        setDefaultValues()
        configureActivityIndicator()
        bind()
        detailsViewModel.getBandData(with: bandId)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }
    
    private func bind() {
        detailsViewModel.refreshData = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.bandName.text = self?.detailsViewModel.bandData?.name
                self?.bandThumbnail.load(url: self?.detailsViewModel.bandData?.image)
                self?.bandGenre.text = self?.detailsViewModel.bandData?.genre?.rawValue
                self?.bandInformation.text = self?.detailsViewModel.bandData?.info
            }
        }
    }
    
    private func setDefaultValues() {
        self.bandThumbnail.image = UIImage(named: "placeholder")
        self.bandName.text = ""
        self.bandGenre.text = ""
        self.bandInformation.text = ""
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
