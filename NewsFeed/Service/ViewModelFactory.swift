//
//  ViewModelFactory.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 06/12/20.
//

import Foundation

//Similar to factory pattern although limited for the purposes of this project
class ViewModelFactory {
    let news: [New] = [];
    let headlines: [New] = [];
    
    func makeContentViewModel() -> ContentViewModel {
//        return ContentViewModel(news: news, headlines: headlines, viewForSelectedNew: {
//            NewDetailView(viewModel: self.makeNewDetailViewModel(for: $0))
//        })
//        return ContentViewModel(news: news, headlines: headlines, viewForSelectedNew: {
//            NewDetailView(viewModel: self.makeNewDetailViewModel(for: $0))
//        }, viewForHighlightCell: {
//            HeadlineCellView(viewModel: self.makeHeadlineCellViewModel(for: $0))
//        }, viewForNewCell: {
//            NewCellView(viewModel: self.makeNewCellViewModel(for: $0))
//        })
        return ContentViewModel(news: news, headlines: headlines) { (new) -> NewDetailView in
            NewDetailView(viewModel: self.makeNewDetailViewModel(for: new))
        } viewForHighlightCell: { (new) -> HeadlineCellView in
            HeadlineCellView(viewModel: self.makeHeadlineCellViewModel(for: new))
        } viewForNewCell: { (new) -> NewCellView in
            NewCellView(viewModel: self.makeNewCellViewModel(for: new))
        }

    }
    
    func makeNewDetailViewModel(for new: New) -> NewDetailViewModel {
        return NewDetailViewModel(new: new)
    }
    
    func makeHeadlineCellViewModel(for new: New) -> HeadlineCellViewModel {
        return HeadlineCellViewModel(new: new)
    }
    
    func makeNewCellViewModel(for new: New) -> NewCellViewModel {
        return NewCellViewModel(new: new)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(viewForSignUpSuccess: {
            ContentView(viewModel: self.makeContentViewModel())
        })
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(viewForSignInSuccess: {
            ContentView(viewModel: self.makeContentViewModel())
        })
    }
    
    func makeFirstViewModel() -> FirstViewModel {
        return FirstViewModel()
    }
}
