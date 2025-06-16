import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseCore

// UIKit ViewController를 SwiftUI에서 감싸는 래퍼
struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // NavigationController를 불러와서 반환 (Storyboard ID: "NavigationController")
        let nav = storyboard.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        
        return nav
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class ViewController: UIViewController {
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPasswd: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var btnFindPasswd: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let joinVC = storyboard.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
        self.navigationController?.pushViewController(joinVC, animated: true)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = txtID.text, !email.isEmpty,
              let password = txtPasswd.text, !password.isEmpty else {
            showAlert(message: "이메일과 비밀번호를 입력해 주세요.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert(message: "로그인 실패: \(error.localizedDescription)")
                return
            }

            // 로그인 성공 시 탭바 컨트롤러 보여주기
            let tabBarVC = CustomTabBarController()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }


    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
