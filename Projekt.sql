/*
  Tabela umowy
    id_umowy NUMBER, - liczba klucz glowny
    rodzaj_umowy VARCHAR2(40) NOT NULL - ciag znakow nie moze byc puty oznacza rodzaj umowy
    pensja NUMBER NOT NULL - liczba nie moze byc pusta
    PRIMARY KEY(id_umowy)
*/

CREATE TABLE umowy (
    id_umowy NUMBER,
    rodzaj_umowy VARCHAR2(40) NOT NULL,
    pensja NUMBER NOT NULL,
    PRIMARY KEY(id_umowy));
  /*
  Tabela pracownicy
    id_pracownika NUMBER - liczba klucz glowny,
    imie VARCHAR2(30) NOT NULL - liczba klucz glowny,
    nazwisko VARCHAR2(30) NOT NULL - ciag znakow nie moze byc pusty oznacza nazwisko
    plec VARCHAR2(1) CHECK (plec IN ('m','k')) NOT NULL - znak do wyboru k lub m ozanczajacy plec k = kobieta, m = mê¿czyzna
    pesel VARCHAR2(11) NOT NULL UNIQUE - ciag 11 znakow w domsle oznacza pesel skladajacy sie z 11 cyfr lecz dopuszcza pesele obcokrajowców nie moze byc pusty nie moze sie powtarzac
    numer_telefonu NUMBER(9) NOT NULL  - ciag 9 cyfr symbolizujacy numer nie moze byc pusty
    mail VARCHAR2(40) DEFAULT 'Nie podano' - ciag do 40 znakow oznacza mail w przypadku nie podania maila rekord zostanie ustawiony na "Nie podano"
    rodzaj_kontraktu NUMBER NOT NULL 
    PRIMARY KEY (id_pracownika)
    FOREIGN KEY (rodzaj_kontraktu) REFERENCES umowy(id_umowy)
  */
CREATE TABLE pracownicy (
    id_pracownika NUMBER,
    imie VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    plec VARCHAR2(1) CHECK (plec IN ('m','k')) NOT NULL,
    pesel VARCHAR2(11) NOT NULL UNIQUE,
    numer_telefonu NUMBER(9) NOT NULL,
    mail VARCHAR2(40) DEFAULT 'Nie podano',
    rodzaj_kontraktu NUMBER NOT NULL,
    PRIMARY KEY (id_pracownika),
    FOREIGN KEY (rodzaj_kontraktu) REFERENCES umowy(id_umowy));
    
 /*
  Tabela
    id_karnetu NUMBER - numer klucz glowny
    nazwa_karnetu VARCHAR2(30) NOT NULL - ciag do 30 znakow nie moze byc pusty oznacza nazwe karnetu
    upust NUMBER(2) NOT NULL - liczba mniejsza od 100 nie moze byc pusta oznacza upust w sklepie nie moze byc pusta
    PRIMARY KEY (id_karnetu) 
    */
CREATE TABLE karnety (
    id_karnetu NUMBER,
    nazwa_karnetu VARCHAR2(30) NOT NULL,
    upust NUMBER(2) NOT NULL,
    PRIMARY KEY (id_karnetu));
/*
  Tablica produkty 
    id_produktu NUMBER - numer klucz glowny
    nazwa VARCHAR2(100) NOT NULL - ciag do 100 znakow ozacza nazwa produktu nie moze byc pusty
    cena NUMBER NOT NULL - numer oznaczajacy cene produktu nie moze byc pusty
    PRIMARY KEY(id_produktu)
*/
CREATE TABLE produkty (
    id_produktu NUMBER,
    nazwa VARCHAR2(100) NOT NULL,
    cena NUMBER NOT NULL,
    PRIMARY KEY(id_produktu));
/*
  Tablica sklep
    id_sklepu NUMBER - numer klucz glowny
    pojemonsc NUMBER NOT NULL - numer oznacza ilosc przedmiotow jakie moze pomiescic sklep nie moze byc pusty
    id_sprzedawcy NUMBER - numer klucz obcy
    PRIMARY KEY (id_sklepu)
    FOREIGN KEY (id_sprzedawcy) REFERENCES pracownicy (id_pracownika)
*/
CREATE TABLE sklep (
    id_sklepu NUMBER,
    pojemonsc NUMBER NOT NULL,
    id_sprzedawcy NUMBER,
    PRIMARY KEY (id_sklepu),
    FOREIGN KEY (id_sprzedawcy) REFERENCES pracownicy (id_pracownika));
