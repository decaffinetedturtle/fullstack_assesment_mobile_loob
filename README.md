# Tealive Careers - Job Application Mobile App

A Flutter mobile application for Tealive's job application process, built as a prototype for digitizing the frontliner hiring process.

## Features

### Core Functionality

- **Job Application Form**: Complete form for candidates to apply for positions
  - Full name, phone number, position applied, work experience
  - Optional email address (some frontliners may not have email)
  - Form validation and submission
- **Application Status Check**: Candidates can check their application progress
  - Search by phone number
  - View current status (Applied → Screening → Interview → Offer)
  - Application details and timestamps
- **Confirmation Screen**: Success confirmation after application submission
  - Application ID and details
  - Email confirmation notification (if email provided)

### Technical Features

- **Modern Flutter Architecture**: Clean architecture with feature-based organization
- **State Management**: Riverpod for reactive state management
- **Navigation**: GoRouter for declarative routing
- **Theming**: Tealive-inspired purple and yellow color scheme
- **Responsive Design**: Material Design 3 with custom theming
- **Form Validation**: Comprehensive input validation
- **Error Handling**: User-friendly error messages and loading states

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app_router.dart             # Routing configuration
│
├── features/                   # Feature-based architecture
│ └── job_application/
│     ├── data/
│     │   ├── models/           # Data models
│     │   └── repositories/     # Data access layer
│     ├── providers/            # Riverpod state management
│     └── presentation/
│         ├── pages/            # Screen widgets
│         └── widgets/          # Feature-specific widgets
│
├── core/                       # Shared core functionality
│   ├── api/                    # HTTP client
│   ├── models/                 # Global models
│   ├── providers/              # Global providers
│   └── utils/                  # Utilities and validators
│
├── shared_widgets/             # Reusable UI components
│   ├── custom_button.dart      # Styled button component
│   ├── loading_spinner.dart    # Loading indicators
│   └── status_card.dart        # Application status display
│
└── config/                     # App configuration
    ├── app_config.dart         # App settings and constants
    └── theme.dart              # Tealive brand theming
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the App

1. Ensure you have a device connected or emulator running
2. Run the app:
   ```bash
   flutter run
   ```

### Testing

Run the test suite:

```bash
flutter test
```

## Design Decisions

### Architecture

- **Feature-based Structure**: Organized code by business features rather than technical layers
- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **Riverpod State Management**: Chosen for its simplicity and excellent Flutter integration

### UI/UX Design

- **Tealive Branding**: Purple (#6B46C1) and yellow (#F59E0B) color scheme
- **Material Design 3**: Modern design system with custom theming
- **Accessibility**: Proper contrast ratios and semantic labels
- **Mobile-first**: Optimized for mobile devices with touch-friendly interfaces

### API Design

- **RESTful API**: Standard HTTP methods for CRUD operations
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Loading States**: Clear loading indicators and state management

## Backend Integration

The app is designed to work with a Laravel backend with the following endpoints:

- `POST /api/applications` - Submit new application
- `GET /api/applications/{id}` - Get application by ID
- `GET /api/applications/search?phone={phone}` - Search by phone number

### Expected API Response Format

```json
{
  "data": {
    "id": "uuid",
    "full_name": "John Doe",
    "phone_number": "+60123456789",
    "email": "john@example.com",
    "position": "Barista",
    "work_experience": "2 years in F&B",
    "status": "applied",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z",
    "notes": null
  }
}
```

## Future Extensions

If given more time, this prototype could be extended into a full ATS with:

### Job Management

- Job posting and management system
- Position descriptions and requirements
- Department and location filtering

### Recruitment Workflow

- Automated screening processes
- Interview scheduling integration
- Reference checking system
- Document collection and verification

### Analytics and Reporting

- Application metrics and trends
- Recruitment funnel analysis
- Performance dashboards for HR teams

### Advanced Features

- Push notifications for status updates
- Document upload (resumes, certificates)
- Multi-language support
- Integration with existing HR systems
- Background check integration

### Technical Enhancements

- Offline support with local storage
- Biometric authentication
- Advanced search and filtering
- Real-time updates with WebSocket
- Progressive Web App (PWA) support

## Testing

The app includes basic widget tests to ensure core functionality works correctly. The test suite covers:

- App initialization and navigation
- Home page rendering
- Form validation logic

## Dependencies

- `flutter_riverpod`: State management
- `go_router`: Declarative routing
- `http`: HTTP client for API calls
- `cupertino_icons`: iOS-style icons

## Contributing

This is a prototype application built for assessment purposes. For production use, additional considerations would include:

- Comprehensive testing coverage
- Security best practices
- Performance optimization
- Accessibility compliance
- Internationalization support
