# Changelog

## Unpublished

### 🛠 Breaking changes

### 🎉 New features

### 🐛 Bug fixes

### 💡 Others

## 46.0.0-beta.1 — 2022-07-16

_This version does not introduce any user-facing changes._

## 46.0.0-alpha.3 — 2022-07-11

_This version does not introduce any user-facing changes._

## 46.0.0-alpha.2 — 2022-07-08

_This version does not introduce any user-facing changes._

## 46.0.0-alpha.1 — 2022-07-08

_This version does not introduce any user-facing changes._

## 46.0.0-alpha.0 — 2022-07-07

### 🎉 New features

- Added web support and bundle splitting support to `DevLoadingView`. ([#17714](https://github.com/expo/expo/pull/17714) by [@EvanBacon](https://github.com/EvanBacon))
- Add `ExpoErrorManager` to improve some commonly logged error messages. ([#18064](https://github.com/expo/expo/pull/18064) by [@esamelson](https://github.com/esamelson))

### 🐛 Bug fixes

- On Android fixed `onActivityResult` not being propagated by `ReactDelegate` when Android decides to kill and then recreate application `Activity` when low on resources. ([#17572](https://github.com/expo/expo/pull/17572)) by [@bbarthec](https://github.com/bbarthec))
- Fixed `Unable to deactivate keep awake. However, it probably is deactivated already` unhandled promise rejection warning when resuming apps on Android. ([#17319](https://github.com/expo/expo/pull/17319) by [@kudo](https://github.com/kudo))
- Added support for React Native 0.69.x ([#17629](https://github.com/expo/expo/pull/17629) and [#18006](https://github.com/expo/expo/pull/18006) by [@kudo](https://github.com/kudo))

### 📚 3rd party library updates

- Update react-native dependency to 0.68.2. ([#17438](https://github.com/expo/expo/pull/17438) by [@kudo](https://github.com/kudo))

## 45.0.0-beta.9 — 2022-04-28

_This version does not introduce any user-facing changes._

## 45.0.0-beta.8 — 2022-04-27

_This version does not introduce any user-facing changes._

## 45.0.0-beta.7 — 2022-04-27

### 🐛 Bug fixes

- Forward CLI exit code to process. ([#17189](https://github.com/expo/expo/pull/17189) by [@EvanBacon](https://github.com/EvanBacon))

## 45.0.0-beta.6 — 2022-04-27

_This version does not introduce any user-facing changes._

## 45.0.0-beta.5 — 2022-04-25

### 🐛 Bug fixes

- Fix `Overwriting fontFamily style attribute preprocessor` warning when startup. ([#17138](https://github.com/expo/expo/pull/17138) by [@Kudo](https://github.com/Kudo))

## 45.0.0-beta.4 — 2022-04-21

_This version does not introduce any user-facing changes._

## 45.0.0-beta.3 — 2022-04-21

_This version does not introduce any user-facing changes._

## 45.0.0-beta.2 — 2022-04-20

### 🎉 New features

- Add `ReactNativeHostHandler.getUseDeveloperSupport()` to allow `expo-dev-launcher` to override this value at runtime. ([#17069](https://github.com/expo/expo/pull/17069) by [@esamelson](https://github.com/esamelson))

## 45.0.0-beta.1 — 2022-04-18

### 🎉 New features

- Add `EXPO_USE_BETA_CLI` to utilize the new `@expo/cli` versioned package. ([#17007](https://github.com/expo/expo/pull/17007) by [@EvanBacon](https://github.com/EvanBacon))
- Added Android `ReactNativeHostHandler.getJavaScriptExecutorFactory()` for a module to override the `JavaScriptExecutorFactory`. ([#17005](https://github.com/expo/expo/pull/17005) by [@kudo](https://github.com/kudo))
- Add `react`, `react-native`, `react-dom`, and `react-native-web` to `bundledNativeModules.json`. ([#17048](https://github.com/expo/expo/pull/17048) by [@EvanBacon](https://github.com/EvanBacon))