/*
  Tablica silownia
    id_silowni NUMBER - numer klucz glowny
    miejscowosc VARCHAR2(40) NOT NULL - ciag do 40 znakow oznacza miejscowosc w jakiej jest silownia  nie moze byc pusty
    ulica VARCHAR2(50) NOT NULL - ciag do 50 znakow oznacza ulice na jakiej jest silownia  nie moze byc pusty
    metrarz NUMBER NOT NULL - numer oznacza metrarz silowni nie moze byc pusty
    id_sklepu NUMBER - numer klucz obcy
    PRIMARY KEY (id_silowni),
    FOREIGN KEY (id_sklepu) REFERENCES sklep(id_sklepu));
*/

CREATE TABLE silownia (
    id_silowni NUMBER,
    miejscowosc VARCHAR2(40) NOT NULL,
    ulica VARCHAR2(50) NOT NULL, 
    metrarz NUMBER NOT NULL,
    id_sklepu NUMBER,
    PRIMARY KEY (id_silowni),
    FOREIGN KEY (id_sklepu) REFERENCES sklep(id_sklepu));
/*
  Tablica czlonowie
    id_czlonka NUMBER - numer klucz glowny
    imie VARCHAR2(30) NOT NULL - ciag do 30 znakow oznacza imie nie moze byc pusty
    nazwisko VARCHAR2(30) NOT NULL - ciag do 30 znakow oznacza nazwisko nie moze byc pusty
    plec VARCHAR2(1) CHECK( plec IN('m','k')) - znak do wyboru k lub m ozanczajacy plec k = kobieta, m = mê¿czyzna
    pesel VARCHAR2(11) NOT NULL UNIQUE - ciag 11 znakow w domsle oznacza pesel skladajacy sie z 11 cyfr lecz dopuszcza pesele obcokrajowców nie moze byc pusty nie moze sie powtarzac
    numer_telefonu NUMBER(9) NOT NULL - ciag 9 cyfr symbolizujacy numer nie moze byc pusty
    mail VARCHAR2(40) DEFAULT 'Nie podano' - ciag do 40 znakow oznacza mail w przypadku nie podania maila rekord zostanie ustawiony na "Nie podano"
    rodzaj_karnetu NUMBER - numer klucz obcy
    data_dolaczenia DATE NOT NULL - data dolaczenia nie moze byc pusta
    id_silowni NUMBER - numer klucz obcy
    PRIMARY KEY (id_czlonka),
    FOREIGN KEY (rodzaj_karnetu) REFERENCES karnety(id_karnetu),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni));
*/
CREATE TABLE czlonkowie (
    id_czlonka NUMBER,
    imie VARCHAR2(30) NOT NULL,
    nazwisko VARCHAR2(30) NOT NULL,
    plec VARCHAR2(1) CHECK( plec IN('m','k')),
    pesel VARCHAR2(11) NOT NULL UNIQUE,
    numer_telefonu NUMBER(9) NOT NULL,
    mail VARCHAR2(40) DEFAULT 'Nie podano',
    rodzaj_karnetu NUMBER,
    data_dolaczenia DATE NOT NULL,
    id_silowni NUMBER,
    PRIMARY KEY (id_czlonka),
    FOREIGN KEY (rodzaj_karnetu) REFERENCES karnety(id_karnetu),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni));
    
/*
  Tablica sprzet 
    id_sprzetu NUMBER - numer klucz glowny
    id_silowni NUMBER - numer klucz obcy
    nazwa_maszyny VARCHAR2(30) NOT NULL - ciag do 30 znakow oznacza nazwe maszyny nie moze byc pusty
    ilosc NUMBER DEFAULT(0) - numer oznacza ilosc maszyn danego typu nie moze byc pusty
    PRIMARY KEY (id_sprzetu),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni));
*/
CREATE TABLE sprzet (
    id_sprzetu NUMBER,
    id_silowni NUMBER,
    nazwa_maszyny VARCHAR2(30) NOT NULL,
    ilosc NUMBER DEFAULT(0),
    PRIMARY KEY (id_sprzetu),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni));
