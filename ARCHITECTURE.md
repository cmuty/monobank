# Архитектура приложения Monobank Clone

## 🏗️ Общая архитектура

Приложение построено на **SwiftUI** с использованием **MVVM-подобного** подхода, где View и ViewModel объединены благодаря декларативной природе SwiftUI.

```
┌─────────────────────────────────────────┐
│           MonobankCloneApp              │
│         (Application Entry)             │
└──────────────┬──────────────────────────┘
               │
               ▼
┌─────────────────────────────────────────┐
│           ContentView                   │
│      (Main Container + TabView)         │
└──────────────┬──────────────────────────┘
               │
               ├─────────────┬──────────────┬──────────────┬──────────────┐
               ▼             ▼              ▼              ▼              ▼
         ┌─────────┐   ┌──────────┐  ┌───────────┐  ┌──────────┐  ┌──────────┐
         │MainView │   │CreditView│  │SavingsView│  │Services  │  │MarketView│
         └─────────┘   └──────────┘  └───────────┘  └──────────┘  └──────────┘
```

## 📁 Структура файлов

```
MonobankClone/
│
├── MonobankCloneApp.swift          # Entry point (@main)
│   └── Определяет WindowGroup и стартовый ContentView
│
├── ContentView.swift                # Main container
│   ├── TabView для навигации
│   ├── Управление состоянием (cards, transactions)
│   └── Фоновый градиент
│
├── Models.swift                     # Data models
│   ├── Card (struct)
│   ├── Transaction (struct)
│   ├── ExchangeRate (struct)
│   ├── ServiceItem (struct)
│   ├── TabItem (enum)
│   └── Sample data (extensions)
│
├── Extensions.swift                 # Helper extensions
│   ├── View extensions
│   ├── Date extensions
│   ├── String extensions
│   └── Double extensions
│
└── Views/                          # All view components
    ├── MainView.swift              # Home screen
    ├── CardView.swift              # 3D card component
    ├── CardDetailView.swift        # Card management
    ├── TransactionListView.swift   # Transaction history
    ├── BottomTabBar.swift          # Custom tab bar
    ├── ExchangeRatesView.swift     # Currency rates
    ├── ServicesView.swift          # Services & utilities
    ├── CreditView.swift            # Credits tab
    ├── SavingsView.swift           # Savings tab
    └── MarketView.swift            # Market tab
```

## 🔄 Поток данных

### State Management

```swift
ContentView (Source of Truth)
    │
    ├── @State cards: [Card]
    ├── @State transactions: [Transaction]
    └── @State selectedTab: TabItem
         │
         ├─> MainView (@Binding cards, @Binding transactions)
         │       │
         │       ├─> CardView (Card)
         │       ├─> TransactionRow (Transaction)
         │       └─> ActionButton
         │
         ├─> TransactionListView (@Binding transactions)
         │       └─> TransactionDetailRow (Transaction)
         │
         └─> CardDetailView (Card)
                 └─> SettingRow
```

### Data Flow Pattern

1. **Downward** - через параметры и @Binding
2. **Upward** - через callbacks и @Binding mutations
3. **Lateral** - через shared @State в родительском View

## 🎨 View Hierarchy

### MainView

```
MainView
├── ZStack
│   ├── LinearGradient (background)
│   └── ScrollView
│       └── VStack
│           ├── Top Bar (HStack)
│           │   ├── Profile Icon
│           │   ├── Messages Icon
│           │   ├── Cashback Display
│           │   ├── Cat Icon
│           │   └── Stats Icon
│           ├── Balance Display
│           ├── TabView (Cards)
│           │   └── CardView (foreach)
│           ├── "All Cards" Button
│           ├── Action Buttons (HStack)
│           │   ├── Transfer Button
│           │   ├── IBAN Payment Button
│           │   └── Other Payments Button
│           └── Transactions Section
│               ├── Header (HStack)
│               └── Transaction List
│                   └── TransactionRow (foreach)
└── Sheets
    ├── TransactionListView
    └── CardDetailView
```

### CardView (3D Component)

```
CardView
└── ZStack
    ├── RoundedRectangle (background with gradient)
    │   ├── .fill(cardGradient)
    │   ├── .shadow(...)
    │   └── .rotation3DEffect(...)
    └── VStack (content)
        ├── Top Section
        │   └── "monobank" logo
        ├── Spacer
        ├── Card Number (masked)
        └── Bottom Section
            ├── Cardholder Name
            └── VISA logo
```

## 🔧 Компоненты и их роль

### Основные компоненты

| Компонент | Тип | Роль | State |
|-----------|-----|------|-------|
| `ContentView` | Container | Главный контейнер, управление табами | @State |
| `MainView` | Screen | Главный экран с картами и транзакциями | @Binding |
| `CardView` | Component | 3D визуализация карты | Stateless |
| `TransactionRow` | Component | Строка транзакции | Stateless |
| `BottomTabBar` | Component | Кастомная навигация | @Binding |

### Вспомогательные компоненты

| Компонент | Роль |
|-----------|------|
| `ActionButton` | Кнопка быстрого действия |
| `TransactionDetailRow` | Детальная строка транзакции |
| `SettingRow` | Строка настройки |
| `DateHeader` | Заголовок даты |
| `ExchangeRateCard` | Карточка курса валюты |
| `ServiceCard` | Карточка сервиса |

## 📦 Модели данных

### Card Model

