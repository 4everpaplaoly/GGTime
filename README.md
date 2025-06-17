# ⏰ 공강타임 - 대학생의 공강 시간을 똑똑하게!

**공강타임**은 대학생들이 자신의 시간표를 관리하고, 공강 시간에 맞춘 활동을 효율적으로 계획할 수 있도록 도와주는 스마트 캠퍼스 앱입니다. Firebase를 기반으로 로그인 및 회원가입 기능을 구현했으며, 시간표 시각화, 다음 수업 알림, 활동 추천, 마이페이지 등 실용적인 기능을 제공합니다.

---

## 📱 주요 기능 소개

### 🔐 로그인 화면
- Firebase Authentication을 활용해 이메일 & 비밀번호 로그인 구현
- 입력값 검증: 이메일 및 비밀번호 미입력 시 경고창 표시
- 로그인 성공 시 `CustomTabBarController`를 `.fullScreen`으로 전환
- 실패 시 에러 메시지 포함 경고창 출력

### 📝 회원가입 화면
- 이메일, 비밀번호, 학교, 학과, 학년, 재학 상태 등의 정보 입력
- 비밀번호 일치 여부 확인
- Firebase Authentication의 `createUser(withEmail:password:)` 사용
- Firestore에 사용자 정보 저장
- 드롭다운 메뉴로 학적 정보 선택 UI 제공
- 회원가입 성공 시 메시지 출력 후 이전 화면으로 이동

### 📅 시간표 화면 (MainViewController)
- 주간 시간표(월~금, 09~18시)를 컬렉션 뷰로 시각화
- `Lecture` 모델을 사용해 수업 정보 구성
- 오늘의 미션과 다음 수업 정보 제공
- 수업 추가는 `CourseController`를 통한 모달 방식

### ➕ 수업 등록 화면 (CourseController)
- 수업명, 위치, 요일, 시작/종료 시간 입력
- Pull-down 메뉴를 활용한 요일 선택
- 입력 검증 후 `Lecture` 모델로 생성하여 델리게이트로 전달
- 등록 후 메인 시간표 갱신

### 🏠 홈 화면
- 오늘 남은 다음 수업 정보를 간략하게 표시
- 수업 이름, 위치, 남은 시간 계산 표시
- 수업이 없는 경우 “오늘은 더 이상 수업이 없습니다” 메시지 출력

### 🎯 활동 화면 (TappedVC)
- 이미지 뷰 탭 시 `secondVC` 화면으로 전환
- Tap Gesture Recognizer를 통해 사용자 상호작용 구현

### 👤 마이 페이지 화면
- 사용자의 이메일, 학교, 전공, 학적 상태 표시
- Firestore에서 현재 로그인된 사용자의 UID 기반으로 정보 불러오기
- 설정 메뉴는 테이블 뷰로 구성 ("계정", "앱 설정", "개인 정보 설정")
- 각 섹션은 헤더와 함께 깔끔하게 정리

---

## 🛠️ 사용 기술 스택

| 구분         | 내용                                  |
|--------------|---------------------------------------|
| 개발 환경    | Swift, UIKit                          |
| 인증 & 데이터베이스 | Firebase Authentication, Firestore |
| UI 구성       | UICollectionView, UITableView, StackView, ModalView 등 |
| 아키텍처     | MVC 기반 뷰컨트롤러 구조              |
| 사용자 정보  | UID 기반 개인 정보 처리 및 불러오기  |

---

## 📸 스크린샷


<p>
  <img src="https://github.com/4everpaplaoly/GGTime/raw/main/images/1.png" width="100"/>
  <img src="https://github.com/4everpaplaoly/GGTime/raw/main/images/2.png" width="100"/>
  <img src="https://github.com/4everpaplaoly/GGTime/raw/main/images/3.png" width="100"/>
  <img src="https://github.com/4everpaplaoly/GGTime/raw/main/images/4.png" width="100"/>
</p>

---

## ✨ 프로젝트 기획 의도

> 대학생의 “공강 시간”은 애매하고 낭비되기 쉽지만, 잘만 활용하면 집중적인 학습·휴식·자기계발이 가능한 시간입니다.  
**공강타임**은 사용자의 시간표 기반으로 다음 수업 정보를 제공하고, 그 사이의 공백 시간에 맞춰 활동을 계획할 수 있게 도와주는 앱입니다.

---

## 📂 프로젝트 구조 요약
```
📁 GGTime
├── 📁 Controllers
│   ├── MainViewController.swift
│   ├── CourseController.swift
│   └── MyPageViewController.swift
├── 📁 Models
│   └── Lecture.swift
├── 📁 Views
│   ├── LoginView.swift
│   └── TimeTableCell.swift
├── 📁 Firebase
│   ├── AuthManager.swift
│   └── FirestoreService.swift
├── 📁 Assets
│   └── screenshots/
└── README.md
```

---

## 🙋‍♀️ 개발자
```
| 이름 | 역할 |
| 송정범 | 활동 추천 페이지 구현, 발표|
| 정혜윤 | 전반적인 앱 설계, UI 구현, Firebase 연동 |
```
---

## 📌 향후 추가 예정 기능
- 공강 시간에 맞춘 추천 활동 기능 (스터디, 카페, 도서관 위치 등)
- 교수와의 커뮤니케이션 기능 (Q&A, 공지사항)
- 다크모드 대응
- 학기별 시간표 저장 기능

---
