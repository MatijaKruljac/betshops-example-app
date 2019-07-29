//
//  BetshopsDetailsUseCase.swift
//  Betshops
//
//  Created by Matija Kruljac on 3/31/19.
//  Copyright © 2019 Matija Kruljac. All rights reserved.
//

import Foundation

class BetshopsDetailsUseCase {
    
    private let presenter: BetshopDetailsPresenter
    
    init(presenter: BetshopDetailsPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    
    func showWorkingHoursDescription(for betshop: BetshopViewModel) {
        guard let workingHourStartDate = betshop.workingHourStart?.asDate,
            let workingHourEndDate = betshop.workingHourEnd?.asDate else {
                presenter.setWorkingHours(description: "Unknown")
                return
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentTime = calendar.dateComponents([.hour], from: currentDate)
        let workingHourStartTime = calendar.dateComponents([.hour], from: workingHourStartDate)
        let workingHourEndTime = calendar.dateComponents([.hour], from: workingHourEndDate)
        
        guard let currentTimeHour = currentTime.hour,
            let workingHourStartTimeHour = workingHourStartTime.hour,
            let workingHourEndTimeHour = workingHourEndTime.hour else {
                presenter.setWorkingHours(description: "Unknown")
                return
        }
        
        let description = generateWorkingHoursDescription(for: betshop,
                                                          currentTimeHour: currentTimeHour,
                                                          workingHourStartTimeHour: workingHourStartTimeHour,
                                                          workingHourEndTimeHour: workingHourEndTimeHour)
        presenter.setWorkingHours(description: description)
    }
    
    // MARK: - Private methods
    
    private func generateWorkingHoursDescription(for betshop: BetshopViewModel,
                                                 currentTimeHour: Int,
                                                 workingHourStartTimeHour: Int,
                                                 workingHourEndTimeHour: Int) -> String {
        if currentTimeHour >= workingHourStartTimeHour &&
            currentTimeHour < workingHourEndTimeHour {
            return "Open now until \(betshop.workingHourEnd ?? "")"
        } else if currentTimeHour >= workingHourEndTimeHour {
            return "Opens tomorrow at \(betshop.workingHourStart ?? "")"
        } else if currentTimeHour < workingHourStartTimeHour {
            return "Opens at \(betshop.workingHourStart ?? "")"
        }
        
        return "Uknown"
    }
}