```swift
struct Card: Identifiable, Codable {
    let id: String
    var cardNumber: String
    var cardholderName: String
    var balance: Double
    var currency: String
    var cardType: CardType
    var isBlocked: Bool
    var creditLimit: Double
    
    enum CardType: String, Codable {
        case black, white, iron, platinum
    }
    
    var maskedNumber: String { /* computed */ }
}
```

**Использование:**
- Хранение информации о картах
- Отображение в CardView
- Управление в CardDetailView

### Transaction Model

```swift
struct Transaction: Identifiable, Codable {
    let id: String
    var title: String
    var amount: Double
    var currency: String
    var date: Date
    var category: TransactionCategory
    var iconName: String
    var iconColor: Color
    
    enum TransactionCategory: String, Codable {
        case transfer, payment, shopping, food, 
             transport, entertainment, utilities, other
    }
    
    var formattedAmount: String { /* computed */ }
    var formattedDate: String { /* computed */ }
}
```

**Использование:**
- История операций
- Отображение в списках
- Группировка по датам

## 🎯 Design Patterns

### 1. Composition over Inheritance

Все View - это struct, композиция через вложенность:

```swift
MainView
  └─ contains CardView
  └─ contains TransactionRow
  └─ contains ActionButton
```

### 2. Single Source of Truth

```swift
// ContentView - единственный источник истины
@State private var cards: [Card] = Card.sampleCards
@State private var transactions: [Transaction] = Transaction.sampleTransactions

// Дочерние View получают Binding
MainView(cards: $cards, transactions: $transactions)
```

### 3. Declarative UI

```swift
// Не императивный код:
// button.setTitle("Click")
// button.addTarget(...)

// А декларативный:
Button("Click") {
    action()
}
```

### 4. View as a Function of State

```swift
var body: some View {
    // UI = f(state)
    Text(currentCard.balance)
}
```

## 🔐 Принципы разработки

### SOLID Principles (адаптированные для SwiftUI)

1. **Single Responsibility**
   - Каждый View отвечает за одну часть UI
   - CardView только отображает карту
   - TransactionRow только отображает транзакцию

2. **Open/Closed**
   - Расширение через модификаторы
   - Закрыто для модификации базовых компонентов

3. **Dependency Inversion**
   - View зависят от абстракций (protocols)
   - Не зависят от конкретных реализаций

### DRY (Don't Repeat Yourself)

```swift
// Переиспользуемый градиент
extension View {
    var monobankGradient: some View {
        LinearGradient(...)
    }
}

// Переиспользуемые компоненты
ActionButton(icon: "...", title: "...")
```

### KISS (Keep It Simple, Stupid)

```swift
// Простые, понятные компоненты
struct TransactionRow: View {
    let transaction: Transaction
    var body: some View {
        HStack {
            icon
            title
            Spacer()
            amount
        }
    }
}
```

## 🚀 Performance Considerations

### 1. Lazy Loading

```swift
LazyVStack {
    ForEach(transactions) { transaction in
        TransactionDetailRow(transaction: transaction)
    }
}
```

### 2. Computed Properties

```swift
// Вычисляется только при необходимости
var maskedNumber: String {
    // ...
}
```

### 3. View Identity

```swift
ForEach(cards.indices, id: \.self) { index in
    // Stable identity для оптимизации
}
```

## 🧪 Testability

### Preview Providers

```swift
#Preview {
    MainView(
        cards: .constant(Card.sampleCards),
        transactions: .constant(Transaction.sampleTransactions)
    )
}
```

### Sample Data

```swift
extension Card {
    static let sampleCards: [Card] = [...]
}
```

## 🔄 Navigation Flow

```
App Launch
    │
    ▼
ContentView (TabView)
    │
    ├─> Tab 1: MainView
    │       ├─> Sheet: TransactionListView
    │       └─> Sheet: CardDetailView
    │
    ├─> Tab 2: CreditView
    ├─> Tab 3: SavingsView
    ├─> Tab 4: ServicesView
    └─> Tab 5: MarketView
```

## 📱 Screen States

### MainView States

1. **Loading** - (не реализовано, можно добавить)
2. **Content** - отображение карт и транзакций
3. **Empty** - нет карт (можно добавить)
4. **Error** - ошибка загрузки (можно добавить)

### Transaction List States

1. **Grouped by Date** - основное состояние
2. **Searching** - (можно добавить)
3. **Filtered** - (можно добавить)

## 🎨 Theming

### Color System

```swift
// Primary colors
Color(red: 0.25, green: 0.27, blue: 0.65) // Monobank Purple
Color.white                                // Text on dark
Color.black                                // Text on light
Color.red                                  // Accent

// Semantic colors
transaction.amount >= 0 ? .green : .black  // Positive/Negative
```

### Typography System

```swift
.font(.system(size: 48, weight: .bold))    // Balance
.font(.system(size: 28, weight: .bold))    // Headers
.font(.system(size: 16, weight: .medium))  // Body
.font(.system(size: 14))                   // Secondary
```

## 🔮 Extensibility

### Добавление нового экрана

1. Создать новый View файл
2. Добавить в TabItem enum
3. Добавить в TabView в ContentView
4. Обновить BottomTabBar

### Добавление новой модели

1. Создать struct в Models.swift
2. Реализовать Identifiable, Codable
3. Добавить sample data
4. Использовать в View

### Добавление новой фичи

1. Определить UI в новом View
2. Добавить необходимые модели
3. Подключить к существующему flow
4. Добавить Preview

---

**Архитектура спроектирована для:**
- ✅ Простоты понимания
- ✅ Легкости расширения
- ✅ Переиспользования компонентов
- ✅ Тестируемости
- ✅ Производительности
