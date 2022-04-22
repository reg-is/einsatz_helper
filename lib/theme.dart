import 'package:flex_color_scheme/flex_color_scheme.dart';

class MyThemes {
  static final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.green,
  usedColors: 1,
  blendLevel: 5, // Higher -> Darker Scaffold background 
  appBarStyle: FlexAppBarStyle.material,
  appBarOpacity: 0.95,
  appBarElevation: 1.5,
  tooltipsMatchBackground: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 22,
    blendOnColors: false,
    defaultRadius: 10.0,
    inputDecoratorIsFilled: false,
    inputDecoratorUnfocusedBorderIsColored: false,
    fabRadius: 40.0,
    bottomNavigationBarElevation: 8.0,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);

  static final darkTheme = FlexThemeData.dark(
    colors:
        FlexColor.schemes[FlexScheme.green]!.light.defaultError.toDark(0, true),
    usedColors: 1,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 23,
    appBarStyle: FlexAppBarStyle.surface,
    appBarOpacity: 1,
    appBarElevation: 8.0,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 28,
      defaultRadius: 10.0,
      inputDecoratorIsFilled: false,
      inputDecoratorUnfocusedBorderIsColored: false,
      fabRadius: 40.0,
      bottomNavigationBarElevation: 8.0,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // To use the playground font, add GoogleFonts package and uncomment
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}
