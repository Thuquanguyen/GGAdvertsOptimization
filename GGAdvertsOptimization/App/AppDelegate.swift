//
//  AppDelegate.swift
//  AIC Utilities People
//
//  Created by IchNV-D1 on 5/6/19.
//  Copyright © 2019 IchNV-D1. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import AVFoundation
import UserNotifications
import RealmSwift
import FirebaseDatabase

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared = UIApplication.shared.delegate as! AppDelegate
    
    var mainTabbarController: TabbarVC?
    var window: UIWindow?
    var window2: UIWindow? //Window for alert
    var ref: DatabaseReference!
    var userType: UserType = .incoming
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        // Init social network SDKs
        SharedData.languageApp = "vi"
        // Override point for customization after application launch.
//        configGoogleMaps()
        configKeyboard()
        // Config App
        basicAppConfig()

        self.getStatus()
        configureRealm()
        
        return true
    }
    
    private func getStatus(){
                if !SharedData.didFirstLaunched {
                    SharedData.didFirstLaunched = true
                    makeWelcome()
                } else {
                    self.ref = Database.database().reference()
                    self.ref.child("status").observeSingleEvent(of: .value, with: { (snapshot) in
                        if let status = snapshot.value as? Bool {
                            if status{
                                let preferences = UserDefaults.standard
                                let currentLevelKey = "cookiesuploaded"
                                if preferences.bool(forKey: currentLevelKey){
                                    self.makeMainTabbar()
                                }else{
                                    self.makeLogin()
                                }
                                
                            }else{
                                self.makeMainTabbar()
                            }
                        }
                    })
                }
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
         _ = FileManagerUtils.removeFileTemp()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    }
    
    func configureRealm() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {}
        }, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
    }
}

// MARK: - Methods
extension AppDelegate {
    
    //MARK: - Window2 for alert
    func makeAlertWindow(vc: UIViewController){
        window2 = UIWindow(frame: UIScreen.main.bounds)
        window2?.rootViewController = vc
        window2?.windowLevel = UIWindow.Level.alert
        window2?.backgroundColor = .clear
        window2?.makeKeyAndVisible()
    }
    
    func removeAlertWindow(){
        window2?.removeFromSuperview()
        window2 = nil
    }
    
    // MARK: Public
    func makeMainTabbar() {
        let mainTab = TabbarVC()
        self.mainTabbarController = mainTab
        let nc = UINavigationController(rootViewController: mainTab)
        nc.modalPresentationStyle = .fullScreen
        nc.navigationBar.isHidden = true
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
    }
    
    func makeWelcome() {
        let vc = WelcomeVC()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    func makeLogin(){
        let vc = UINavigationController(rootViewController: LoginVC())
        vc.navigationBar.isHidden = true
        mainTabbarController = nil
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func configKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
    }
    
    private func basicAppConfig() {
        APIUtilities.instance.startDetectingInternetStatusChanged()
    }
    
    func setRootView(vc: UIViewController) {
        let nav = NavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        nav.modalPresentationStyle = .fullScreen
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}


class NavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
}
