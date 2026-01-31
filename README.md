# HappyCo - Flutter E-commerce Application

Một dự án e-commerce hiện đại được xây dựng với Flutter, áp dụng Clean Architecture và các best practices 2025.

## 📋 Mục lục

- [Tổng quan](#tổng-quan)
- [Kiến trúc](#kiến-trúc)
- [Tính năng](#tính-năng)
- [Công nghệ](#công-nghệ)
- [Bắt đầu](#bắt-đầu)
- [Cấu trúc dự án](#cấu-trúc-dự-án)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)

## 🎯 Tổng quan

HappyCo là một ứng dụng e-commerce đầy đủ tính năng, được thiết kế với focus vào:
- **Performance**: Tối ưu cho tốc độ và memory usage
- **Scalability**: Dễ dàng mở rộng khi phát triển
- **Maintainability**: Code sạch, dễ bảo trì
- **User Experience**: UI/UX hiện đại, mượt mà

### Đặc điểm nổi bật
- ✅ Clean Architecture với Feature-first approach
- ✅ State management với BLoC pattern
- ✅ Type-safe navigation với Auto Route
- ✅ Dependency Injection với GetIt + Injectable
- ✅ Comprehensive testing strategy
- ✅ Performance monitoring và error tracking

## 🏗️ Kiến trúc

```
┌─────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                     │
│              (UI, BLoC, Navigation)                      │
└─────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                         │
│           (Business Logic, Use Cases, Entities)          │
└─────────────────────────────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────┐
│                      DATA LAYER                          │
│            (Repositories, Data Sources, Models)          │
└─────────────────────────────────────────────────────────┘
```

### Architecture Principles
1. **Single Responsibility**: Mỗi class có một trách nhiệm duy nhất
2. **Dependency Inversion**: Phụ thuộc vào abstraction, không phải implementation
3. **Separation of Concerns**: Tách biệt UI, business logic, và data
4. **Testability**: Mọi component đều có thể test độc lập

## 🚀 Tính năng

### Core Features
- 🔐 **Authentication**: Login, register, social login (Google, Apple)
- 📱 **Product Catalog**: Browse, search, filter products
- 🛒 **Shopping Cart**: Add, update, remove items
- 💳 **Payment**: Multiple payment methods (Stripe, VNPay)
- 📦 **Order Management**: Order history, tracking
- 👤 **User Profile**: Profile management, settings

### Advanced Features
- 🔔 **Push Notifications**: Order updates, promotions
- 🌐 **Offline Support**: Browse products offline
- 🎯 **Smart Search**: Search suggestions, history
- 📊 **Analytics**: User behavior tracking
- 🔄 **Real-time Updates**: Live order status

## 🛠️ Công nghệ

### Core Technologies
- **Flutter 3.22+**: Cross-platform framework
- **Dart 3.4+**: Programming language

### State Management
- **BLoC 8.1.6**: State management pattern
- **Freezed**: Immutable data classes
- **Equatable**: Value equality

### Architecture & DI
- **Clean Architecture**: Software architecture pattern
- **GetIt + Injectable**: Dependency injection
- **Auto Route**: Type-safe navigation

### Data & Storage
- **Dio**: HTTP client
- **Drift**: Reactive database (SQLite)
- **SharedPreferences**: Simple key-value storage
- **Cached Network Image**: Image caching

### UI & UX
- **Flutter ScreenUtil**: Responsive design
- **Flutter SVG**: SVG support
- **Lottie**: Animations

### Firebase
- **Firebase Core**: App initialization
- **Firebase Auth**: Authentication
- **Firebase Messaging**: Push notifications
- **Firebase Performance**: Performance monitoring

### Development Tools
- **Code Generation**: build_runner, freezed, json_serializable
- **Testing**: flutter_test, mockito, bloc_test
- **Linting**: flutter_lints, custom_lint, dart_code_metrics

## 🏁 Bắt đầu

### Prerequisites
- Flutter SDK >=3.22.0
- Dart SDK >=3.4.0
- Android Studio / VS Code
- Git

### Installation

1. **Clone repository**
```bash
git clone https://github.com/your-org/happyco.git
cd happyco
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code**
```bash
flutter packages pub run build_runner build
```

4. **Run app**
```bash
flutter run
```

### Environment Setup

Happyco supports 2 environments: **development** and **production**.

#### Running with Specific Environment

**Development**:
```bash
flutter run --dart-define=FLUTTER_ENV=development
```

**Production**:
```bash
flutter run --dart-define=FLUTTER_ENV=production
```

**VS Code**: Use Run & Debug panel → Select "Happyco (Development)" or "Happyco (Production)"

#### Building for Release

**Development APK**:
```bash
flutter build apk --dart-define=FLUTTER_ENV=development --debug
```

**Production APK**:
```bash
flutter build apk --release --dart-define=FLUTTER_ENV=production
```

**Production iOS**:
```bash
flutter build ios --release --dart-define=FLUTTER_ENV=production
```

#### Environment Files

- `.env.development` - Development configuration (debug logging enabled)
- `.env.production` - Production configuration (debug logging disabled)
- `.env.example` - Template with all available variables

#### Changing API URL

Edit `.env.development` or `.env.production`:

```env
API_BASE_URL=http://103.9.211.145:3014
```

**Important**: Changing environment requires **full restart** (not hot reload).

## 📁 Cấu trúc dự án

```
happyco/
├── lib/
│   ├── app/                     # App-level configuration
│   │   ├── config/             # Environment & app config
│   │   ├── constants/          # App constants
│   │   ├── errors/             # Global error handlers
│   │   ├── routes/             # Router configuration
│   │   ├── themes/             # App themes & styles
│   │   ├── main.dart          # Entry point
│   │   └── app.dart           # Root widget
│   │
│   ├── src/                    # Feature modules
│   │   ├── authentication/     # Authentication feature
│   │   ├── products/          # Products management
│   │   ├── cart/              # Shopping cart
│   │   ├── orders/            # Order management
│   │   ├── payments/          # Payment processing
│   │   ├── profile/           # User profile
│   │   └── notifications/     # Push notifications
│   │
│   └── shared/                 # Shared utilities & resources
│       ├── core/               # Core utilities
│       ├── data/               # Shared data sources
│       ├── domain/             # Shared domain logic
│       ├── presentation/       # Shared UI components
│       ├── extensions/         # Dart extensions
│       └── utils/              # Utility functions
│
├── test/                       # Test files
│   ├── unit/                   # Unit tests
│   ├── widget/                 # Widget tests
│   ├── integration/            # Integration tests
│   └── helpers/                # Test utilities
│
├── docs/                       # Documentation
│   ├── architecture.md         # Architecture documentation
│   ├── folder-structure.md     # Project structure guide
│   ├── upgrade-plan.md         # Upgrade/migration plan
│   └── research-summary.md     # Research findings
│
├── tool/                       # Development tools
├── assets/                     # Static assets
├── analysis_options.yaml       # Linting rules
├── pubspec.yaml                # Dependencies
└── README.md                   # This file
```

### Feature Structure

Each feature follows this structure:
```
feature/
├── data/                       # Data layer
│   ├── datasources/           # Remote/local data sources
│   ├── models/                # Data transfer objects
│   └── repositories/          # Repository implementations
├── domain/                     # Business logic
│   ├── entities/              # Business objects
│   ├── repositories/          # Repository interfaces
│   └── usecases/              # Use cases
├── presentation/              # UI layer
│   ├── pages/                 # Full-screen widgets
│   ├── widgets/               # Reusable UI components
│   └── bloc/                  # State management
└── di/                        # Dependency injection
```

## 🧪 Testing

### Run Tests

```bash
# Run all tests
flutter test

# Run unit tests only
flutter test test/unit/

# Run widget tests only
flutter test test/widget/

# Run integration tests
flutter test integration_test/

# Generate coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Testing Strategy

1. **Unit Tests (70%)**
   - Use cases
   - Repository implementations
   - BLoCs
   - Utilities

2. **Widget Tests (20%)**
   - Custom widgets
   - Pages
   - User interactions

3. **Integration Tests (10%)**
   - Complete user flows
   - API integration
   - Database operations

### Test Coverage Goals
- Overall: >80%
- Domain layer: 100%
- Data layer: 90%
- Presentation layer: 75%

## 🚀 Deployment

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle (recommended)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### Environment Configuration

Development:
```bash
flutter run --dart-define=ENV=dev
```

Production:
```bash
flutter build apk --release --dart-define=ENV=prod --obfuscate --split-debug-info=build/debug-info/
```

### CI/CD Pipeline

Project uses GitHub Actions for CI/CD:
- Automated testing on pull requests
- Build and deployment on merge to main
- Code quality checks
- Security scanning

## 📝 Code Style

### Linting Rules

Project uses:
- `flutter_lints`: Official Flutter linting rules
- `custom_lint`: Additional custom rules
- `dart_code_metrics`: Code quality metrics

### Naming Conventions

- **Files**: `lowercase_with_underscores.dart`
- **Classes**: `PascalCase`
- **Variables/Methods**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Private members**: Prefix with `_`

### Best Practices

1. Use `const` constructors where possible
2. Prefer `StatelessWidget` over `StatefulWidget`
3. Keep widgets small and focused
4. Use `async/await` for asynchronous operations
5. Handle errors properly with try-catch blocks
6. Write documentation for public APIs

## 🤝 Contributing

### Development Workflow

1. Create feature branch from `develop`
```bash
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name
```

2. Make your changes and commit
```bash
git add .
git commit -m "feat: add new feature"
```

3. Run tests and linting
```bash
flutter analyze
flutter test
```

4. Push and create pull request
```bash
git push origin feature/your-feature-name
```

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

### Pull Request Process

1. Update documentation
2. Add tests for new features
3. Ensure all tests pass
4. Request code review
5. Merge after approval

## 📚 Documentation

- [Architecture Guide](docs/architecture.md)
- [Folder Structure](docs/folder-structure.md)
- [Upgrade Plan](docs/upgrade-plan.md)
- [Research Summary](docs/research-summary.md)
- [API Documentation](docs/api-documentation.md)
- [Deployment Guide](docs/deployment.md)

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-org/happyco/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/happyco/discussions)
- **Email**: support@happyco.com

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors and community members
- Open source packages used in this project

---

**Built with ❤️ using Flutter**