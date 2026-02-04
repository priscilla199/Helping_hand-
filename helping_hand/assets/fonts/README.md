# Fonts Directory

## Roboto Font Setup

To use the Roboto font in your app, you need to:

1. **Download Roboto-Regular.ttf** from Google Fonts:
   - Go to: https://fonts.google.com/specimen/Roboto
   - Click "Download family"
   - Extract the ZIP file
   - Copy `Roboto-Regular.ttf` to this directory

2. **File structure should be:**
   ```
   assets/fonts/
   └── Roboto-Regular.ttf
   ```

3. **Alternative: Use Google Fonts package**
   - Uncomment `google_fonts: ^6.1.0` in pubspec.yaml
   - Remove the fonts section from pubspec.yaml
   - Use `GoogleFonts.roboto()` in your app

## Current Status
- ❌ Roboto-Regular.ttf (missing - download from Google Fonts)
- ✅ Font configuration in pubspec.yaml
- ✅ Assets directory structure

## Quick Fix
If you want to test the app immediately without downloading fonts:
1. Comment out the fonts section in pubspec.yaml
2. The app will use system default fonts
3. Run `flutter clean && flutter pub get` 