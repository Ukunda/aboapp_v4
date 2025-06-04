# 0. Setup
param (
    [string]$ProjectRoot = (Resolve-Path .).Path, # Assumes script is run from project root
    [string]$OutputFile = "project_summary_for_ai.txt"
)

$masterReportPath = Join-Path $ProjectRoot $OutputFile

# Define specific files and patterns to include
$filesToInclude = @(
    # Root files
    "pubspec.yaml",
    "analysis_options.yaml",
    "README.md",

    # Lib directory (all .dart files)
    "lib/**/*.dart", # This pattern will now be handled more robustly

    # Android specific
    "android/app/build.gradle.kts",
    "android/app/src/main/AndroidManifest.xml",
    "android/app/src/main/**/*.kt",
    "android/app/src/main/res/**/*.xml",
    "android/build.gradle.kts",
    "android/gradle.properties",
    "android/settings.gradle.kts",

    # iOS specific
    "ios/Runner/Info.plist",
    "ios/Runner.xcodeproj/project.pbxproj",
    "ios/Runner/AppDelegate.swift",
    "ios/Runner/Runner-Bridging-Header.h",
    "ios/Runner/Assets.xcassets/**/*.json",
    "ios/Podfile" # Include if it exists
)

# Extensions of other potentially relevant text-based files if found by patterns
$relevantTextExtensions = @(
  '.gradle', '.properties',
  '.h', '.m', '.swift',
  '.java', '.kt',
  '.xml',
  '.json',
  '.yaml', '.yml',
  '.md',
  '.txt',
  '.sh', '.ps1'
)

# 1. Collect all specified file paths
$collectedFiles = [System.Collections.Generic.List[System.IO.FileInfo]]::new()

foreach ($pattern in $filesToInclude) {
    $itemPath = Join-Path $ProjectRoot $pattern

    # --- NEUE, ROBUSTERE BEHANDLUNG FÜR lib/**/*.dart ---
    if ($pattern -eq "lib/**/*.dart") {
        $libDirectory = Join-Path $ProjectRoot "lib"
        if (Test-Path $libDirectory -PathType Container) {
            $dartFiles = Get-ChildItem -Path $libDirectory -Recurse -Filter "*.dart" -File -ErrorAction SilentlyContinue
            if ($dartFiles) {
                foreach($f in $dartFiles) {
                    if (-not ($collectedFiles.FullName -contains $f.FullName)) {
                        $collectedFiles.Add($f)
                    }
                }
            }
        } else {
            Write-Warning "Das Verzeichnis 'lib' wurde nicht gefunden unter: $libDirectory"
        }
        continue # Gehe zum nächsten Muster in $filesToInclude
    }
    # --- ENDE DER NEUEN BEHANDLUNG ---

    # Bestehende Logik für andere Muster
    $basePathForTest = $itemPath
    if ($itemPath -like "*[*?]*") { # Wenn das Muster Wildcards enthält
        $basePathForTest = Split-Path $itemPath -Parent
        # Für Muster wie "ordner/**/*.ext" muss der Basispfad "ordner" sein
        if ($itemPath -match "^([^\*\?]+)(\\|\/)\*\*(\\|\/).*$") {
            $basePathForTest = $matches[1]
        }
    }

    if (Test-Path $basePathForTest) {
        if ($pattern -notlike "*[*?]*") { # Direkter Dateipfad ohne Wildcards
            $file = Get-Item -Path $itemPath -ErrorAction SilentlyContinue
            if ($file -and ($file.PSIsContainer -eq $false)) {
                $collectedFiles.Add($file)
            } elseif (-not (Test-Path $itemPath -PathType Leaf)) {
                Write-Warning "Spezifizierte Datei nicht gefunden oder ist ein Verzeichnis: $itemPath (Muster: $pattern)"
            }
        } else { # Muster mit Wildcards (außer dem speziell behandelten lib/**/*.dart)
            $dirPathToSearch = $basePathForTest # Verwende den angepassten basePathForTest
            $filePatternName = Split-Path -Path $pattern -Leaf # Das Muster für den Dateinamen

            # Wenn das Muster einen Unterpfad-Glob enthält (z.B. res/**/*.xml)
            if ($pattern -like "*/**/*.${filePatternName}") {
                 # $dirPathToSearch sollte hier der Ordner sein, in dem die rekursive Suche beginnt
                 # z.B. für "android/app/src/main/res/**/*.xml" ist $dirPathToSearch "android/app/src/main/res"
                 # Die -Recurse Option kümmert sich um die Unterverzeichnisse.
            }


            if (Test-Path $dirPathToSearch -PathType Container) {
                $foundFiles = Get-ChildItem -Path $dirPathToSearch -Recurse -Filter $filePatternName -File -ErrorAction SilentlyContinue
                if ($foundFiles) {
                    foreach($f in $foundFiles) {
                        if (-not ($collectedFiles.FullName -contains $f.FullName)) {
                            $collectedFiles.Add($f)
                        }
                    }
                }
            } else {
                 Write-Warning "Basisverzeichnis für Muster nicht gefunden: $dirPathToSearch (Muster: $pattern)"
            }
        }
    } else {
        Write-Warning "Basispfad für Muster existiert nicht: $basePathForTest (Muster: $pattern)"
    }
}

