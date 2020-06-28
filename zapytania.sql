
-- Select 1 tabela

-- 1 wbieranie czlonkow ktorzy doloczyli w roku 2020
SELECT id_czlonka, imie, nazwisko, pesel, data_dolaczenia FROM czlonkowie
WHERE data_dolaczenia > '2020/01/01';

-- 2 szukanie produktu o danym indeksie
SELECT id_sklepu FROM sprzedane
WHERE id_produktu = 1;

-- 3 szukanie umow z danego zakresu wyplaty
SELECT * FROM umowy
WHERE pensja < 3000;

-- 4 szukanie w ktorych silowniach odbywaja sie zajecia o danej nazwie
SELECT id_silowni From zajecia 
WHERE nazwa_zajec = 'MMA';

-- 5 szukanie pracownikow z okreslonym rodzajem kontraktu
SELECT * FROM pracownicy
WHERE rodzaj_kontraktu = 3;

-- 6 szukanie karetow ze od danym procencie upustu
SELECT * FROM karnety
WHERE upust > 10;

-- 7 szukanie silowni w których znajude sie okresiony sprzet o podanej ilosci
SELECT id_silowni FROM sprzet
WHERE nazwa_maszyny LIKE ('Bieznia') AND ilosc > 3; 

-- 8 wyswietlanie id sklepu o danej pojemnosci
SELECT id_sklepu FROM sklep
WHERE pojemonsc < 40;

-- 9 szukanie konkretnego produktu
SELECT * FROM produkty 
WHERE nazwa LIKE ('Bialko malina 1kg');

-- 10 szukanie siloni o okreslonej pojemnosci
SELECT * FROM silownia
WHERE metrarz BETWEEN 900 AND 1200;

-- Projekcje

-- 1 Sortowanie produktów po cenie
SELECT * FROM produkty
ORDER BY cena ASC;

-- 2 Sortowanie imie nazwisko czolonkow
SELECT id_czlonka, imie, nazwisko, pesel FROM czlonkowie
ORDER BY nazwisko, imie ASC;

-- 3 Wyswietlanie posortwanej listy zajec
SELECT DISTINCT nazwa_zajec FROM zajecia
ORDER BY nazwa_zajec asc;

-- 4 wypisuje place z umow
SELECT pensja FROM umowy;

-- 5 wypisuje poszczegulne rodzaje znizek
SELECT DISTINCT upust FROM karnety
ORDER BY upust DESC;

-- 6 wypisuje poszczegulne rodzaje maszyn znajdujacych sie na silowniach
SELECT DISTINCT nazwa_maszyny FROM sprzet;

-- 7 wypisuje rodzaje karnetów 
SELECT nazwa_karnetu FROM karnety;

-- 8 wypisuje silownie i segreguje je wzgledem metrarzu
SELECT id_silowni, miejscowosc, metrarz FROM silownia
ORDER BY metrarz;

-- 9 wypiusuje id sprzedawcow
SELECT id_sprzedawcy FROM sklep;

-- 10  wypisuje imoiona nazwiska i plec pracownikow
SELECT imie, nazwisko, plec FROM pracownicy;

-- SELECT 2 tabele

-- 1 wypisuje imiona czlonkow ktrórych upust jest wiekszy niz 10
SELECT czlonkowie.imie, czlonkowie.nazwisko FROM czlonkowie 
INNER JOIN karnety on czlonkowie.rodzaj_karnetu = karnety.id_karnetu
WHERE karnety.upust > 10;

-- 2 Sprzet z danego miasta
SELECT sprzet.nazwa_maszyny, sprzet.ilosc FROM sprzet
INNER JOIN silownia on sprzet.id_silowni = silownia.id_silowni
WHERE silownia.miejscowosc = 'Lublin';

-- 3 wysiwtla ilosc sprzetu w danej miejsowosc
SELECT SUM (sprzet.ilosc) FROM sprzet
INNER JOIN silownia on sprzet.id_silowni = silownia.id_silowni
WHERE silownia.miejscowosc = 'Warszawa'; 


-- 4 wysietla nazwy produktu wraz z iloscia z danego magazynu
SELECT produkty.nazwa, magazyn.ilosc FROM produkty
INNER JOIN magazyn on magazyn.id_produktu = produkty.id_produktu
WHERE magazyn.id_sklepu = 5;

-- 5 swietlanie osob z poszczegolnych miast
SELECT czlonkowie.imie, czlonkowie.nazwisko, czlonkowie.pesel FROM czlonkowie 
INNER JOIN silownia on czlonkowie.id_silowni = silownia.id_silowni
WHERE silownia.miejscowosc = 'Swidnik';

-- 6 wysietla nazwy i sliownie gdzie zostaly sprzedane przedmioty warte wiecej niz 40 
SELECT produkty.nazwa, sprzedane.id_sklepu FROM produkty
INNER JOIN sprzedane on produkty.id_produktu = sprzedane.id_produktu
WHERE produkty.cena > 40;

-- 7 Wypisuje pracownikow prowadzacych zajecia na silowni o danym id
SELECT UNIQUE pracownicy.imie, pracownicy.nazwisko FROM pracownicy 
INNER JOIN zajecia on pracownicy.id_pracownika = zajecia.id_prowadzacego
WHERE zajecia.id_silowni = 3;

-- 8 Wypuje silonie w ktory znajudua sie zajecia o danej nazwie
SELECT silownia.id_silowni, silownia.miejscowosc FROM silownia
INNER JOIN zajecia on silownia.id_silowni = zajecia.id_silowni
WHERE zajecia.nazwa_zajec LIKE ('Box');

