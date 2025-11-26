# Aurora Loader

Мінімалістичний утиліта з сучасним неоновим лоадером. У застосунку є вітрина з кількома пресетами та підказками щодо інтеграції, а головний елемент `AuroraLoader` можна забрати у власний проєкт.

## Основні можливості

- **Готовий до використання віджет** із параметрами `size`, `colors`, `duration`, `showGlow`, `label`.
- **Футуристичний UI** з орбітами, градієнтами та пульсом, який легко вписати в сплеші або скелетон-екрани.
- **Демо-вітрина** з кількома прикладами, щоб швидко показати потенційним клієнтам різні настроювання.
- **Документація та скрипт упаковки** для CodeCanyon/GitHub релізів.

## Структура проекту

```
modern_loader/
├── lib/
│   ├── aurora_loader.dart
│   ├── modern_loader.dart
│   └── main.dart
├── documentation/index.md
├── tool/package_release.sh
├── README.md
├── CHANGELOG.md
├── LICENSE.txt
└── test/widget_test.dart
```

## Запуск

```bash
cd modern_loader
flutter run
```

## Використання віджета

```dart
import 'package:modern_loader/modern_loader.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuroraLoader(
      size: 150,
      label: 'Preparing data…',
      colors: [
        Color(0xFF12C2E9),
        Color(0xFFC471ED),
        Color(0xFFF64F59),
      ],
    );
  }
}
```

### Налаштування

- `size` — загальний діаметр картки (за замовчуванням 170).
- `colors` — перелік кольорів для градієнтів та крапок.
- `duration` — швидкість анімації.
- `showGlow` — вмикає або вимикає світіння.
- `label` та `labelStyle` — текст під лоадером та його стиль.
- `backgroundColor` / `gradientRotation` — контроль настрою карточки.

Вбудована вітрина (`LoaderShowcasePage`) демонструє кілька варіантів використання: можна вирізати потрібний приклад або впровадити `AuroraLoader` у власні екрани завантаження, сплеші чи модальні вікна.

