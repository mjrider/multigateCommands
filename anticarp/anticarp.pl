#!/usr/bin/perl -w
use strict;

my @first = (
    "In het bijzonder kunnen wij stellen dat ",   "Anderzijds zijn wij van mening dat ",
    "Wij kunnen er echter van uitgaan dat ",      "Hiermee rekening houdend is het juist dat ",
    "Waardoor ",                                  "De conclusie is gewettigd dat ",
    "Ook is het uiterst waarschijnlijk dat ",     "Met het oog op doelstellingen ten gevolge waarvan ",
    "U zult toch moeilijk kunnen ontkennen dat ", "De moderne opvatting gaat ervan uit dat "
);
my @second = (
    "het overgrote deel van de input/output co�rdinatie ", "een voortdurende stroom van effectieve informatie ",
    "de karakterisering van specifieke criteria ",         "de initialisering van de ontwikkeling van het kritieke subsysteem ",
    "het volledig ge�ntegreerde testprogramma ",           "de basis van de productconfiguratie ",
    "ieder geassocieerd dienstverlenend element ",         "de incorporatie van additionele uitvoeringsvoorwaarden ",
    "het onafhankelijk functioneel principe ",             "de primaire interrelatie van technologie�n "
);
my @third = (
    "gebruik moet maken van en functioneel verweven moet zijn met ",
    "de waarschijnlijkheid optimaliseert van het succes tot ",
    "de expliciete gebruikslimieten toevoegt aan ",
    "het noodzakelijk maakt dat urgent beschouwing wordt toegepast op ",
    "niet te onderschatten systeemonderzoek vergt om te komen tot ",
    "verder ge�laboreerd wordt met beschouwingen ten aanzien van ",
    "een uitermate interessante stimulans levert voor ",
    "het belang erkent van andere systemen en de noodzaak voor ",
    "invloed heeft op een buitengewoon interessante implementatie van ",
    "allesoverheersende bedrijfsvoorwaarden toevoegt aan "
);
my @fourth = (
    "het moderne doch gecompliceerde technische resultaat",
    "de verwachte vierde-generatieapparatuur",
    "het testen van de bedrijfszekerheid van het subsysteem",
    "het gestructureerde ontwerp dat gebaseerd is op de technologische concepten",
    "de initi�le grenzen van de classificatie-limiet",
    "de ontwikkeling van het technische gedrag over een gegeven tijdsbestek",
    "de heersende grondgedachte ten aanzien van systeemdwang en standaardisatie",
    "het concept van de stijgende penetratiegraad",
    "een willekeurige discontinue samenstellingmodus",
    "een volledige systeembenadering"
);

my $result = $first[ rand(@first) ] . $second[ rand(@second) ] . $third[ rand(@third) ] . $fourth[ rand(@fourth) ] . ".";

print "$result\n";
