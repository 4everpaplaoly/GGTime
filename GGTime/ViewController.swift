import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseCore

// UIKit ViewController를 SwiftUI에서 감싸는 래퍼
struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class ViewController: UIViewController {
    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPasswd: UITextField!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var btnFindPasswd: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let joinVC = storyboard.instantiateViewController(withIdentifier: "JoinViewController") as? JoinViewController {
            self.present(joinVC, animated: true, completion: nil)
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = txtID.text, !email.isEmpty,
              let password = txtPasswd.text, !password.isEmpty else {
            showAlert(message: "이메일과 비밀번호를 입력해 주세요.")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showAlert(message: "로그인 실패: \(error.localizedDescription)")
                return
            }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController {
                mainVC.modalPresentationStyle = .fullScreen
                self?.present(mainVC, animated: true, completion: nil)
            }
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