/*
  Tablica zajecia 
    id_zajecia NUMBER - numer klucz glowny
    id_silowni NUMBER - numer klucz obcy
    id_prowadzacego NUMBER - numer klucz obcy
    nazwa_zajec VARCHAR2(40) NOT NULL - ciag do 40 znakow ozaczajacy nazwe zajec  nie moze byc pusty
    PRIMARY KEY (id_zajecia),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni),
    FOREIGN KEY (id_prowadzacego) REFERENCES pracownicy(id_pracownika));
*/
CREATE TABLE zajecia (
    id_zajecia NUMBER,
    id_silowni NUMBER,
    id_prowadzacego NUMBER,
    nazwa_zajec VARCHAR2(40) NOT NULL,
    PRIMARY KEY (id_zajecia),
    FOREIGN KEY (id_silowni) REFERENCES silownia(id_silowni),
    FOREIGN KEY (id_prowadzacego) REFERENCES pracownicy(id_pracownika));
/*
  Tablica magazyn
    id_sklepu NUMBER - numer klucz glowny
    id_produktu NUMBER - numer klucz obcy
    ilosc NUMBER NOT NULL - numer oznacza ilosc przedmiotu w magazynie nie moze byc pusty
    FOREIGN KEY (id_produktu) REFERENCES produkty(id_produktu),
    FOREIGN KEY (id_sklepu)REFERENCES sklep(id_sklepu));
*/
CREATE TABLE magazyn(
    id_sklepu NUMBER,
    id_produktu NUMBER,
    ilosc NUMBER NOT NULL,
    FOREIGN KEY (id_produktu) REFERENCES produkty(id_produktu),
    FOREIGN KEY (id_sklepu)REFERENCES sklep(id_sklepu));
/*
  Tablica sprzedane
    id_produktu NUMBER - numer klucz obcy
    id_sklepu NUMBER -numer klucz obcy
    FOREIGN KEY (id_produktu) REFERENCES produkty(id_produktu),
    FOREIGN KEY (id_sklepu)REFERENCES sklep(id_sklepu));
*/
CREATE TABLE sprzedane(
    id_produktu NUMBER,
    id_sklepu NUMBER,
    FOREIGN KEY (id_produktu) REFERENCES produkty(id_produktu),
    FOREIGN KEY (id_sklepu)REFERENCES sklep(id_sklepu));
    
-- SELECT * FROM umowy;

INSERT INTO umowy VALUES(1,'Umowa o prace',6000);
INSERT INTO umowy VALUES(2,'Sta¿',2000);
INSERT INTO umowy VALUES(3,'Umowa o prace na czas nie okreslony',3250);
INSERT INTO umowy VALUES(4,'Umowa 1/2 etatu',1500);
INSERT INTO umowy VALUES(5,'Umowa o prace na czas okreslony',4000);
INSERT INTO umowy VALUES(6,'Umowa na okres probny',2500);
INSERT INTO umowy VALUES(7,'Umowa o dzielo',500);
INSERT INTO umowy VALUES(8,'Praktyki',1200);
INSERT INTO umowy VALUES(9,'Umowa o prace',7000);
INSERT INTO umowy VALUES(10,'Umowa o prace',15000);

-- SELECT * FROM pracownicy;

