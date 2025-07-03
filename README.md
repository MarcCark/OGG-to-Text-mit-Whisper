# 🎧 OGG-to-Text mit Whisper.cpp (Bash-Skript)

Dieses Bash-Skript konvertiert `.ogg`-Audio-Dateien zu Text mittels [`Whisper.cpp`](https://github.com/ggerganov/whisper.cpp).  
Ideal zur schnellen Transkription von Audioaufnahmen direkt im Terminal.

---

## 🔧 Voraussetzungen

### Abhängigkeiten

- [`ffmpeg`](https://ffmpeg.org/)
- [`Whisper.cpp`](https://github.com/ggerganov/whisper.cpp) inkl. gebautem `whisper-cli`
- Modell-Datei von Whisper (z. B. `ggml-base.bin`)

### Beispiel-Aufbau

Interaktive Auswahl einer .ogg-Datei

Konvertierung zu .wav mit 16 kHz Mono

Transkription per Whisper.cpp

Optionale Umbenennung der Textdatei

Optionale Löschung der .wav- und/oder .ogg-Datei

Fehlerbehandlung mit sinnvoller Benutzerführung

⚠️ Hinweise
Skript ist derzeit interaktiv – für automatisierte Nutzung (Batch-Modus) müsste es angepasst werden.

Absolute Pfade für Whisper-CLI und Modell sind im Skript eingetragen – bitte bei Bedarf anpassen.

Whisper.cpp ist unter MIT-Lizenz – beachte dies, falls du das Skript erweiterst oder veröffentlichst.
