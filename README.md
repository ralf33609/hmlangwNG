# hmlangwng

Dieses Projekt ist ein Rewrite vom Rewrite des Projekts hmlangw von
Prof. Dr. Peter A. Henning (pahenning, GitHub, Juni 2025).

Es ermöglicht, das Raspberry-Funkmodul (HM-MOD-RPI-PCB) an einen FTDI- oder
anderen USB-UART-Adapter anzuschließen. Der Reset-Pin des Moduls wird dafür
statt an 5 V direkt an die DTR-Leitung des Adapters gelegt (DTR aktiv = Pin low
= Reset). Das ist eine Hardware-Modifikation.

Unterstützt wird nur HM-RF, kein HM-IP.

## Was sich gegenüber hmlangw ändert

- **Reset-Verfahren:** per DTR-Leitung statt über einen GPIO-Pin. Der Modus
  wird mit `-r` gewählt, aktuell gibt es nur `dtr` (Standard).
- **Abhängigkeiten:** libgpiod entfällt, das Binary hängt nur noch an libc.
- **Entfallen:** Betrieb am Raspberry-Header (GPIO-Reset) und der
  Software-Reset-Pfad für reine UART-Module.
- **Kleinere Anpassungen:** Standardgerät ist `/dev/ttyUSB0`; fehlt die
  Berechtigung für Echtzeit-Scheduling, läuft das Programm mit normaler Priorität
  weiter (mit Warnung); sicherere Temp-Dateien (`mkstemp`); Fehlermeldungen statt
  stillem Abbruch beim Thread-Start.
- **Fehlerbereinigung:** `-h` zeigt jetzt die Hilfe und endet mit Exit-Code 0.
  Vorher kam "invalid option -- 'h'" mit Exit-Code 1, weil das `h` in der
  Optionsliste fehlte.

## Bauen und Starten

Voraussetzung: `g++` und `make` (unter Debian/Raspberry Pi OS:
`sudo apt install build-essential`).

```bash
make
./hmlangwng -n <10-stellige Seriennummer>   # einmalig, speichert serialnumber.txt
./hmlangwng -n read                         # danach
```

Das Gateway lauscht auf TCP 2000 (BidCoS) und 2001 (Keepalive). Mit `-s` wählt
man ein anderes serielles Gerät, mit `-D` die ausführliche Ausgabe. `./hmlangwng -h`
zeigt alle Optionen.

## Teststand

Getestet: amd64 (Debian 13), FT232R mit HM-MOD-RPI-PCB, Anbindung an eine OpenCCU
als LAN-Gateway.

Ungetestet: Der Quelltext sollte sich auf einem aktuellen Raspberry Pi OS
(Debian trixie) direkt auf dem Gerät bauen lassen, auch auf dem Raspberry Pi Zero.
Ebenfalls ungetestet: `-u`/`-f` (Firmware-Update, braucht externe eq3-Tools) und
`-n auto`/`show`/`save`.

Nur ohne Hardware geprüft (Ausgabe und Exit-Code, nicht im Betrieb): die
Fehlerbereinigung bei `-h`.

Ziel ist, den USB-Adapter in einem minimalen Standard-Container (debian-slim)
verwenden zu können.

Vielen Dank an alle, die in vielen Teilabschnitten dieses Rewrite ermöglicht haben
und damit den Lebenszyklus von HM-RF verlängert haben.

Lizenz: siehe `LICENSE`.
