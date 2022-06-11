import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// Class containing the theme data for the app.
class MyThemes {
  /// Theme for light mode.
  static final lightTheme = FlexThemeData.light(
    scheme: FlexScheme.green,
    surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
    usedColors: 1,
    blendLevel: 8, // Higher -> Darker Scaffold background
    lightIsWhite: true,
    appBarStyle: FlexAppBarStyle.material,
    appBarOpacity: 0.95,
    appBarElevation: 1.5,
    tooltipsMatchBackground: true,
    subThemesData: const FlexSubThemesData(
      cardElevation: 1,
      blendOnLevel: 22,
      blendOnColors: false,
      defaultRadius: 5.0,
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

  /// Theme for dark mode.
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
      cardElevation: 1,
      blendOnLevel: 28,
      defaultRadius: 5.0,
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

  /// Custom border for cards.
  static ShapeBorder myCardBorder(BuildContext context) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(
        color: Theme.of(context).shadowColor.withOpacity(0.1),
        width: 1,
      ),
    );
  }
}
