//
//  DetailsViewModel.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import Foundation

class DetailsViewModel {
    var bandData: Band? = nil {
        didSet {
            refreshData()
        }
    }
    
    var refreshData = { () -> () in }
    
    func getBandData(with id: Int) {
        BandRepository.getBandInfo(with: id) { [weak self] band in
            self?.bandData = band
        }
    }
}
