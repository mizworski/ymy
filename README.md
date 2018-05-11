# ymy

# Opis języka Ymy

Mój język jest zbliżony składnią do Pythona. Szkic gramatyki zapożyczyłem z: 
https://github.com/BNFC/bnfc/blob/master/examples/C/C.cf
Będę walczył o 24 punkty.

# Typy 

Int, Bool, String.
Unit - brak przymowanych argumentów / zwracanego wyniku.
[ Type ] - typy tablicowe
Type -> Type - dowolna funkcja
(Type -> Type) - funkcja jako argument

# Operacje arytmetyczne

Podstawowe operacje arytmetyczne:
+, -, *, /, %

Porównania:
<, <=, >, >=, ==, !=

Operacje logiczne:
and, or

Operatory unarne:
not, +, -

Operator ternarny:
cond ? expr1 : expr2

Operatory:
+=, -=, *=, /=, %=, ++ (postinc), -- (postdec)

# Podstawowe instrukcje

pętle for, while,
if, if else,
print (jako słowo kluczowe),
break, continue,
return (tylko z expr)

Ponadto deklaracje zmiennych są traktowane jako instrukcje, mogą więc być robione na zmianę z pozostałymi instrukcjami.

# Deklaracje i przypisania

Wszystkie zmienne należy zadeklarować przed użyciem z podaniem dokładnego typu. Nie można od razu inicjalizować zmiennej. Funkcje deklarujemy w tej samej przestrzeni nazw co zmienne, gdyż traktujemy je podobnie jak zmienne. 

Wszsystkie zmienne przekazywane są przez wartość (czy to dobry pomysł zważywszy na rekurencje i funkcje jako parametry?). 

```
x = 2
y = x
x = 3
print y // 2

x = [[1], [2]]
y = x
x[0] = [1, 2]
print y // [[1], [2]]

x = lambda x :: Int : x + 1
y = x
x = lambda x :: Int : x + 2
print x(1) // 3
print y(1) // 2
```

Występuje przesłanianie, statyczne wiązanie, zagnieżdżanie funkcji.

Funkcje możemy definiować przy użyciu słowa 'def', ale musimy ją uprzednio zadeklarować.

```
f :: Int -> Int
def f(x): {
	return x + 1
}
```

Raczej nie planuję częściowej aplikacji.

# Sprawdzanie typów

Interpreter przed wykonaniem programu sprawdza czy wszystkie typy się zgadzają.

# Runtime Errors

W przypadku błędu podczas wykonania instrukcji, interpreter przerywa natychmiastowo działanie, zwraca komunikat o błędzie. Stan interpretera pozostaje taki, jak przed rozpoczęciem wykonywania instrukcji.

# Tablice

Zmienne deklarujemy podobnie jak w Haskellu. Nie ma możliwości podania rozmiaru tablicy. Tablicę o dowolnej długości możemy uzyskać korzystając z konstrukcji podobnej jak w Pythonie:

```
a :: [Int]
a = [0] * 10
len(a) == 10 // True

// Dodatkowo

b :: [[Int]]
b = [[1,2], [3,4]]
b[0][1] // dobrze
// b[0, 1] - blad 

```

# Funkcje anonimowe

Dostępne są funkcje anonimowe. Podczas tworzenia ich musimy podać typy wszystkich argumentów.

```
x :: Int -> Int
y :: Unit -> Int
z :: Int

z = 3;
x = lambda x :: Int : x * x;
y = lambda : z + 2; 
```
Note:
Czy mógłbym się obejść bez deklaracji typów? W końcu korzystam z nich tylko: a) podczas przypisywania do zmiennych (typy argumentow już są) lub
b) podczas podawania jako argument do funkcji (też mam już typ) 

# Tabelka

```
Na 14 punktów
(+) 1 (dwa typy)
(+) 2 (arytmetyka, porównania)
(+) 3 (while, if)
+   4 (procedury lub funkcje, rekurencja)
(+) 5 (print)
    6 a) (przez zmienną i wartość)
(+)   b) (pętla for)
(?)   c) (string i rzutowania)
(+)   d) (wyrażenia z = ++ += itd)

Na 17 punktów
+ 7 (statyczne typowanie)
  Na 20 punktów
(+/-)8 (przesłanianie i statyczne wiązanie)
(+) 9 (obsługa błędów wykonania)
+   10 (funkcje zwracające wartość)
    11 a) (rekordy)
(+)    b) (tablice/listy)
       c) (słowniki)
       d) (krotki z przypisaniem)
+      e) (break, continue)
+      f) (funkcje jako parametry)
?      g) (funkcje w wyniku, domknięcia)
+      h) (funkcje anonimowe)

Na 24 punkty
+   12 (funkcje zagnieżdżone ze statycznym wiązaniem)
+   13 (jeszcze coś lub dwa)
```
