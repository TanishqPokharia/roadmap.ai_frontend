# RoadmapAI Project Guidelines

## Architecture Overview

RoadmapAI is a Flutter application for generating and visualizing AI-powered learning roadmaps. The app follows a clean architecture approach with feature-based organization:

```
lib/
├── core/          # Core utilities and extensions
├── features/      # Feature modules (auth, community, roadmap)
│   ├── {feature}/ # Each feature follows a consistent structure
│   │   ├── data/        # Data layer (models, repositories, data sources)
│   │   ├── domain/      # Domain layer (entities, repositories interfaces, use cases)
│   │   └── presentation/ # UI layer (screens, widgets, state management)
├── router/        # App routing with GoRouter
├── themes/        # App theming and styling
└── utils/         # Utility functions
```

## Key Entities and Relationships

- **Roadmap**: Main data structure containing ordered Goals
- **Goal**: A major milestone within a Roadmap containing Subgoals
- **Subgoal**: A specific learning task with description, resources, duration, and status

Example from `roadmap.dart`, `goal.dart`, and `subgoal.dart` in `features/community/domain/entities/`.

## State Management

- **Riverpod**: Primary state management solution
  - Use AsyncValue patterns for handling loading/error states
  - Example: `roadmap_notifier.dart` for roadmap generation state

## UI Patterns

1. **Roadmap Visualization**:
   - `RoadmapTree` widget displays hierarchical goals and subgoals
   - Uses expandable nodes and connecting dividers
   - Implements custom height calculations for proper divider alignment

2. **Theme Extensions**:
   - Use `context.textTheme`, `context.colorScheme`, etc. from `theme_extensions.dart`
   - Use `context.screenWidth/Height` from `responsive_extensions.dart`

3. **Opacity Handling**:
   - Use `withAlpha(value)` instead of `withOpacity()` for color transparency
   - Example: `colorScheme.primary.withAlpha(38)` for 15% opacity (38/255)

## Navigation

- **GoRouter**: Handles app navigation
  - Routes defined in `router/router_config.dart`
  - Route names defined in `router/routes.dart`

## Form Handling

- Use `TextField` with controllers for form inputs
- Wrap with `GestureDetector` for dismissing keyboard when tapping outside

## Development Workflow

1. **Running the app**:
   ```bash
   flutter run
   ```

2. **Code generation** (for Riverpod):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

## Common Issues & Solutions

- **Column Spacing**: Some Column widgets use custom `spacing` property from a package extension
- **TextField Focus**: If text fields aren't accepting input, check if they're properly wrapped in a parent widget with correct input handling

## AI Generation

- Roadmap generation is handled by the RoadmapNotifier
- See `features/roadmap/presentation/providers/roadmap/roadmap_notifier.dart` for the implementation

## Feature Structure Example

When adding a new feature:
1. Create entity classes in domain/entities
2. Implement repository interfaces in domain/repository
3. Create data models in data/models
4. Implement concrete repositories in data/repository
5. Build UI components in presentation/
6. Add navigation in router/router_config.dart

## Styling Conventions

- Use `SizedBox` for spacing between widgets
- Use `EdgeInsets` for padding inside containers
- Use `TextTheme` from context for consistent text styling
- Use provided color scheme with withAlpha() for transparency