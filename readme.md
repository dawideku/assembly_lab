# Laboratorium z wprowadzenia do wysokowydajnych komputerów

## Lab1

### 1. Proste wyświetlanie napisu "Hello"
```bash
./hello
Hello !
```

### 2. Program wypisujący na ekranie wpisane 5 znaków
```bash
./writeText
Write text (5):
qwerty
Written text: qwert
```

### 3. Program porównujący czy wpisany tekst jest identyczny jak tekst wzorcowy
```bash
./compareText
Text to compare: jakistekst
Write text: jakistesy
Not same text
Written text: jakistesy

./compareText
Text to compare: jakistekst
Write text: jakistekst
same text
Written text: jakistekst
```

---

## Lab2

### Program zmieniający co drugi znak na małą lub dużą literę
```bash
./letters

Write text: qwertyuiQWERTYIU
New text: QwErTyUiqWeRtYiU
```

---

## Lab3

### Program wypisujący 8-znakową liczbę w systemie szesnastkowym na jej postać binarną
```bash
./tohex

Write text: ABC11592
New text: 10101011110000010001010110010010
```

## Lab4

### Program dodający dwie liczby 16-bajtowe w systemie szesnastkowym i wyświetlający wynik w postaci binarnej
```
Liczby:
liczba_1:
F064300099900000AAA00231F0F0F0F0
liczba_2:
0100000001100000BBB5000012312313
```

### Wynik jest długości 129 lub 128 bitów

```bash
./dodawanie

Sum as binary:
11110001011001000011000000000000100110101010000000000000000000010110011001010101000000100011001000000011001000100001010000000011
```

## Lab5

### Program mnożący dwie liczby 16-bajtowe w systemie szesnastkowym i wyświetlający wynik w postaci binarnej
```
Liczby:
liczba_1:
F064300099900000AAA00231F0F0F0F0
liczba_2:
0100000001100000BBB5000012312313
```

### Wynik jest długości 256 bitów

```bash
./mnozenie
Sum as binary:
0000000011110000011001000011000000000001100110001111101001110011101100011001000011101110111010001010010001010100001011010011111110000111000101001010111001010110001010010001111101011010100000100010001001011101000011001011010011010000110000101011000111010000
```