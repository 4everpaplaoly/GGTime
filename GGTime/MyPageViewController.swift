import UIKit
import FirebaseAuth
import FirebaseFirestore

class MyPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var schoolNMajorLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!

    // 섹션별 타이틀
    let sectionTitles = ["1. 계정", "2. 앱 설정", "3. 개인 정보 설정"]

    // 섹션별 항목들
    let sectionItems = [
        ["비밀번호 변경하기", "이메일 변경하기", "상세 정보 변경"],
        ["다크 모드", "푸시 알림 설정", "앱 버전", "화면 잠금"],
        ["로그아웃"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        fetchUserData()
    }

    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("현재 로그인된 사용자 UID가 없습니다.")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        userRef.getDocument { [weak self] document, error in
            if let error = error {
                print("사용자 데이터 가져오기 실패: \(error.localizedDescription)")
                return
            }

            guard let data = document?.data() else {
                print("사용자 데이터가 없습니다.")
                return
            }

            let email = data["email"] as? String ?? "이메일 없음"
            let school = data["school"] as? String ?? "학교 없음"
            let major = data["major"] as? String ?? "전공 없음"
            let studentStatus = data["studentStatus"] as? String ?? "상태 없음"

            DispatchQueue.main.async {
                self?.userEmailLabel.text = email
                self?.schoolNMajorLabel.text = "\(school) / \(major)"
                self?.statusLabel.text = studentStatus
            }
        }
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionItems[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()


        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sectionTitles[section]
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .label

        headerView.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -4)
        ])

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
