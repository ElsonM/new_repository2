*-----------------------------------------------------------------------
*  Verbrauch_ERWEITERN
*Erweitern der internen Tabellen UNG_VERBTAB/GES_VERBTAB (gleichzeitig)
*Beide Tabellen sollen stets gleich viele Einträge haben.
*-----------------------------------------------------------------------
FORM VERBRAUCH_ERWEITERN.

  DATA: H_VW_AKT_ZEILE LIKE VW_AKT_ZEILE.

  DESCRIBE TABLE GES_VERBTAB LINES H_VW_AKT_ZEILE.

  IF H_VW_AKT_ZEILE = 0.
    CLEAR GES_VERBTAB.
    CLEAR UNG_VERBTAB.
*   MOVE SY-DATUM TO DATUM.                      "ch zu 3.0d - TIZO
    MOVE SY-DATLO TO DATUM.                      "
    PERFORM ERSTER_TAG_PERIODE USING DATUM ' '.
    MOVE DATUM TO GES_VERBTAB-ERTAG.
    MOVE DATUM TO UNG_VERBTAB-ERTAG.
* AHE: 08.04.98 - A (4.0c) HW 100826
    MOVE RM03M-ANTEI TO UNG_VERBTAB-ANTEI.
    MOVE RM03M-ANTEI TO GES_VERBTAB-ANTEI.
* AHE: 08.04.98 - E
    APPEND GES_VERBTAB.
    APPEND UNG_VERBTAB.
  ELSE.
    READ TABLE GES_VERBTAB INDEX H_VW_AKT_ZEILE.
    MOVE GES_VERBTAB-ERTAG TO DATUM.
    PERFORM VORIGE_PERIODE USING DATUM.
    CHECK T009B_ERROR = SPACE.
    CLEAR GES_VERBTAB.
    CLEAR UNG_VERBTAB.
    MOVE DATUM TO GES_VERBTAB-ERTAG.
    MOVE DATUM TO UNG_VERBTAB-ERTAG.
* AHE: 08.04.98 - A (4.0c) HW 100826
    MOVE RM03M-ANTEI TO UNG_VERBTAB-ANTEI.
    MOVE RM03M-ANTEI TO GES_VERBTAB-ANTEI.
* AHE: 08.04.98 - E
    APPEND GES_VERBTAB.
    APPEND UNG_VERBTAB.
  ENDIF.

ENDFORM.
