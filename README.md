# ymy

# Opis języka Ymy

Język imperatywny ze składnią zbliżoną do Pythona.

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

return

Ponadto deklaracje zmiennych są traktowane jako instrukcje, mogą więc być robione na zmianę z pozostałymi instrukcjami.

# Deklaracje i przypisania

Wszystkie zmienne należy zadeklarować przed użyciem z podaniem dokładnego typu. Nie można od razu inicjalizować zmiennej. Funkcje deklarujemy w tej samej przestrzeni nazw co zmienne, gdyż traktujemy je podobnie jak zmienne. 

Wszsystkie zmienne przekazywane są przez wartość. 

```
x = 2;
y = x;
x = 3;
print y; // 2

x = [[1], [2]];
y = x;
x[0] = [1, 2];
print y // [[1], [2]];

x = lambda x :: Int : x + 1;
y = x;
x = lambda x :: Int : x + 2;
print x(1); // 3
print y(1); // 2
```

Występuje przesłanianie, statyczne wiązanie, zagnieżdżanie funkcji.

Funkcje możemy definiować przy użyciu słowa 'def', ale musimy ją uprzednio zadeklarować.

```
def f :: Int -> Int (x :: Int): {
	return x + 1;
}
```

# Sprawdzanie typów

Interpreter przed wykonaniem programu sprawdza czy wszystkie typy się zgadzają.

# Runtime Errors

W przypadku błędu podczas wykonania instrukcji, interpreter przerywa natychmiastowo działanie, zwraca komunikat o błędzie. Stan interpretera pozostaje taki, jak przed rozpoczęciem wykonywania instrukcji.

# Tablice

Zmienne deklarujemy podobnie jak w Haskellu. Nie ma możliwości podania rozmiaru tablicy. Tablicę o dowolnej długości możemy uzyskać korzystając z konstrukcji podobnej jak w Pythonie:

```
a :: [Int]
a = [0] * 10;
// len(a) == 10 , nie mamy wbudowanej funkcji len

// Dodatkowo

b :: [[Int]];
b = [[1,2], [3,4]];
b[0][1]; // dobrze
b[0, 1]; // tez dobrze

```

# Funkcje anonimowe

Dostępne są funkcje anonimowe. Podczas tworzenia ich musimy podać typy wszystkich argumentów.

```
x :: Int -> Int;
y :: Unit -> Int;
z :: Int;

z = 3;
x = lambda x :: Int : x * x;
y = lambda : z + 2; 
```

# Tabelka

```
Na 14 punktów
(+) 1 (dwa typy) (assignment.ymy)
(+) 2 (arytmetyka, porównania) (assignment.ymy)
(+) 3 (while, if) (loops.ymy)
(+) 4 (procedury lub funkcje, rekurencja) (fibo.ymy)
(+) 5 (print) (wszedzie)
    6 a) (przez zmienną i wartość)
(+)   b) (pętla for) (loops.ymy, arrays.ymy)
(?)   c) (string i rzutowania) (wszedzie, bez rzutowan)
(+)   d) (wyrażenia z = ++ += itd) (assignment.ymy, arrays.ymy itd)

Na 17 punktów
+ 7 (statyczne typowanie)
  Na 20 punktów
(+) 8 (przesłanianie i statyczne wiązanie) (static_binding.ymy, lambdas.ymy)
(+) 9 (obsługa błędów wykonania) (assignment.ymy, arrays.ymy)
(+) 10 (funkcje zwracające wartość) (lambdas.ymy)
    11 a) (rekordy)
(+)    b) (tablice/listy) (arrays.ymy, lambdas.ymy)
       c) (słowniki)
       d) (krotki z przypisaniem)
(+)    e) (break, continue)
(+)    f) (funkcje jako parametry) (lambdas.ymy)
(?)    g) (funkcje w wyniku, domknięcia) (lambdas.ymy)
(+)    h) (funkcje anonimowe) (lambdas.ymy)

Na 24 punkty
(+) 12 (funkcje zagnieżdżone ze statycznym wiązaniem) (nested_functions.ymy)
(+) 13 (jeszcze coś lub dwa)
```

# Uwagi dotyczace ostatecznej wersji

Pozostawilem enva jako liste par. Nie zmienilem store z par (typ, wartosc) na wartosc, anie nie dodalem nowego enva/stora dla type checka, a zamiast tego korzystam z tego samego enva i stora podczas statycznego typowania oraz dzialania interpretera. Swoja decyzje motywuje tym, ze moj program dziala w formie REPLa, wiec statyczne sprawdzenie musze robic na biezaco, wiec potrzebowalbym przechowywac jednoczesnie env+store dla dzialania interpretera oraz statycznego typowania, co jest wlasnie rownowazne przechowywaniu par.

Minusem moze byc przy przyzwalanie na konstrukcje: def f :: TypyArgumentow -> Unit -> TypWyniku np.
def x :: Int -> Unit -> Int (a :: Int) : return a;
ale juz to zostawilem.
konstrukcje typu:
def x :: Int -> Unit -> Int -> Int (a :: Int, b :: Int) : return a;
Type error: Expected type: 'Tunit', got: 'Tint'.
def x :: Int -> Unit -> Int -> Int (a :: Int, b :: Unit, c :: Int) : return a;
Syntax error
nie przechodza.
