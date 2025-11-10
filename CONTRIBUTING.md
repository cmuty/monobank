# Contributing to Monobank Clone

Дякуємо за інтерес до проекту! 🎉

## 🤝 Як зробити внесок

### Reporting Bugs

Якщо ви знайшли баг:

1. Перевірте, чи немає вже такого Issue
2. Створіть новий Issue з описом:
   - Що сталося
   - Що очікувалося
   - Кроки для відтворення
   - Версія iOS та Xcode
   - Скріншоти (якщо можливо)

### Suggesting Features

Для пропозицій нових функцій:

1. Створіть Issue з тегом "enhancement"
2. Опишіть функцію детально
3. Поясніть, чому вона корисна
4. Додайте mockup або приклад (опціонально)

### Pull Requests

#### Перед створенням PR:

1. **Fork** репозиторій
2. Створіть **нову гілку**:
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. Зробіть зміни
4. **Протестуйте** на різних пристроях
5. **Commit** з описовим повідомленням:
   ```bash
   git commit -m "Add amazing feature"
   ```
6. **Push** в свій fork:
   ```bash
   git push origin feature/amazing-feature
   ```
7. Створіть **Pull Request**

#### Вимоги до PR:

- ✅ Код компілюється без помилок
- ✅ Дотримання стилю коду проекту
- ✅ Додані коментарі для складної логіки
- ✅ Оновлена документація (якщо потрібно)
- ✅ Додані Preview для нових View
- ✅ Протестовано на iOS 15+

## 📝 Code Style

### Swift Style Guide

Дотримуйтесь [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)

#### Naming

```swift
// ✅ Good
var userName: String
func calculateTotalAmount() -> Double

// ❌ Bad
var usrnm: String
func calc() -> Double
```

#### Formatting

```swift
// ✅ Good - 4 spaces indentation
struct Card {
    let id: String
    var balance: Double
}

// ❌ Bad - tabs or 2 spaces
struct Card {
  let id: String
  var balance: Double
}
```

#### SwiftUI Views

```swift
// ✅ Good - clear structure
struct MyView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Button("Click") {
                action()
            }
        }
    }
}

// ❌ Bad - unclear structure
struct MyView: View {
    var body: some View {
        VStack{Text("Hello")
        Button("Click"){action()}}
    }
}
```

### Comments

```swift
// ✅ Good - explain WHY, not WHAT
// Using 3D rotation to create depth effect
.rotation3DEffect(...)

// ❌ Bad - obvious comment
// This rotates the view
.rotation3DEffect(...)
```

### MARK Usage

```swift
// ✅ Good - organize code sections
// MARK: - Properties
@State private var cards: [Card]

// MARK: - Body
var body: some View {
    // ...
}

// MARK: - Helper Methods
private func formatAmount() -> String {
    // ...
}
```

## 🎨 Design Guidelines

### Colors

Використовуйте існуючу колірну схему:

```swift
// Primary gradient
LinearGradient(
    gradient: Gradient(colors: [
        Color(red: 0.25, green: 0.27, blue: 0.65),
        Color(red: 0.35, green: 0.25, blue: 0.65)
    ]),
    startPoint: .top,
    endPoint: .bottom
)

// Accent color
Color.red // For active states
```

### Typography

```swift
// Headers
.font(.system(size: 28, weight: .bold))

// Body
.font(.system(size: 16, weight: .medium))

// Secondary
.font(.system(size: 14))
```

### Spacing

```swift
// Consistent spacing
.padding(20)        // Screen edges
.padding(.vertical, 12)  // List items
.padding(.horizontal, 16) // Card content
```

## 🧪 Testing

### Preview Providers

Додавайте Preview для кожного нового View:

```swift
#Preview {
    MyNewView()
}

// With sample data
#Preview {
    MyNewView(data: .sampleData)
}

// Different states
#Preview("Empty State") {
    MyNewView(items: [])
}

#Preview("With Data") {
    MyNewView(items: .sampleItems)
}
```

### Manual Testing

Тестуйте на:
- ✅ iPhone SE (маленький екран)
- ✅ iPhone 15 Pro (стандартний)
- ✅ iPhone 15 Pro Max (великий)
- ✅ iPad (якщо підтримується)

Перевіряйте:
- ✅ Світла/темна тема
- ✅ Різні орієнтації
- ✅ Різні розміри шрифтів (Accessibility)

## 📚 Documentation

### Code Documentation

```swift
/// Displays a 3D card with gradient background
/// - Parameter card: The card to display
/// - Returns: A view representing the card
struct CardView: View {
    let card: Card
    // ...
}
```

### README Updates

Якщо додаєте нову функцію:
1. Оновіть README.md
2. Додайте в FEATURES.md
3. Оновіть ARCHITECTURE.md (якщо потрібно)

## 🔄 Git Workflow

### Branch Naming

```
feature/card-animations
bugfix/transaction-list-crash
hotfix/critical-security-issue
docs/update-readme
refactor/extract-components
```

### Commit Messages

Використовуйте [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add card flip animation
fix: resolve transaction list crash on iOS 15
docs: update setup instructions
refactor: extract reusable components
style: format code according to style guide
test: add preview for CardDetailView
```

### Commit Message Format

```
<type>: <subject>

<body>

<footer>
```

Приклад:

```
feat: add biometric authentication

- Implement Face ID/Touch ID support
- Add fallback to passcode
- Update security settings screen

Closes #123
```

## 🚀 Release Process

1. Оновіть версію в `project.pbxproj`
2. Оновіть CHANGELOG.md
3. Створіть tag:
   ```bash
   git tag -a v1.0.0 -m "Release version 1.0.0"
   git push origin v1.0.0
   ```
4. Створіть Release на GitHub

## 🎯 Priority Areas

Найбільш потрібні внески:

1. **Анімації** - плавні переходи між екранами
2. **Тести** - unit та UI тести
3. **Accessibility** - покращення доступності
4. **Performance** - оптимізація продуктивності
5. **Документація** - більше прикладів та туторіалів

## ❓ Questions?

- Створіть Issue з тегом "question"
- Опишіть свою проблему детально
- Ми відповімо якнайшвидше

## 📜 Code of Conduct

### Наші стандарти

- ✅ Будьте ввічливими та професійними
- ✅ Поважайте різні точки зору
- ✅ Приймайте конструктивну критику
- ✅ Фокусуйтесь на тому, що краще для проекту

### Неприйнятна поведінка

- ❌ Образи та особисті атаки
- ❌ Тролінг та провокації
- ❌ Публікація приватної інформації
- ❌ Будь-яка форма домагань

## 🙏 Thank You!

Дякуємо за ваш внесок у проект! Кожен PR, Issue та коментар роблять проект кращим.

---

**Happy Coding! 🚀**
