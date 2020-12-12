//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import SwiftUI
import CoreData

@main
struct NewsFeedApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let viewModelFactory = ViewModelFactory()
    @StateObject var loginController = LoginController()

    var body: some Scene {
        WindowGroup {
            FirstView {
                //SignUpView(viewModel: viewModelFactory.makeSignUpViewModel())
                SignInView(viewModel: viewModelFactory.makeSignInViewModel())
            }
            .environment(\.managedObjectContext, persistentContainer.viewContext)
            .environmentObject(loginController)
        }
        .onChange(of: scenePhase) { (phase) in
            if phase == .active {
                saveContext();
            }
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "NewsFeed")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
    func saveContext() {
      let context = persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
    
}
