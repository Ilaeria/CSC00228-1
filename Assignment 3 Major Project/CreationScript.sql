-- phpMyAdmin SQL Dump
-- version 4.0.10.15
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 24, 2016 at 06:58 PM
-- Server version: 5.1.73
-- PHP Version: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jdoher10Ass3`
--

-- --------------------------------------------------------

--
-- Table structure for table `BOAT`
--

CREATE TABLE IF NOT EXISTS `BOAT` (
  `BoatName` varchar(100) NOT NULL,
  `ClubName` varchar(100) NOT NULL,
  `Size` tinyint(2) NOT NULL,
  PRIMARY KEY (`BoatName`),
  KEY `CLUB_BOAT_FK` (`ClubName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `CLUB`
--

CREATE TABLE IF NOT EXISTS `CLUB` (
  `ClubName` varchar(100) NOT NULL,
  `RegistrationDate` date NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Postcode` varchar(4) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  PRIMARY KEY (`ClubName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `COACH`
--

CREATE TABLE IF NOT EXISTS `COACH` (
  `MemberID` int(11) NOT NULL,
  `WHSCheckDate` date NOT NULL,
  `PoliceCheckDate` date NOT NULL,
  `Level` tinyint(1) NOT NULL,
  `CertificationDate` date NOT NULL,
  PRIMARY KEY (`MemberID`),
  KEY `MEMBER_COACH_FK` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DRUMMER`
--

CREATE TABLE IF NOT EXISTS `DRUMMER` (
  `MemberID` int(11) NOT NULL,
  `LastWorkshopDate` date DEFAULT NULL,
  PRIMARY KEY (`MemberID`),
  KEY `MEMBER_DRUMMER_FK` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DUES`
--

CREATE TABLE IF NOT EXISTS `DUES` (
  `ReceiptID` int(8) NOT NULL AUTO_INCREMENT,
  `MemberID` int(11) NOT NULL,
  `PaymentDate` date NOT NULL,
  `MembershipYear` int(4) NOT NULL,
  `Amount` decimal(5,2) NOT NULL,
  PRIMARY KEY (`ReceiptID`),
  KEY `MEMBER_DUES_FK` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `MEMBER`
--

CREATE TABLE IF NOT EXISTS `MEMBER` (
  `MemberID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `City` varchar(100) NOT NULL,
  `State` varchar(50) NOT NULL,
  `Postcode` varchar(4) NOT NULL,
  `Phone` varchar(50) NOT NULL,
  `Email` varchar(254) NOT NULL,
  `ReferrerID` int(11) DEFAULT NULL,
  `ClubName` varchar(100) NOT NULL,
  `ClubPosition` varchar(50) DEFAULT NULL,
  `DrummerYN` tinyint(1) NOT NULL,
  `SweepYN` tinyint(1) NOT NULL,
  `CoachYN` tinyint(1) NOT NULL,
  PRIMARY KEY (`MemberID`),
  KEY `MEMBER_REFERRED_FK` (`MemberID`),
  KEY `MEMBER_REFERRER_FK` (`ReferrerID`),
  KEY `CLUB_MEMBER_FK` (`ClubName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `RACE`
--

CREATE TABLE IF NOT EXISTS `RACE` (
  `RaceID` int(11) NOT NULL AUTO_INCREMENT,
  `RegattaID` int(11) NOT NULL,
  `HeatNumber` tinyint(2) NOT NULL,
  `RaceNumber` tinyint(2) NOT NULL,
  `RaceName` varchar(100) NOT NULL,
  `StartTime` time NOT NULL,
  `WinningClub` varchar(100) DEFAULT NULL,
  `WinningTime` time DEFAULT NULL,
  PRIMARY KEY (`RaceID`),
  KEY `REGATTA_RACE_FK` (`RegattaID`),
  KEY `CLUB_RACE_FK` (`WinningClub`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `RACE_REGISTRATION`
--

CREATE TABLE IF NOT EXISTS `RACE_REGISTRATION` (
  `RaceID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `BoatName` varchar(100) NOT NULL,
  `FeePaidYN` tinyint(1) NOT NULL,
  `SweepYN` tinyint(1) NOT NULL,
  `DrummerYN` tinyint(1) NOT NULL,
  `DateRegistered` date NOT NULL,
  PRIMARY KEY (`RaceID`,`MemberID`,`BoatName`),
  KEY `RACE_RACE_REGISTRATION_FK` (`RaceID`),
  KEY `MEMBER_RACE_REGISTRATION_FK` (`MemberID`),
  KEY `BOAT_RACE_REGISTRATION_FK` (`BoatName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `REGATTA`
--

CREATE TABLE IF NOT EXISTS `REGATTA` (
  `RegattaID` int(11) NOT NULL AUTO_INCREMENT,
  `RegattaName` varchar(100) NOT NULL,
  `RegattaDate` date NOT NULL,
  `OrganisingClub` varchar(100) NOT NULL,
  `Location` varchar(100) NOT NULL,
  `ContactMember` int(11) NOT NULL,
  PRIMARY KEY (`RegattaID`),
  KEY `CLUB_REGATTA_FK` (`OrganisingClub`),
  KEY `MEMBER_REGATTA_FK` (`ContactMember`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SWEEP`
--

CREATE TABLE IF NOT EXISTS `SWEEP` (
  `MemberID` int(11) NOT NULL,
  `Level` tinyint(1) NOT NULL,
  `CertificationDate` date NOT NULL,
  PRIMARY KEY (`MemberID`),
  KEY `MEMBER_SWEEP_FK` (`MemberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `BOAT`
--
ALTER TABLE `BOAT`
  ADD CONSTRAINT `CLUB_BOAT_FK` FOREIGN KEY (`ClubName`) REFERENCES `CLUB` (`ClubName`);

--
-- Constraints for table `COACH`
--
ALTER TABLE `COACH`
  ADD CONSTRAINT `MEMBER_COACH_FK` FOREIGN KEY (`MemberID`) REFERENCES `MEMBER` (`MemberID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `DRUMMER`
--
ALTER TABLE `DRUMMER`
  ADD CONSTRAINT `MEMBER_DRUMMER_FK` FOREIGN KEY (`MemberID`) REFERENCES `MEMBER` (`MemberID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `DUES`
--
ALTER TABLE `DUES`
  ADD CONSTRAINT `MEMBER_DUES_FK` FOREIGN KEY (`MemberID`) REFERENCES `MEMBER` (`MemberID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `MEMBER`
--
ALTER TABLE `MEMBER`
  ADD CONSTRAINT `CLUB_MEMBER_FK` FOREIGN KEY (`ClubName`) REFERENCES `CLUB` (`ClubName`),
  ADD CONSTRAINT `MEMBER_REFERRER_FK` FOREIGN KEY (`ReferrerID`) REFERENCES `MEMBER` (`MemberID`);

--
-- Constraints for table `RACE`
--
ALTER TABLE `RACE`
  ADD CONSTRAINT `CLUB_RACE_FK` FOREIGN KEY (`WinningClub`) REFERENCES `CLUB` (`ClubName`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `REGATTA_RACE_FK` FOREIGN KEY (`RegattaID`) REFERENCES `REGATTA` (`RegattaID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `RACE_REGISTRATION`
--
ALTER TABLE `RACE_REGISTRATION`
  ADD CONSTRAINT `BOAT_RACE_REGISTRATION_FK` FOREIGN KEY (`BoatName`) REFERENCES `BOAT` (`BoatName`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `MEMBER_RACE_REGISTRATION_FK` FOREIGN KEY (`MemberID`) REFERENCES `MEMBER` (`MemberID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `RACE_RACE_REGISTRATION_FK` FOREIGN KEY (`RaceID`) REFERENCES `RACE` (`RaceID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `REGATTA`
--
ALTER TABLE `REGATTA`
  ADD CONSTRAINT `MEMBER_REGATTA_FK` FOREIGN KEY (`ContactMember`) REFERENCES `MEMBER` (`MemberID`),
  ADD CONSTRAINT `CLUB_REGATTA_FK` FOREIGN KEY (`OrganisingClub`) REFERENCES `CLUB` (`ClubName`);

--
-- Constraints for table `SWEEP`
--
ALTER TABLE `SWEEP`
  ADD CONSTRAINT `MEMBER_SWEEP_FK` FOREIGN KEY (`MemberID`) REFERENCES `MEMBER` (`MemberID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
