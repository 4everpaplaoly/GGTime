import UIKit

// delegate 전달을 위한 프로토콜 정의
protocol CourseControllerDelegate: AnyObject {
    func didAddCourse(_ course: Lecture)
}

class CourseController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var classLocation: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var dayButton: UIButton!

    // MARK: - Delegate
    weak var delegate: CourseControllerDelegate?

    // 요일 배열
    let weekdays = ["월", "화", "수", "목", "금"]

    // 선택된 요일 저장용
    var selectedDayIndex: Int?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDayButtonMenu()
    }

    // MARK: - Setup Pull Down Menu
    func setupDayButtonMenu() {
        let actions = weekdays.enumerated().map { (index, day) in
            UIAction(title: day, handler: { [weak self] _ in
                self?.dayButton.setTitle(day, for: .normal)
                self?.selectedDayIndex = index
            })
        }
        dayButton.menu = UIMenu(title: "요일 선택", children: actions)
        dayButton.showsMenuAsPrimaryAction = true
        dayButton.setTitle("요일 선택", for: .normal)
    }

    // MARK: - Actions
    @IBAction func pressBtn(_ sender: UIButton) {
        guard let name = className.text, !name.isEmpty,
              let location = classLocation.text, !location.isEmpty,
              let startStr = startTime.text, let start = Int(startStr),
              let endStr = endTime.text, let end = Int(endStr),
              end > start,
              let dayIndex = selectedDayIndex else {
            showAlert(title: "입력 오류", message: "모든 값을 정확히 입력해주세요.")
            return
        }

        let newLecture = Lecture(day: dayIndex, startHour: start, durationHours: end - start, title: name, location: location)

        delegate?.didAddCourse(newLecture)

        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Helper
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}
