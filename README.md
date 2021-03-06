# Einsatz Helper App
🇩🇪 *Einsatz Helper* ist eine App für Android und iOS und dient als Einsatzunterstützung für den Katastrophenschutz. Mit *Einsatz Helper* können Einsatztagebücher (ETB) geführt werden.

🇬🇧 *Einsatz Helper* is an Android and iOS app and serves as a support tool for disaster control. Activity logs (ETB) can be kept with *Einsatz Helper*.


## Getting started

1. Install Flutter by following the instruction at https://docs.flutter.dev/get-started/install
2. Verify everything is installed correctly with the command: `flutter doctor`
2. Run the code with `flutter run`


## Folder Structure
The relevant code is located in the `lib` folder.
Inside `main.dart` is the `main()` function that is called when the app starts.
The code for the project is located in the following folders:

#### `lib/module_etb/model`
This folder contains the data model classes, for ETBs, entries, attachments and templates.

#### `lib/module_etb/pages`
The pages folder contains all pages with the user interface that will be displayed on the device screen.

#### `lib/module_etb/utils`
The utils folder contains helper functions, services, constants and themes.

#### `lib/module_etb/widgets`
This folder contains custom widgets.


## Compatible Platforms
- [x] Android
- [x] iOS
- [ ] web (is working, but missing pdf export)
- [ ] windows
- [ ] linux
- [ ] macOS
