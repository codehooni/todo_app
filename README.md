# 📝 Todo App

카테고리 기반 할일 관리와 부드러운 애니메이션을 제공하는 Flutter Todo 애플리케이션입니다.

## 📱 스크린샷

| 🎬 데모 영상 | 🏠 Home Screen | ➕ Add Todo Screen |
|:---:|:---:|:---:|
| <div align="center"> https://github.com/user-attachments/assets/213c547a-2f76-4039-9741-381c7a404066</div> | <img width="280" alt="Home Screen" src="https://github.com/user-attachments/assets/19a1defe-caa7-4e67-a967-9391c1aa19a6" /> | <img width="280" alt="Add Todo Screen" src="https://github.com/user-attachments/assets/33453ead-c2f2-4d7c-8b22-b7224679a61b" /> |

## ✨ 주요 기능

### 🎯 핵심 기능
- ✅ **할일 관리**: 생성, 수정, 삭제 기능 제공
  - 3초 Undo 기능으로 실수로 삭제 방지
  - 왼쪽 스와이프로 삭제, 오른쪽 스와이프로 취소
- 📁 **카테고리 기반 정리**: Learning, Health, Work, Others 4가지 카테고리로 분류
- 📊 **진행도 추적**: 카테고리별 완료율을 시각적 차트로 표시
- 🔍 **필터링**: 카테고리 카드를 탭하여 특정 카테고리의 할일만 필터링

### 🎨 UI/UX 특징
- 🌙 **다크/라이트 테마**: 부드러운 전환 효과와 함께 테마 변경
- ✨ **풍부한 애니메이션**
  - FAB 클릭 시 원형 확장 애니메이션
  - Add Screen에서 위젯들이 순차적으로 fade in & slide
  - 페이지 전환 시 부드러운 트랜지션
- 👆 **터치 피드백**: 모든 인터랙션에 현대적인 터치 피드백 제공
- 🔄 **재정렬**: 롱 프레스 후 드래그로 할일 순서 변경
- 📱 **사이드 메뉴**: 통계 및 설정에 접근할 수 있는 네비게이션

### 💾 데이터 관리
- **로컬 저장소**: Hive를 사용한 빠르고 효율적인 데이터 영속성
- **자동 저장**: 모든 변경사항 즉시 저장
- **타입 안전**: Hive Generator를 사용한 타입 안전 보장

## 🛠 기술 스택

### 프레임워크 및 언어
- **Flutter** 3.9.2+
- **Dart** SDK

### 주요 패키지
| 패키지 | 버전 | 용도 |
|--------|------|------|
| flutter_riverpod | 3.0.3 | 상태 관리 |
| hive_flutter | 1.1.0 | 로컬 데이터베이스 |
| go_router | 17.0.0 | 라우팅 |
| fl_chart | 1.1.1 | 차트 시각화 |
| flutter_slidable | 4.0.3 | 스와이프 액션 |
| intl | 0.20.2 | 날짜 포맷팅 |
| uuid | 4.5.2 | 고유 ID 생성 |

## 📂 프로젝트 구조

```
lib/
├── main.dart                     # 앱 진입점
├── models/
│   ├── todo.dart                # Todo 모델 & 카테고리 enum
│   └── todo.g.dart              # Hive TypeAdapter (자동생성)
├── provider/
│   ├── todo_provider.dart       # Todo 상태 관리
│   ├── filter_provider.dart     # 필터링 로직
│   └── theme_provider.dart      # 테마 상태 관리
├── router/
│   └── go_router.dart           # 라우팅 설정
├── screens/
│   ├── home_screen.dart         # 메인 화면
│   ├── add_todo_screen.dart     # 할일 추가/수정 화면
│   └── main_screen.dart         # 사이드 메뉴를 포함한 래퍼
├── theme/
│   ├── dark_mode.dart           # 다크 테마
│   └── light_mode.dart          # 라이트 테마
├── utils/
│   └── date_utils.dart          # 날짜 유틸리티
└── widgets/
    ├── category_container.dart  # 카테고리 카드
    ├── todo_item.dart           # 할일 아이템
    └── chart_widget.dart        # 차트 위젯
```

