import UIKit

// 수업 데이터 모델
struct Lecture {
    let day: Int      // 0 = 월요일
    let startHour: Int
    let durationHours: Int
    let title: String
    let location: String
}

class MainViewController: UIViewController, CourseControllerDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var todayMissonTextField: UILabel!
    @IBOutlet weak var nextClassTextField: UILabel!
    @IBOutlet weak var regisBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weekdayStackView: UIStackView! // 상단 요일 표시용 StackView

    // 오늘의 미션
    func setupTodayMission() {
        let missions = ["캠퍼스 15분 걷기", "학교 근처에서 점심 먹기", "봉사 하나 참여하기"]
        let randomMission = missions.randomElement() ?? "오늘의 미션이 없습니다"
        todayMissonTextField.text = randomMission
    }

    // 다음 수업까지 남은 시간 계산
    func updateNextClassInfo() {
        let calendar = Calendar.current
        let now = Date()

        // 현재 요일(Int): 월요일=1, 화요일=2 ... 이므로 맞춰서 0-based로 변환
        let weekday = calendar.component(.weekday, from: now) - 2
        // 만약 일요일이면 -1이 되니, 0~4 (월~금) 범위에 맞게 예외 처리
        let currentDay = (weekday < 0) ? 0 : (weekday > 4 ? 4 : weekday)

        let currentHour = calendar.component(.hour, from: now)

        // 오늘 남은 수업들 필터링 (현재 시간 이후 수업만)
        let todayLectures = lectures.filter {
            $0.day == currentDay && $0.startHour >= currentHour
        }

        // 다음 수업 찾기 (시작 시간이 가장 가까운 수업)
        guard let nextLecture = todayLectures.min(by: { $0.startHour < $1.startHour }) else {
            nextClassTextField.text = "오늘은 더 이상 수업이 없습니다."
            return
        }

        // 남은 시간 계산 (시, 분 단위도 가능)
        let hoursLeft = nextLecture.startHour - currentHour
        nextClassTextField.text = "다음 수업까지 \(hoursLeft)시간 남음 (\(nextLecture.title))"
        LectureManager.shared.nextLecture = nextLecture
    }

    // MARK: - Properties
    var lectures: [Lecture] = []
    let weekdays = ["월", "화", "수", "목", "금"]
    
    func didAddCourse(_ course: Lecture) {
        lectures.append(course)
        collectionView.reloadData()
        updateNextClassInfo()  // 수업 추가 후 남은 시간 정보 업데이트
    }


    // MARK: - Setup
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    func setupWeekdayHeader() {
        // 요일 라벨 생성
        weekdayStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for day in weekdays {
            let label = UILabel()
            label.text = day
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.widthAnchor.constraint(equalToConstant: collectionView.frame.width / 5).isActive = true
            weekdayStackView.addArrangedSubview(label)
        }
    }

    func setupTimeLabels() {
        let startY = collectionView.frame.origin.y
        let cellHeight: CGFloat = 60.0

        for i in 0..<10 {
            let hourLabel = UILabel(frame: CGRect(x: collectionView.frame.origin.x - 40,
                                                  y: startY + CGFloat(i) * cellHeight,
                                                  width: 40,
                                                  height: cellHeight))
            hourLabel.text = "\(9 + i)시"
            hourLabel.font = UIFont.systemFont(ofSize: 12)
            hourLabel.textAlignment = .right
            view.addSubview(hourLabel)
        }
    }

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 5.0),
            heightDimension: .absolute(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            return section
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("todayMissonTextField: \(todayMissonTextField)")  // nil인지 확인
        setupCollectionView()
        setupTimeLabels()
        setupWeekdayHeader()
        setupTodayMission()
        updateNextClassInfo()
        
    }
    
    // MARK: - Navigation
    @IBAction func regisBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let courseVC = storyboard.instantiateViewController(withIdentifier: "CourseController") as? CourseController {
            courseVC.delegate = self
            courseVC.modalPresentationStyle = .fullScreen
            present(courseVC, animated: true, completion: nil)
        }
    }

}



// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10 // 9시 ~ 18시
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // 월~금
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        // 기존 라벨 제거
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }

        let day = indexPath.item
        let hour = 9 + indexPath.section

        if let lecture = lectures.first(where: {
            $0.day == day &&
            $0.startHour <= hour &&
            hour < $0.startHour + $0.durationHours
        }) {
            let label = UILabel(frame: cell.contentView.bounds)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = "\(lecture.title)\n@\(lecture.location)"
            cell.contentView.addSubview(label)
            cell.contentView.backgroundColor = UIColor.systemYellow.withAlphaComponent(0.8)
        } else {
            cell.contentView.backgroundColor = .white
        }

        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.layer.borderWidth = 0.5

        return cell
    }
}

// MARK: - UICollectionViewDelegate (선택 사항)
extension MainViewController: UICollectionViewDelegate {}
