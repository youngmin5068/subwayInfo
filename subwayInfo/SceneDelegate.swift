//
//  SceneDelegate.swift
//  subwayInfo
//
//  Created by 김영민 on 2021/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = UINavigationController(rootViewController:
                                                                StationSearchViewController()) //네비게이션 뷰에 임베디드
        window?.makeKeyAndVisible()
        
        
    }


}