INSERT INTO pracownicy VALUES (1,'Jan','Kowalski','m',01263152412,503123512,'Jankowalski.go@gmail.com',5);
INSERT INTO pracownicy VALUES (2,'Kacper','Okowa','m',42294328810,605460511,'kacperokowa.go@gmail.com',2);
INSERT INTO pracownicy VALUES (3,'Bob','Marley','m',72413970282,198104379,'Bobmarley.go@gmail.com',10);
INSERT INTO pracownicy VALUES (4,'Alina','Lew','k',74183525110,867498906,'Alinalew.go@gmail.com',9);
INSERT INTO pracownicy VALUES (5,'Karolina','Baumister','k',58414441344,126892112,'Karolinabaumister.go@gmail.com',4);
INSERT INTO pracownicy VALUES (6,'Adam','Lagoda','m',14402358125,921537287,'Adamlagoda.go@gmail.com',8);
INSERT INTO pracownicy VALUES (7,'Alfred','Szklarski','m',84850076919,891518466,'Alfredszklarski.go@gmail.com',7);
INSERT INTO pracownicy VALUES (8,'Kamil','Wierczek','m',15393389192,887665202,'Kamilwieczek.go@gmail.com',6);
INSERT INTO pracownicy VALUES (9,'Margaret','Bar','k',46937764820,266530497,'Margaretbar.go@gmail.com',3);
INSERT INTO pracownicy VALUES (10,'Janina','Morawiecka','k',83965998382,571938596,'Janinamorawiecka.go@gmail.com',3);
INSERT INTO pracownicy VALUES (11,'Marek','Wronowski','m',67722380602,200852455,'Marekwronwski.go@gmail.com',3);
INSERT INTO pracownicy VALUES (12,'Malgorzata','Rutkowska','k',97871153049,010339695,'Malgorzatarutkowska.go@gmail.com',3);
INSERT INTO pracownicy VALUES (13,'Karolina','Polak','k',28117822690,349956526,'Karolinapolak.go@gmail.com',3);
INSERT INTO pracownicy VALUES (14,'Natasza','Kowalska','k',75398922905,826136953,'Nataszakowalska.go@gmail.com',3);
INSERT INTO pracownicy VALUES (15,'Franciszek','Grzelak','m',39819339613,326743120,'Franciszekgrzelak.go@gmail.com',3);
INSERT INTO pracownicy VALUES (16,'Adrianna','Kaczmarek','k',19512630740,153487657,'Adriannakaczmarek.go@gmail.com',3);
INSERT INTO pracownicy VALUES (17,'Aleksandra','Dudek','k',58446580289,538601629,'Aleksandradudek.go@gmail.com',3);
INSERT INTO pracownicy VALUES (18,'Wiktoria','Grabowska','k',40904842427,730905155,'Wiktoriagrabowska.go@gmail.com',3);
INSERT INTO pracownicy VALUES (19,'Arian','Wysocki','k',03541395452,850152349,'Adrianwysocki.go@gmail.com',3);
INSERT INTO pracownicy VALUES (20,'Julia','Zalewska','k',57875697828,878457950,'Juliazalewska.go@gmail.com',3);

-- SELECT * FROM karnety;

INSERT INTO karnety VALUES(1,'Silownia',5);
INSERT INTO karnety VALUES(2,'Silownia + zajecia',10);
INSERT INTO karnety VALUES(3,'Silownia + spa',10);
INSERT INTO karnety VALUES(4,'Silownia mlodziez',10);
INSERT INTO karnety VALUES(5,'Dziecko + opiekun',0);
INSERT INTO karnety VALUES(6,'Silownia + Trener',10);
INSERT INTO karnety VALUES(7,'Trener mma',5);
INSERT INTO karnety VALUES(8,'Karnet wszystko',20);
INSERT INTO karnety VALUES(9,'Karent - Back to gym',15);
INSERT INTO karnety VALUES(10,'Karent - karta rodzinna',0);

-- SELECT * FROM produkty;

INSERT INTO produkty VALUES(1,'Koszulka go gym',25);
INSERT INTO produkty VALUES(2,'Koszulka mma',30);
INSERT INTO produkty VALUES(3,'Koszulka go fit',30);
INSERT INTO produkty VALUES(4,'Koszulka we can do it',30);
INSERT INTO produkty VALUES(5,'Bluza we lift high',50);
INSERT INTO produkty VALUES(6,'Bluza sort is good',50);
INSERT INTO produkty VALUES(7,'Bluza go gym',50);
INSERT INTO produkty VALUES(8,'Bialko truskawka 1kg',60);
INSERT INTO produkty VALUES(9,'Bialko malina 1kg',60);
INSERT INTO produkty VALUES(10,'Bialko milka 500g',35);
INSERT INTO produkty VALUES(11,'Cytrulina Arbuz 400g',40);
INSERT INTO produkty VALUES(12,'Cytrulina pomelo 300g',35);
INSERT INTO produkty VALUES(13,'Tabletki z kofeina x 100',20);
INSERT INTO produkty VALUES(14,'Zastaw gum oporowych',45);
INSERT INTO produkty VALUES(15,'Maslo orzechowe 500g',15);
INSERT INTO produkty VALUES(16,'Kreatyna naturalna 500g',23);
INSERT INTO produkty VALUES(17,'Keratyna kiwi 500g',23);
INSERT INTO produkty VALUES(18,'Keratyna cola 500g',23);
INSERT INTO produkty VALUES(19,'Zestaw hantli',100);
INSERT INTO produkty VALUES(20,'Rekawice bokserskie',90);
INSERT INTO produkty VALUES(21,'Ochraniacze piszczelowe',110);
INSERT INTO produkty VALUES(22,'Owijki na nadgarstki',25);

