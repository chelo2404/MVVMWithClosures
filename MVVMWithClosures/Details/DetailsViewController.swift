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
        self.bandThumbnail.image = UIImage(named: "placeholder")
        bind()
        detailsViewModel.getBandData(with: bandId)
    }
    
    private func bind() {
        detailsViewModel.refreshData = { [weak self] in
            DispatchQueue.main.async {
                self?.bandName.text = self?.detailsViewModel.bandData?.name
                self?.bandThumbnail.load(url: self?.detailsViewModel.bandData?.image)
                self?.bandGenre.text = self?.detailsViewModel.bandData?.genre?.rawValue
                self?.bandInformation.text = self?.detailsViewModel.bandData?.info
            }
        }
    }
}
