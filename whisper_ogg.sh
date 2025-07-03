#!/bin/bash

cd "$(dirname "$0")"

set -e
trap 'echo "⛔ Ein Fehler ist aufgetreten. Terminal bleibt offen."; read -n 1 -s -r -p "Drücke eine Taste zum Schließen..."; exit 1' ERR


echo "🎧 Welche OGG-Datei soll verarbeitet werden?"
read -p "Dateiname (z. B. ly.ogg): " oggfile

# Prüfen ob Datei existiert
if [[ ! -f "$oggfile" ]]; then
    echo "❌ Datei '$oggfile' wurde nicht gefunden."
    exit 1
fi

# Dateiname ohne Endung
basename="${oggfile%.*}"
wavfile="${basename}.wav"

# OGG zu WAV konvertieren
echo "🔄 Konvertiere '$oggfile' zu '$wavfile'..."
ffmpeg -i "$oggfile" -ar 16000 -ac 1 "$wavfile"

if [[ ! -f "$wavfile" ]]; then
    echo "❌ Konvertierung fehlgeschlagen."
    exit 1
fi

# Whisper aufrufen
echo "🧠 Whisper wird gestartet..."
LD_LIBRARY_PATH=/home/marccark/Code/whispercpp/build/src /home/marccark/Code/whispercpp/build/bin/whisper-cli -m /home/marccark/Code/whispercpp/models/ggml-base.bin -f "$wavfile" -l de -otxt -of "$basename"



# Ausgabe prüfen
if [[ -f "$basename.txt" ]]; then
    echo "✅ Umwandlung erfolgreich: $basename.txt"
    read -p "💾 Textdatei speichern? (j/n): " save

    if [[ "$save" != "j" ]]; then
        rm "$basename.txt"
        echo "🗑️  Textdatei gelöscht."
    else
        mv "$basename.txt" "$basename.whisper.txt"
        echo "💾 Datei gespeichert als '$basename.whisper.txt'"
    fi
else
    echo "❌ Whisper hat keine Ausgabe erzeugt."
fi

# Aufräumen
read -p "♻️ WAV-Datei '$wavfile' löschen? (j/n): " delwav
[[ "$delwav" == "j" ]] && rm "$wavfile" && echo "🧹 WAV-Datei gelöscht."

read -p "♻️ OGG-Datei '$oggfile' löschen? (j/n): " delogg
[[ "$delogg" == "j" ]] && rm "$oggfile" && echo "🧹 OGG-Datei gelöscht."

echo
echo "✅ Vorgang beendet. Terminal bleibt offen..."
read -n 1 -s -r -p "🔁 Drücke eine Taste zum Schließen..."