-- SELECT * FROM sklep;

INSERT INTO sklep VALUES(1,50,11);
INSERT INTO sklep VALUES(2,24,12);
INSERT INTO sklep VALUES(3,42,13);
INSERT INTO sklep VALUES(4,30,14);
INSERT INTO sklep VALUES(5,32,15);
INSERT INTO sklep VALUES(6,56,16);
INSERT INTO sklep VALUES(7,34,17);
INSERT INTO sklep VALUES(8,61,18);
INSERT INTO sklep VALUES(9,32,19);
INSERT INTO sklep VALUES(10,26,20);

-- SELECT * FROM silownia;

INSERT INTO silownia VALUES(1,'Lublin','Lwowska',1040,1);
INSERT INTO silownia VALUES(2,'Lublin','Krasickiego',600,2);
INSERT INTO silownia VALUES(3,'Swidnik','Drzazga',900,3);
INSERT INTO silownia VALUES(4,'Piaski','Stodola',800,4);
INSERT INTO silownia VALUES(5,'Opole Lubelskie','Lipowa',1200,5);
INSERT INTO silownia VALUES(6,'Krzywda','Klonowa',950,6);
INSERT INTO silownia VALUES(7,'Warszawa','Akacjowa',860,7);
INSERT INTO silownia VALUES(8,'Piaseczno','Wolska',1000,8);
INSERT INTO silownia VALUES(9,'Krakow','Ryska',900,9);
INSERT INTO silownia VALUES(10,'Wieliczka','Zadrza',807,10);

-- SELECT * FROM zajecia;

INSERT INTO zajecia VALUES(1,1,2,'MMA');
INSERT INTO zajecia VALUES(2,2,4,'Zdrowy kregoslup');
INSERT INTO zajecia VALUES(3,3,13,'Zdrowe nogi');
INSERT INTO zajecia VALUES(4,4,14,'Seanse Spa');
INSERT INTO zajecia VALUES(5,5,5,'Box');
INSERT INTO zajecia VALUES(6,3,13,'Kick boxing');
INSERT INTO zajecia VALUES(7,2,12,'Podnoszenie ciê¿arów');
INSERT INTO zajecia VALUES(8,6,16,'Trójbój');
INSERT INTO zajecia VALUES(9,8,18,'Cross fit');
INSERT INTO zajecia VALUES(10,9,19,'Joga');

-- SELECT * FROM sprzet;