## 🚀 시작하기

### 필수 요구사항
- Flutter SDK 3.9.2 이상
- Dart SDK
- Android Studio / VS Code (Flutter 플러그인 포함)

### 설치 및 실행

1. **레포지토리 클론**
```bash
git clone https://github.com/your-username/todo_app.git
cd todo_app
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **Hive TypeAdapter 생성**
```bash
flutter pub run build_runner build
```

4. **앱 실행**
```bash
flutter run
```

## 📖 사용 방법

### 🏠 홈 화면
- [ ] 카테고리별로 그룹화된 할일 목록 확인
- [ ] 카테고리 카드 탭하여 필터링
- [ ] 완료율을 시각적으로 확인
- [ ] FAB 버튼으로 새 할일 추가

### ➕ 할일 추가
- [ ] FAB 버튼 클릭 (원형 확장 애니메이션)
- [ ] 할일 제목, 설명 입력
- [ ] 카테고리 선택 (Learning, Health, Work, Others)
- [ ] 우선순위 설정
- [ ] 마감일 선택

### ✏️ 할일 관리
- [ ] **완료 표시**: 체크박스 탭
- [ ] **삭제**: 왼쪽 스와이프
  - 3초 내 오른쪽 스와이프 또는 Undo 버튼으로 취소 가능
- [ ] **재정렬**: 롱 프레스 후 드래그
- [ ] **수정**: 할일 아이템 탭

### 📊 통계 확인
- [ ] 사이드 메뉴 열기
- [ ] 카테고리별 완료율 차트 확인
- [ ] 전체 진행도 확인

### 🌙 테마 변경
- [ ] 설정에서 테마 토글 스위치
- [ ] 부드러운 색상 전환 효과

## 💡 구현 세부사항

### 상태 관리 (Riverpod)
```dart
// Todo 목록 관리
final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>
// 필터 상태 관리
final filterProvider = StateProvider<TodoFilter>
// 테마 상태 관리
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>
```

### 애니메이션
- **Hero Animation**: 화면 전환 시 부드러운 요소 이동
- **Circular Reveal**: FAB 클릭 시 원형 확장 효과
- **Staggered Animation**: 위젯들의 순차적 등장
- **Implicit Animation**: 테마 변경 시 자동 색상 전환

### 데이터 영속성
- **Hive**: NoSQL 로컬 데이터베이스
- **Type Adapter**: 커스텀 객체 직렬화
- **자동 저장**: CRUD 작업 시 즉시 영속화

## 🎯 카테고리

| 아이콘 | 카테고리 | 설명 |
|:---:|---------|------|
| 🎓 | Learning | 학습 관련 할일 |
| 🏋️ | Health | 건강 및 운동 |
| 💼 | Work | 업무 관련 |
| 🎯 | Others | 기타 |

## 🎨 디자인 크레딧

디자인은 Dribbble의 [Alex Arutyunov](https://dribbble.com/shots/14153121-ToDo-App-Dark-Theme)의 ToDo App Dark Theme에서 영감을 받았습니다.

## 📝 향후 개선 계획

- [ ] 반복 할일 기능 (매일, 매주 등)
- [ ] 알림 기능 (푸시 알림)
- [ ] 서브 태스크 (체크리스트)
- [ ] 태그 시스템
- [ ] 검색 기능
- [ ] 데이터 백업/복원
- [ ] 위젯 지원
- [ ] 다크/라이트 테마 외 커스텀 테마

## 📄 라이센스

이 프로젝트는 [MIT License](LICENSE) 하에 오픈소스로 제공됩니다.

---

**Made with ❤️ using Flutter**
