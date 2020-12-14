//
//  NewsFeedApp.swift
//  NewsFeed
//
//  Created by Sávio Berdine on 02/12/20.
//

import SwiftUI
import CoreData
import Firebase
import FBSDKCoreKit

@main
struct NewsFeedApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @Environment(\.scenePhase) private var scenePhase
    let viewModelFactory = ViewModelFactory()
    @StateObject var loginController = LoginController()
    @State var isSignUp: Bool = false

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            FirstView(viewModelFactory: self.viewModelFactory)
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

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool { ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] ) }
    
}