INSERT INTO sprzet VALUES(1,1,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(2,1,'Brama',1);
INSERT INTO sprzet VALUES(3,1,'Stol do armwrestlingu',1);
INSERT INTO sprzet VALUES(4,3,'Suwnica',1);
INSERT INTO sprzet VALUES(5,3,'Leg crawl',1);
INSERT INTO sprzet VALUES(6,3,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(7,4,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(8,4,'GRYFY',3);
INSERT INTO sprzet VALUES(9,4,'Zestaw ciezarow',1);
INSERT INTO sprzet VALUES(10,5,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(11,5,'Gumy oprowe',10);
INSERT INTO sprzet VALUES(12,5,'Leg crawl',1);
INSERT INTO sprzet VALUES(13,6,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(14,6,'Hantle 50kg - 70kg',1);
INSERT INTO sprzet VALUES(15,6,'Suwnica',1);
INSERT INTO sprzet VALUES(16,7,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(17,7,'Wieza 6 stanowisk',1);
INSERT INTO sprzet VALUES(18,7,'Bieznia',5);
INSERT INTO sprzet VALUES(19,8,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(20,8,'MMA',1);
INSERT INTO sprzet VALUES(21,8,'Skakanka',2);
INSERT INTO sprzet VALUES(22,9,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(23,9,'Schody',2);
INSERT INTO sprzet VALUES(24,9,'Zestaw Pilek 2 kg - 15kg',1);
INSERT INTO sprzet VALUES(25,2,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(26,2,'Bieznia',6);
INSERT INTO sprzet VALUES(27,2,'Wioslarz',2);
INSERT INTO sprzet VALUES(28,10,'Hantle 1kg - 40kg',1);
INSERT INTO sprzet VALUES(29,10,'Orbitrek',2);
INSERT INTO sprzet VALUES(30,10,'Bieznia',4);

SELECT * FROM sprzedane;

INSERT INTO sprzedane VALUES(1,2);
INSERT INTO sprzedane VALUES(2,1);
INSERT INTO sprzedane VALUES(3,5);
INSERT INTO sprzedane VALUES(4,5);
INSERT INTO sprzedane VALUES(5,2);
INSERT INTO sprzedane VALUES(6,1);
INSERT INTO sprzedane VALUES(7,9);
INSERT INTO sprzedane VALUES(8,8);
INSERT INTO sprzedane VALUES(9,7);
INSERT INTO sprzedane VALUES(10,7);
INSERT INTO sprzedane VALUES(11,6);
INSERT INTO sprzedane VALUES(12,5);
INSERT INTO sprzedane VALUES(13,10);
INSERT INTO sprzedane VALUES(14,1);
INSERT INTO sprzedane VALUES(15,4);

-- SELECT * FROM magazyn;

INSERT INTO magazyn VALUES(1,5,6);
INSERT INTO magazyn VALUES(1,22,1);
INSERT INTO magazyn VALUES(2,7,8);
INSERT INTO magazyn VALUES(2,19,2);
INSERT INTO magazyn VALUES(3,21,1);
INSERT INTO magazyn VALUES(3,6,7);
INSERT INTO magazyn VALUES(4,2,2);
INSERT INTO magazyn VALUES(4,8,3);
INSERT INTO magazyn VALUES(5,11,1);
INSERT INTO magazyn VALUES(5,17,3);
INSERT INTO magazyn VALUES(5,16,2);
INSERT INTO magazyn VALUES(6,10,8);
INSERT INTO magazyn VALUES(6,4,1);
INSERT INTO magazyn VALUES(7,21,3);
INSERT INTO magazyn VALUES(7,6,5);
INSERT INTO magazyn VALUES(8,16,1);
INSERT INTO magazyn VALUES(8,17,2);
INSERT INTO magazyn VALUES(9,12,4);
INSERT INTO magazyn VALUES(9,1,6);
INSERT INTO magazyn VALUES(10,8,1);
INSERT INTO magazyn VALUES(10,2,3);

-- SELECT * FROM czlonkowie;

INSERT INTO czlonkowie VALUES(1,'Kuba','Wieczorek','m',20123542912,413512612,'kuba.wieczorekinf@gmail.com',5,'2018/11/16',3);
INSERT INTO czlonkowie VALUES(2,'Aleksandra','Olszewski','k',96170088636,095391556,'KacperOlszewski@gmail.com',1,'2020/10/19',2);
INSERT INTO czlonkowie VALUES(3,'Miron','Wojtowicz','m',70709089708,755956664,'MironWojtowicz@wp.pl',3,'2016/12/01',4);
INSERT INTO czlonkowie VALUES(4,'Matylda','Stasiak','k',42257309248,822807869,'MatyldaStasiak@lady.com',10,'2012/09/6',1);
INSERT INTO czlonkowie VALUES(5,'Izabela','Pluta','k',58722316934,737336432,'IzabelaPluta@gmail.com',9,'2015/02/25',10);
INSERT INTO czlonkowie VALUES(6,'Zuzanna','Skowronska','k',29400960334,476248435,'ZuzannaSkowronska@garf.com',2,'2018/03/17',10);
INSERT INTO czlonkowie VALUES(7,'Gabriel','Kaczmarczyk','m',59319863351,866015309,'GabrielKaczmarczyk@gmail.com',9,'2019/06/08',6);
INSERT INTO czlonkowie VALUES(8,'Maja','Polak','k',41689631309,280141269,'MajaPolak@gmail.com',3,'2020/8/23',5);
INSERT INTO czlonkowie VALUES(9,'Mateusz','Janiszewski','m',22108703464,127993254,'MateuszJaniszewski@onet.pl',4,'2018/09/25',4);
INSERT INTO czlonkowie VALUES(10,'Krzysztof','Dziedzic','m',34819236910,437164397,'KrzysztofDziedzic@wp.pl',2,'2017/11/04',8);
