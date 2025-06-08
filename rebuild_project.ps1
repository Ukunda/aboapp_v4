# rebuild_project.ps1
# A script to perform a full clean and rebuild of a Flutter project with code generation.
# Run this from the root of your Flutter project.

# --- CONFIGURATION ---
$ErrorActionPreference = "Stop" # Exit script on any error

# --- FUNCTIONS ---
function Write-Header($message) {
    Write-Host ""
    Write-Host "=================================================================" -ForegroundColor Cyan
    Write-Host "  $message" -ForegroundColor Cyan
    Write-Host "=================================================================" -ForegroundColor Cyan
}

# --- SCRIPT START ---
$ProjectRoot = (Get-Location).Path
Write-Host "Project root identified as: $ProjectRoot"

# 1. Manually Delete All Generated Files
Write-Header "STEP 1: DELETING ALL GENERATED FILES (*.freezed.dart, *.g.dart, *.config.dart)"

$generatedFiles = Get-ChildItem -Path (Join-Path $ProjectRoot "lib") -Recurse -Include "*.freezed.dart", "*.g.dart", "*.config.dart" -File

if ($generatedFiles) {
    foreach ($file in $generatedFiles) {
        Write-Host "Deleting: $($file.FullName.Substring($ProjectRoot.Length))"
        Remove-Item $file.FullName -Force
    }
    Write-Host "Successfully deleted $($generatedFiles.Count) generated files." -ForegroundColor Green
} else {
    Write-Host "No generated files found to delete." -ForegroundColor Yellow
}


# 2. Clean the Flutter Project
Write-Header "STEP 2: RUNNING 'flutter clean'"
try {
    flutter clean
    Write-Host "'flutter clean' completed successfully." -ForegroundColor Green
} catch {
    Write-Error "An error occurred during 'flutter clean': $_"
    exit 1
}


# 3. Get Dependencies Again
Write-Header "STEP 3: RUNNING 'flutter pub get'"
try {
    flutter pub get
    Write-Host "'flutter pub get' completed successfully." -ForegroundColor Green
} catch {
    Write-Error "An error occurred during 'flutter pub get': $_"
    exit 1
}


# 4. Run the Build Runner
Write-Header "STEP 4: RUNNING BUILD RUNNER (This may take a moment...)"
try {
    flutter pub run build_runner build --delete-conflicting-outputs
    Write-Host "Build Runner completed successfully." -ForegroundColor Green
} catch {
    Write-Error "An error occurred during the build_runner process: $_"
    Write-Error "Please review the build_runner output above for specific errors."
    exit 1
}

Write-Header "ALL DONE! Project has been cleaned and rebuilt."
Write-Host "You can now try running your app with 'flutter run'." -ForegroundColor White