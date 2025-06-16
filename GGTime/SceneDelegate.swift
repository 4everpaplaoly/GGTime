import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // 여기에 탭바 컨트롤러를 생성하고 루트뷰컨트롤러로 설정
//        window?.rootViewController = MainViewController()
//        window?.makeKeyAndVisible()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.rootViewController = vc
        window?.makeKeyAndVisible()

    }


//    func scene(_ scene: UIScene,
//               willConnectTo session: UISceneSession,
//               options connectionOptions: UIScene.ConnectionOptions) {
//
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let window = UIWindow(windowScene: windowScene)
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
//            fatalError("LoginViewController를 찾을 수 없습니다.")
//        }
//
//        window.rootViewController = loginVC
//        func switchToMainTabBar() {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            guard let timetableVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController,
//                  let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController,
//                  let activityVC = storyboard.instantiateViewController(withIdentifier: "ActivityViewController") as? ActivityViewController,
//                  let myPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {
//                fatalError("뷰컨트롤러를 찾을 수 없습니다.")
//            }
//
//            timetableVC.tabBarItem = UITabBarItem(title: "시간표", image: UIImage(systemName: "calendar"), tag: 0)
//            homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 1)
//            activityVC.tabBarItem = UITabBarItem(title: "활동", image: UIImage(systemName: "bolt"), tag: 2)
//            myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle"), tag: 3)
//
//            let tabBarController = UITabBarController()
//            tabBarController.viewControllers = [timetableVC, homeVC, activityVC, myPageVC]
//
//            // SceneDelegate의 window에 탭바 컨트롤러 교체
//            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
//               let window = sceneDelegate.window {
//                window.rootViewController = tabBarController
//                UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: nil)
//            }
//        }

//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // 씬이 세션에서 해제될 때 호출됨.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 씬이 활성 상태가 되었을 때 호출됨.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // 씬이 비활성 상태가 될 때 호출됨.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 백그라운드에서 포그라운드로 전환될 때 호출됨.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // 앱이 백그라운드로 진입할 때 호출됨.
    }
}
