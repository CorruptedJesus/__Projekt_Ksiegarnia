-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 22 Gru 2020, 19:32
-- Wersja serwera: 10.4.14-MariaDB
-- Wersja PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `__projekt_ksiegarnia`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cena` (IN `id` INT, IN `cena1` DECIMAL(5,2))  BEGIN
UPDATE towar SET cena = cena1 WHERE id_towar=id;
END$$

--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `ile_towarow` () RETURNS INT(11) BEGIN
	DECLARE ile INT;
    SELECT COUNT(*) INTO @ile FROM towar;
    RETURN @ile;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klient`
--

CREATE TABLE `klient` (
  `id_klient` int(4) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `nazwisko` varchar(50) DEFAULT NULL,
  `pesel` char(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nr_tel` char(9) DEFAULT NULL,
  `id_plec` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `klient`
--

INSERT INTO `klient` (`id_klient`, `imie`, `nazwisko`, `pesel`, `email`, `nr_tel`, `id_plec`) VALUES
(1, 'Adriana', 'Zakrzewska', '88111073685', 'adriana.zakrzewska@gmail.com', '14765088', 1),
(2, 'Urszula', 'Ziółkowska', '84073056586', 'urszula.ziolkowska@gmail.com', '897977639', 1),
(3, 'Dorota', 'Malinowska', '4270191129', 'dorota.malinowska@gmail.com', '484678783', 1),
(4, 'Blanka', 'Sikorska', '80031995177', 'blanka.sikorska@gmail.com', '632019628', 1),
(5, 'Gabriela', 'Maciejewska', '67091764712', 'gabriela.maciejowska@gmail.com', '774461134', 1),
(6, 'Milan', 'Piotrowski', '74010363141', 'milan.piotrowski@gmail.com', '799266135', 2),
(7, 'Mieszko', 'Zieliński', '80011364296', 'mieszko.zielinski@gmail.com', '518720782', 2),
(8, 'Franciszek', 'Cieślak', '69050917739', 'franciszek.cieslak@gmail.com', '293739852', 2),
(9, 'Daniel', 'Duda', '87050258782', 'daniel.duda@gmail.com', '602538251', 2),
(10, 'Igor', 'Kubiak', '58030495639', 'igor.kubiak@gmail.com', '968841820', 2),
(11, NULL, NULL, NULL, 'nie wlasciwy', NULL, NULL);

--
-- Wyzwalacze `klient`
--
DELIMITER $$
CREATE TRIGGER `powtorz_email_klient` BEFORE INSERT ON `klient` FOR EACH ROW BEGIN
	IF NEW.email IN(SELECT email from klient)
    THEN
    SET NEW.email='nie wlasciwy';
	END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `magazyn`
--

CREATE TABLE `magazyn` (
  `id_magazyn` int(11) NOT NULL,
  `ilosc` int(11) DEFAULT NULL,
  `id_towaru` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `magazyn`
--

INSERT INTO `magazyn` (`id_magazyn`, `ilosc`, `id_towaru`) VALUES
(1, 7, 1),
(2, 10, 2),
(3, 15, 3),
(4, 30, 4),
(5, 12, 5),
(6, 16, 6),
(7, 17, 7),
(8, 47, 8),
(9, 9, 9),
(10, 3, 10),
(11, 9, 11),
(12, 20, 12),
(13, 11, 13),
(14, 19, 14),
(15, 21, 15),
(16, 10, 16),
(17, 16, 17),
(18, 13, 18),
(19, 19, 19),
(20, 20, 20),
(21, 5, 21),
(22, 3, 22),
(23, 9, 23),
(24, 8, 24),
(25, 7, 25),
(26, 3, 26),
(27, 4, 27),
(28, 13, 28),
(29, 15, 29),
(30, 21, 30),
(31, 31, 31),
(32, 34, 32),
(33, 29, 33),
(34, 25, 34),
(35, 32, 35),
(36, 27, 36),
(37, 7, 37),
(38, 3, 38),
(39, 5, 39),
(40, 37, 40),
(41, 7, 41),
(42, 11, 42),
(43, 13, 43),
(44, 7, 44),
(45, 19, 45),
(46, 7, 46),
(47, 9, 47),
(48, 7, 48),
(49, 18, 49),
(50, 3, 50),
(51, 2, 51),
(52, 0, 52),
(53, 0, 53);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `plec`
--

CREATE TABLE `plec` (
  `id_plec` int(11) NOT NULL,
  `plec` enum('kobieta','mezczyzna') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `plec`
--

INSERT INTO `plec` (`id_plec`, `plec`) VALUES
(1, 'kobieta'),
(2, 'mezczyzna');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownik`
--

CREATE TABLE `pracownik` (
  `id_pracownik` int(11) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `nazwisko` varchar(50) DEFAULT NULL,
  `pesel` char(11) DEFAULT NULL,
  `data_urodzenia` date DEFAULT NULL,
  `id_zarobki` int(11) DEFAULT NULL,
  `id_plec` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `pracownik`
--

INSERT INTO `pracownik` (`id_pracownik`, `imie`, `nazwisko`, `pesel`, `data_urodzenia`, `id_zarobki`, `id_plec`) VALUES
(1, 'Adam', 'Rutkowski', '69030476517', '1969-03-04', 1, 2),
(2, 'Adam', 'Rutkowski', '69030476517', '1969-03-04', 1, 2),
(3, 'Adrian', 'Maciejewski', '77020525819', '1977-02-05', 2, 2),
(4, 'Dariusz', 'Jakubowski', '96122756921', '1996-12-27', 4, 2),
(5, 'Paweł', 'Górecki', '45091679582', '1945-09-16', 3, 2),
(6, 'Ireneusz', 'Krawczyk', '65072912941', '1965-07-29', 6, 2),
(7, 'Maciej', 'Zielinski', '65072145374', '1965-07-21', 4, 2),
(8, 'Konrad', 'Witkowski', '46102079429', '1946-10-20', 5, 2),
(9, 'Diego', 'Gorski', '65061319496', '1965-06-13', 2, 2),
(10, 'Jozef', 'Dabrowski', '98072355867', '1998-07-23', 1, 2),
(11, 'Konstancja', 'Baranowska', '2300642191', '1960-08-28', 6, 1),
(12, 'Miroslawa', 'Witkowska', '61081319841', '1960-08-28', 6, 1),
(13, 'Izyda', 'Mroz', '87071094794', '1960-08-28', 6, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `sprzedaz`
--

CREATE TABLE `sprzedaz` (
  `id_sprzedaz` int(11) NOT NULL,
  `data_sprzedazy` date DEFAULT NULL,
  `id_towar` int(11) DEFAULT NULL,
  `id_pracownik` int(11) DEFAULT NULL,
  `id_klient` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `sprzedaz`
--

INSERT INTO `sprzedaz` (`id_sprzedaz`, `data_sprzedazy`, `id_towar`, `id_pracownik`, `id_klient`) VALUES
(1, '1969-06-26', 11, 1, 1),
(2, '1969-12-16', 43, 1, 1),
(3, '1972-07-27', 33, 1, 2),
(4, '1976-04-27', 4, 2, 2),
(5, '1984-01-16', 17, 2, 2),
(6, '1984-11-21', 29, 2, 2),
(7, '1985-01-28', 21, 2, 2),
(8, '1986-07-14', 19, 3, 3),
(9, '1986-11-14', 53, 3, 3),
(10, '1990-07-11', 10, 3, 3),
(11, '1994-06-29', 45, 3, 3),
(12, '1995-05-25', 38, 4, 3),
(13, '1996-05-10', 47, 4, 4),
(14, '1997-03-10', 41, 4, 4),
(15, '1997-07-24', 6, 4, 4),
(16, '1998-11-09', 24, 5, 4),
(17, '2002-06-20', 30, 5, 4),
(18, '2003-09-22', 8, 5, 5),
(19, '2006-07-07', 19, 5, 5),
(20, '2007-10-05', 24, 5, 5),
(21, '2008-08-22', 38, 6, 5),
(22, '2008-11-17', 13, 6, 5),
(23, '2011-02-09', 18, 6, 5),
(24, '2012-12-24', 30, 6, 6),
(25, '2019-07-22', 45, 6, 6),
(26, '1990-05-18', 43, 6, 6),
(27, '1991-04-25', 44, 7, 6),
(28, '1991-09-27', 50, 7, 6),
(29, '1992-04-13', 29, 7, 6),
(30, '1993-02-23', 53, 7, 6),
(31, '1997-02-27', 52, 8, 7),
(32, '2000-12-14', 10, 8, 7),
(33, '2001-06-27', 31, 8, 7),
(34, '2002-05-24', 49, 8, 7),
(35, '2002-08-02', 25, 8, 8),
(36, '2003-01-31', 16, 9, 8),
(37, '2003-10-03', 38, 9, 8),
(38, '2004-03-04', 5, 9, 8),
(39, '2005-06-06', 39, 9, 9),
(40, '2006-08-14', 15, 10, 9),
(41, '2007-10-10', 48, 10, 10),
(42, '2007-11-21', 33, 10, 10),
(43, '2015-09-07', 43, 10, 10),
(44, '2015-10-14', 8, 10, 10),
(45, '2017-01-05', 43, 11, 10),
(46, '2017-07-21', 15, 11, 1),
(47, '2017-09-04', 27, 11, 5),
(48, '2017-12-11', 26, 11, 7),
(49, '2019-06-05', 53, 12, 3),
(50, '2020-04-16', 26, 12, 5),
(51, '2001-09-27', 33, 13, 4),
(52, '2004-02-09', 4, 13, 2),
(53, '2014-09-22', 1, 13, 8);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `towar`
--

CREATE TABLE `towar` (
  `id_towar` int(11) NOT NULL,
  `tytul` varchar(100) DEFAULT NULL,
  `autor` varchar(100) DEFAULT NULL,
  `cena` decimal(5,2) DEFAULT NULL,
  `id_typ` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `towar`
--

INSERT INTO `towar` (`id_towar`, `tytul`, `autor`, `cena`, `id_typ`) VALUES
(1, 'To', 'Stephen King', '45.90', 1),
(2, 'To', 'Stephen King', '45.90', 1),
(3, 'To', 'Stephen King', '45.90', 2),
(4, 'To', 'Stephen King', '45.90', 3),
(5, 'Instytut', 'Stephen King', '47.00', 1),
(6, 'Instytut', 'Stephen King', '47.00', 2),
(7, 'Instytut', 'Stephen King', '47.00', 3),
(8, 'Komorka', 'Stephen King', '29.90', 1),
(9, 'Komorka', 'Stephen King', '29.90', 2),
(10, 'Komorka', 'Stephen King', '29.90', 3),
(11, 'Worek kosci', 'Stephen King', '37.00', 2),
(12, 'Wiedzmin.Sezon Burz', 'Andrzej Sapkowski', '27.83', 1),
(13, 'Wiedzmin.Tom 1. Ostatnie zyczenie', 'Andrzej Sapkowski', '30.12', 1),
(14, 'Wiedzmin.Tom 1. Ostatnie zyczenie', 'Andrzej Sapkowski', '30.12', 3),
(15, 'Wiedzmin.Tom 2. Miecz przeznaczenia', 'Andrzej Sapkowski', '30.24', 1),
(16, 'Wiedzmin.Tom 2. Miecz przeznaczenia', 'Andrzej Sapkowski', '30.24', 3),
(17, 'Wiedzmin.Tom 3. Krew elfow', 'Andrzej Sapkowski', '30.11', 1),
(18, 'Wiedzmin.Tom 3. Krew elfow', 'Andrzej Sapkowski', '30.11', 3),
(19, 'Wiedzmin.Tom 4. Czas pogardy', 'Andrzej Sapkowski', '30.11', 1),
(20, 'Wiedzmin.Tom 4. Czas pogardy', 'Andrzej Sapkowski', '30.11', 3),
(21, 'Wiedzmin.Tom 5. Chrzest ognia', 'Andrzej Sapkowski', '29.71', 1),
(22, 'Wiedzmin.Tom 5. Chrzest ognia', 'Andrzej Sapkowski', '29.71', 3),
(23, 'Wiedzmin.Tom 6. Wieza Jaskolki', 'Andrzej Sapkowski', '47.60', 1),
(24, 'Wiedzmin.Tom 6. Wieza Jaskolki', 'Andrzej Sapkowski', '47.60', 3),
(25, 'Wiedzmin.Tom 7. Pani Jeziora', 'Andrzej Sapkowski', '30.52', 1),
(26, 'Wiedzmin.Tom 7. Pani Jeziora', 'Andrzej Sapkowski', '30.52', 3),
(27, 'Krolestwo', 'Jo Nesbo', '27.12', 1),
(28, 'Krolestwo', 'Jo Nesbo', '27.12', 2),
(29, 'Krolestwo', 'Jo Nesbo', '27.12', 3),
(30, 'Trzeci klucz', 'Jo Nesbo', '32.50', 1),
(31, 'Trzeci klucz', 'Jo Nesbo', '32.50', 2),
(32, 'Trzeci klucz', 'Jo Nesbo', '32.50', 3),
(33, 'Syn', 'Jo Nesbo', '33.00', 1),
(34, 'Syn', 'Jo Nesbo', '33.00', 2),
(35, 'Syn', 'Jo Nesbo', '33.00', 3),
(36, 'Macbeth', 'Jo Nesbo', '33.00', 1),
(37, 'Macbeth', 'Jo Nesbo', '33.00', 2),
(38, 'Macbeth', 'Jo Nesbo', '33.00', 3),
(39, 'Syn', 'Jo Nesbo', '29.00', 3),
(40, 'Syn', 'Jo Nesbo', '29.00', 2),
(41, 'Ruiny Gorlanu. Cykl Zwiadowcy. Ksiega 1', 'John Flanagan', '32.90', 1),
(42, 'Plonacy most. Cykl Zwiadowcy. Ksiega 2', 'John Flanagan', '31.50', 1),
(43, 'Ziemia skuta lodem. Cykl Zwiadowcy. Ksiega 3', 'John Flanagan', '32.90', 1),
(44, 'Bitwa o Skandie. Cykl Zwiadowcy. Ksiega 4', 'John Flanagan', '37.90', 1),
(45, 'Czarnoksieznik z Polnocy. Cykl Zwiadowcy. Ksiega 5', 'John Flanagan', '37.90', 1),
(46, 'Oblezenie Macindaw. Cykl Zwiadowcy. Ksiega 6', 'John Flanagan', '36.00', 1),
(47, 'Okup za Eraka. Cykl Zwiadowcy. Ksiega 7', 'John Flanagan', '37.00', 1),
(48, 'Krolowie Clonmelu. Cykl Zwiadowcy. Ksiega 8', 'John Flanagan', '37.00', 1),
(49, 'Halt w niebezpieczenstwie. Cykl Zwiadowcy. Ksiega 9', 'John Flanagan', '33.00', 1),
(50, 'Cesarz Nihon-Ja. Cykl Zwiadowcy. Ksiega 10', 'John Flanagan', '39.90', 1),
(51, 'Zaginione historie. Cykl Zwiadowcy. Ksiega 11', 'John Flanagan', '39.00', 1),
(52, 'Turniej w Gorlanie. Cykl Zwiadowcy Wczesne lata. Ksiega 1', 'John Flanagan', '37.90', 1),
(53, 'Bitwa na wrzosowiskach. Cykl Zwiadowcy Wczesne lata. Ksiega 2', 'John Flanagan', '39.90', 1);

--
-- Wyzwalacze `towar`
--
DELIMITER $$
CREATE TRIGGER `cena_0_towar` BEFORE INSERT ON `towar` FOR EACH ROW BEGIN
	IF NEW.cena <= 0
    THEN
    SET NEW.cena = NULL;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `typ`
--

CREATE TABLE `typ` (
  `id_typ` int(11) NOT NULL,
  `typ` enum('ksiazka','e-book','audiobook') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `typ`
--

INSERT INTO `typ` (`id_typ`, `typ`) VALUES
(1, 'ksiazka'),
(2, 'e-book'),
(3, 'audiobook');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `zarobki`
--

CREATE TABLE `zarobki` (
  `id_zarobki` int(11) NOT NULL,
  `zarobki` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `zarobki`
--

INSERT INTO `zarobki` (`id_zarobki`, `zarobki`) VALUES
(1, 5000),
(2, 10000),
(3, 15000),
(4, 7500),
(5, 9350),
(6, 4290);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `klient`
--
ALTER TABLE `klient`
  ADD PRIMARY KEY (`id_klient`),
  ADD KEY `id_plec` (`id_plec`);

--
-- Indeksy dla tabeli `magazyn`
--
ALTER TABLE `magazyn`
  ADD PRIMARY KEY (`id_magazyn`),
  ADD KEY `id_towaru` (`id_towaru`);

--
-- Indeksy dla tabeli `plec`
--
ALTER TABLE `plec`
  ADD PRIMARY KEY (`id_plec`);

--
-- Indeksy dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  ADD PRIMARY KEY (`id_pracownik`),
  ADD KEY `id_zarobki` (`id_zarobki`),
  ADD KEY `id_plec` (`id_plec`);

--
-- Indeksy dla tabeli `sprzedaz`
--
ALTER TABLE `sprzedaz`
  ADD PRIMARY KEY (`id_sprzedaz`),
  ADD KEY `id_towar` (`id_towar`),
  ADD KEY `id_pracownik` (`id_pracownik`),
  ADD KEY `id_klient` (`id_klient`);

--
-- Indeksy dla tabeli `towar`
--
ALTER TABLE `towar`
  ADD PRIMARY KEY (`id_towar`),
  ADD KEY `id_typ` (`id_typ`);

--
-- Indeksy dla tabeli `typ`
--
ALTER TABLE `typ`
  ADD PRIMARY KEY (`id_typ`);

--
-- Indeksy dla tabeli `zarobki`
--
ALTER TABLE `zarobki`
  ADD PRIMARY KEY (`id_zarobki`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `klient`
--
ALTER TABLE `klient`
  MODIFY `id_klient` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT dla tabeli `magazyn`
--
ALTER TABLE `magazyn`
  MODIFY `id_magazyn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT dla tabeli `plec`
--
ALTER TABLE `plec`
  MODIFY `id_plec` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  MODIFY `id_pracownik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT dla tabeli `sprzedaz`
--
ALTER TABLE `sprzedaz`
  MODIFY `id_sprzedaz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT dla tabeli `towar`
--
ALTER TABLE `towar`
  MODIFY `id_towar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT dla tabeli `typ`
--
ALTER TABLE `typ`
  MODIFY `id_typ` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `zarobki`
--
ALTER TABLE `zarobki`
  MODIFY `id_zarobki` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `klient`
--
ALTER TABLE `klient`
  ADD CONSTRAINT `klient_ibfk_1` FOREIGN KEY (`id_plec`) REFERENCES `plec` (`id_plec`),
  ADD CONSTRAINT `klient_ibfk_2` FOREIGN KEY (`id_plec`) REFERENCES `plec` (`id_plec`) ON DELETE SET NULL;

--
-- Ograniczenia dla tabeli `magazyn`
--
ALTER TABLE `magazyn`
  ADD CONSTRAINT `magazyn_ibfk_1` FOREIGN KEY (`id_towaru`) REFERENCES `towar` (`id_towar`) ON DELETE SET NULL;

--
-- Ograniczenia dla tabeli `pracownik`
--
ALTER TABLE `pracownik`
  ADD CONSTRAINT `pracownik_ibfk_1` FOREIGN KEY (`id_zarobki`) REFERENCES `zarobki` (`id_zarobki`),
  ADD CONSTRAINT `pracownik_ibfk_2` FOREIGN KEY (`id_plec`) REFERENCES `plec` (`id_plec`),
  ADD CONSTRAINT `pracownik_ibfk_3` FOREIGN KEY (`id_zarobki`) REFERENCES `zarobki` (`id_zarobki`) ON DELETE SET NULL,
  ADD CONSTRAINT `pracownik_ibfk_4` FOREIGN KEY (`id_plec`) REFERENCES `plec` (`id_plec`) ON DELETE SET NULL;

--
-- Ograniczenia dla tabeli `sprzedaz`
--
ALTER TABLE `sprzedaz`
  ADD CONSTRAINT `sprzedaz_ibfk_1` FOREIGN KEY (`id_towar`) REFERENCES `towar` (`id_towar`),
  ADD CONSTRAINT `sprzedaz_ibfk_2` FOREIGN KEY (`id_pracownik`) REFERENCES `pracownik` (`id_pracownik`),
  ADD CONSTRAINT `sprzedaz_ibfk_3` FOREIGN KEY (`id_klient`) REFERENCES `klient` (`id_klient`),
  ADD CONSTRAINT `sprzedaz_ibfk_4` FOREIGN KEY (`id_towar`) REFERENCES `towar` (`id_towar`) ON DELETE SET NULL,
  ADD CONSTRAINT `sprzedaz_ibfk_5` FOREIGN KEY (`id_pracownik`) REFERENCES `pracownik` (`id_pracownik`) ON DELETE SET NULL,
  ADD CONSTRAINT `sprzedaz_ibfk_6` FOREIGN KEY (`id_klient`) REFERENCES `klient` (`id_klient`) ON DELETE SET NULL;

--
-- Ograniczenia dla tabeli `towar`
--
ALTER TABLE `towar`
  ADD CONSTRAINT `towar_ibfk_1` FOREIGN KEY (`id_typ`) REFERENCES `typ` (`id_typ`),
  ADD CONSTRAINT `towar_ibfk_2` FOREIGN KEY (`id_typ`) REFERENCES `typ` (`id_typ`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
