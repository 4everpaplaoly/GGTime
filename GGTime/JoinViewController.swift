import UIKit
import FirebaseAuth
import FirebaseFirestore

class JoinViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!

    @IBOutlet weak var schoolButton: UIButton!
    @IBOutlet weak var majorButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!

    let schools = ["평택대학교", "한경국립대학교", "오산대학교", "호서대학교"]
    let majors = ["융합소프트웨어학과", "스마트콘텐츠학과", "스마트모빌리티학과", "데이터정보학과"]
    let statuses = ["재학생", "복학생", "휴학생"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtnTapped))

        self.navigationItem.leftBarButtonItem = backBtn

        // 초기 타이틀 설정
        schoolButton.setTitle(schools.first, for: .normal)
        majorButton.setTitle(majors.first, for: .normal)
        statusButton.setTitle(statuses.first, for: .normal)

        setupMenus()
    }

    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    func setupMenus() {
        schoolButton.menu = UIMenu(title: "", children: schools.map { title in
            UIAction(title: title) { [weak self] _ in
                self?.schoolButton.setTitle(title, for: .normal)
            }
        })
        schoolButton.showsMenuAsPrimaryAction = true

        majorButton.menu = UIMenu(title: "", children: majors.map { title in
            UIAction(title: title) { [weak self] _ in
                self?.majorButton.setTitle(title, for: .normal)
            }
        })
        majorButton.showsMenuAsPrimaryAction = true

        statusButton.menu = UIMenu(title: "", children: statuses.map { title in
            UIAction(title: title) { [weak self] _ in
                self?.statusButton.setTitle(title, for: .normal)
            }
        })
        statusButton.showsMenuAsPrimaryAction = true
    }

    @IBAction func joinButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty,
              let grade = gradeTextField.text, !grade.isEmpty,
              let school = schoolButton.title(for: .normal), schools.contains(school),
              let major = majorButton.title(for: .normal), majors.contains(major),
              let status = statusButton.title(for: .normal), statuses.contains(status) else {
            showAlert(message: "모든 필드를 정확히 입력해 주세요.")
            return
        }

        guard password == confirmPassword else {
            showAlert(message: "비밀번호와 비밀번호 확인이 일치하지 않습니다.")
            return
        }

        join(email: email, password: password, school: school, major: major, grade: grade, studentStatus: status) { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showAlert(message: "회원가입 실패: \(error.localizedDescription)")
                } else {
                    self?.showAlert(message: "회원가입 성공!") {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }

    func join(email: String, password: String, school: String, major: String, grade: String, studentStatus: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }

            guard let uid = authResult?.user.uid else {
                completion(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "UID를 가져올 수 없습니다."]))
                return
            }

            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "email": email,
                "school": school,
                "major": major,
                "grade": grade,
                "studentStatus": studentStatus
            ]

            db.collection("users").document(uid).setData(userData) { error in
                completion(error)
            }
        }
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true, completion: nil)
    }
}