# Entferne Duplikate, die durch verschiedene Muster hinzugefügt worden sein könnten
$uniqueFiles = $collectedFiles | Sort-Object FullName -Unique


if (-not $uniqueFiles) {
  Write-Host "Keine relevanten Dateien basierend auf den angegebenen Mustern in $ProjectRoot gefunden. Bitte stellen Sie sicher, dass sich das Skript im Projektstamm befindet und die Pfade korrekt sind."
  exit 1
}

# 2. Erstelle ein großes Array von Zeilen: ein Header + Inhalt jeder Datei
$allLines = @()
$allLines += "============================================================"
$allLines += "  PROJECT SUMMARY - Relevant files for project: $ProjectRoot"
$allLines += "  Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$allLines += "============================================================"
$allLines += ''

Write-Host "Verarbeite $($uniqueFiles.Count) Dateien..."
$fileCounter = 0
foreach ($f in $uniqueFiles) {
  $fileCounter++
  $relPath = $f.FullName.Substring($ProjectRoot.Length).TrimStart('\').Replace('\','/')
  Write-Progress -Activity "Dateien zusammenfassen" -Status "Verarbeite $relPath ($fileCounter/$($uniqueFiles.Count))" -PercentComplete (($fileCounter / $uniqueFiles.Count) * 100)
  
  $allLines += "===== FILE: $(Split-Path $relPath -Leaf) =====" # Nur Dateiname hier für bessere Lesbarkeit
  $allLines += "===== PATH: $relPath =====" # Relativer Pfad
  $allLines += ''
  
  $isTextFile = $false
  $fileExt = $f.Extension.ToLower()

  if (($relevantTextExtensions -contains $fileExt) -or 
      ($f.Name -eq 'project.pbxproj') -or 
      ($f.Name -eq 'Info.plist') -or 
      ($f.Name -eq 'Podfile') -or 
      ($fileExt -in ".gradle", ".kts", ".xml", ".yaml", ".yml", ".dart", ".md", ".txt", ".json")) {
      $isTextFile = $true
  }

  if ($isTextFile) {
    $fileContent = $null
    $exceptionEncountered = $false
    try {
        $fileContent = Get-Content $f.FullName -Encoding UTF8 -Raw -ErrorAction Stop 
    } catch {
        Write-Warning "Konnte $($f.FullName) nicht als UTF-8 lesen (-Raw): $($_.Exception.Message). Versuche Standardkodierung."
        try {
            $fileContent = Get-Content $f.FullName -Encoding Default -Raw -ErrorAction Stop 
        } catch {
            $allLines += "!!! ERROR READING FILE: $($f.FullName) - $($_.Exception.Message) !!!"
            Write-Error "Fehler beim Lesen von $($f.FullName): Inhalt übersprungen. Exception: $($_.Exception.Message)"
            $exceptionEncountered = $true
        }
    }
    
    if (-not $exceptionEncountered -and $fileContent -ne $null) {
        $allLines += $fileContent
    } elseif (-not $exceptionEncountered) {
        $allLines += "!!! ERROR READING FILE: $($f.FullName) - Inhalt war nach Leseversuch null. !!!"
        Write-Error "Fehler beim Lesen von $($f.FullName): Inhalt war null."
    }
  } else {
    $allLines += "--- Nicht-Text oder Binärdatei (Inhalt nicht eingebettet): $relPath ---"
    $allLines += "--- Erweiterung: $($f.Extension) ---"
  }
  $allLines += '' # Füge eine Leerzeile nach dem Inhalt oder Hinweis jeder Datei hinzu
}
Write-Progress -Activity "Dateien zusammenfassen" -Completed

# 3. Schreibe den Master-Bericht als UTF-8
try {
    $allLines | Out-File $masterReportPath -Encoding UTF8 -Force
    Write-Host "Projektzusammenfassung geschrieben nach $masterReportPath ($($allLines.Count) Zeilen)."
} catch {
    Write-Error "Fehler beim Schreiben der Ausgabedatei: $($_.Exception.Message)"
    exit 1
}

Write-Host "Fertig! Eine einzelne Zusammenfassungsdatei wurde generiert."