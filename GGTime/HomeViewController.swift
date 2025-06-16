import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lefttimeText: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var classLocation: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLectureInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLectureInfo() 
    }

    func updateLectureInfo() {
        guard let nextLecture = LectureManager.shared.nextLecture else {
            lefttimeText.text = "오늘은 더 이상 수업이 없습니다"
            className.text = "-"
            classLocation.text = "-"
            return
        }

        let currentHour = Calendar.current.component(.hour, from: Date())
        let hoursLeft = nextLecture.startHour - currentHour

        // 💡 남은 시간, 수업명, 장소 표시
        lefttimeText.text = "다음 수업까지 \(hoursLeft)시간 남음"
        className.text = nextLecture.title
        classLocation.text = nextLecture.location
    }
}