-- 9 wyszukuje silownie w ktorych sa osoby o imieniu Kuba
SELECT UNIQUE silownia.id_silowni, silownia.miejscowosc FROM silownia
INNER JOIN czlonkowie on silownia.id_silowni = czlonkowie.id_silowni
WHERE czlonkowie.pesel = 'Kuba';

-- 10 Wypusje wszyskich pracownikow z danym typem umowy
SELECT pracownicy.imie, pracownicy.nazwisko, pracownicy.pesel FROM pracownicy
INNER JOIN umowy on pracownicy.rodzaj_kontraktu = umowy.id_umowy
WHERE umowy.rodzaj_umowy ='Umowa o prace na czas nie okreslony';

-- SELECT 3 TABLE

-- 1 wyswietla pracownikow ktorzy zarazbiaja wiecej niz 3000 i nazwy zajec jakie prowadza
SELECT pracownicy.imie, pracownicy.nazwisko, pracownicy.pesel, zajecia.nazwa_zajec FROM pracownicy
INNER JOIN umowy on pracownicy.rodzaj_kontraktu = umowy.id_umowy
INNER JOIN zajecia on pracownicy.id_pracownika = zajecia.id_prowadzacego
WHERE umowy.pensja > 3000;

-- 2 wywietla ile poszczegulna kobieta sprzedala przedmiotow
SELECT pracownicy.imie, pracownicy.nazwisko, COUNT(sprzedane.id_produktu) FROM sklep
INNER JOIN pracownicy on pracownicy.id_pracownika = sklep.id_sprzedawcy
INNER JOIN sprzedane on sprzedane.id_sklepu = sklep.id_sklepu
WHERE pracownicy.plec = 'k'
GROUP BY pracownicy.imie, pracownicy.nazwisko;

-- 3 wswietla osoby posiadajace karnet o nazwie silownia oraz nazwe miasta w jakim sie zapisali

SELECT czlonkowie.imie, czlonkowie.nazwisko, czlonkowie.pesel, silownia.miejscowosc FROM czlonkowie
INNER JOIN karnety on czlonkowie.rodzaj_karnetu = karnety.id_karnetu
INNER JOIN silownia on czlonkowie.id_silowni = silownia.id_silowni
WHERE karnety.nazwa_karnetu = 'Silownia';

-- 4 wysietla silownie w ktory odbywaja sie zajecia cross fit i znajduje sie zestaw pilek
SELECT silownia.id_silowni, silownia.miejscowosc FROM silownia
INNER JOIN sprzet on sprzet.id_silowni = silownia.id_silowni
INNER JOIN zajecia on zajecia.id_silowni = silownia.id_silowni
WHERE zajecia.nazwa_zajec ='Cross fit' AND sprzet.nazwa_maszyny = 'Zestaw Pilek 2 kg - 15kg';

-- 5 wyswietla id sklepu i nazwe produktu ktory zostal sprzedany za mniej niz 50
SELECT sklep.id_sklepu, produkty.nazwa FROM sklep
INNER JOIN sprzedane on sprzedane.id_sklepu = sklep.id_sklepu
INNER JOIN produkty on produkty.id_produktu = sprzedane.id_produktu
WHERE produkty.cena < 50;

-- 6 wyswietla nazwy produktow ceny i sklepy w jakich sie znajduja pod warunkiem ze skelpy maja mniejsza pojemnasc niz 30
SELECT sklep.id_sklepu, produkty.nazwa,  produkty.cena FROM sklep 
INNER JOIN magazyn on magazyn.id_sklepu = sklep.id_sklepu
INNER JOIN produkty on produkty.id_produktu = magazyn.id_produktu
WHERE sklep.pojemonsc < 30;

-- 7  wyswietla id sklepow ktorych sprzedawcy zarabiaja wiecej niz 3000
SELECT sklep.id_sklepu FROM sklep
INNER JOIN pracownicy on pracownicy.id_pracownika = sklep.id_sprzedawcy
INNER JOIN umowy on umowy.id_umowy = pracownicy.rodzaj_kontraktu
WHERE umowy.pensja > 3000;

-- 8 liczy osoby posiadajace dany karnet na kazdej silowni
SELECT COUNT (czlonkowie.id_czlonka), silownia.id_silowni, silownia.ulica FROM silownia 
INNER JOIN czlonkowie on czlonkowie.id_czlonka = silownia.id_silowni
INNER JOIN karnety on karnety.id_karnetu = czlonkowie.rodzaj_karnetu
WHERE karnety.nazwa_karnetu = 'Karent - karta rodzinna'
GROUP BY silownia.id_silowni, silownia.ulica;

-- 9 wyswietla kobiety z silowni w ktorej pracuje pracownik z id 11
SELECT czlonkowie.imie, czlonkowie.nazwisko FROM czlonkowie 
INNER JOIN silownia on silownia.id_silowni = czlonkowie.id_silowni
INNER JOIN sklep on sklep.id_sklepu = silownia.id_sklepu
WHERE czlonkowie.plec = 'k' AND sklep.id_sprzedawcy = 11;

-- 10 wyswietla wszystkich czlonkow na których silowni znajduja sie Hantle 1kg - 40kg
SELECT czlonkowie.imie, czlonkowie.nazwisko, czlonkowie.pesel FROM czlonkowie 
INNER JOIN silownia on silownia.id_silowni = czlonkowie.id_silowni
INNER JOIN sprzet on sprzet.id_silowni = silownia.id_silowni
WHERE sprzet.nazwa_maszyny = 'Hantle 1kg - 40kg';
