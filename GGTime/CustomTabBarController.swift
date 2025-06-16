import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메인 스토리보드 가져오기
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 각 뷰컨트롤러 스토리보드에서 인스턴스화
        guard let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController,
              let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController,
              let tappedVC = storyboard.instantiateViewController(withIdentifier: "TappedVC") as? TappedVC,
              let myPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as? MyPageViewController else {
            fatalError("뷰컨트롤러 인스턴스화 실패")
        }
        
        // 탭바 아이템 설정
        mainVC.tabBarItem = UITabBarItem(title: "시간표", image: UIImage(systemName: "calendar"), tag: 0)
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 1)
        tappedVC.tabBarItem = UITabBarItem(title: "활동", image: UIImage(systemName: "bolt"), tag: 2)
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.circle"), tag: 3)
        
        // 네비게이션 컨트롤러에 넣고 싶으면 여기서 감싸도 됨 (선택사항)
        // let mainNav = UINavigationController(rootViewController: mainVC)
        // let homeNav = UINavigationController(rootViewController: homeVC)
        // let activityNav = UINavigationController(rootViewController: activityVC)
        // let myPageNav = UINavigationController(rootViewController: myPageVC)
        //
        // self.viewControllers = [mainNav, homeNav, activityNav, myPageNav]
        
        self.viewControllers = [mainVC, homeVC, tappedVC, myPageVC]
        
        // 기본 선택 탭 (0: 첫 번째 탭)
        self.selectedIndex = 0
    }
}
