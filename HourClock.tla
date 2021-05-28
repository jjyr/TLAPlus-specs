----------------------------- MODULE HourClock -----------------------------
EXTENDS Naturals
VARIABLE hr

HCini == hr \in (1 .. 12)
HCnxt == hr' = (hr % 12) + 1
HC == HCini /\ [][HCnxt]_hr

THEOREM HC => []HCini


=============================================================================
\* Modification History
\* Last modified Sun May 09 10:46:52 CST 2021 by jiang
\* Created Sun May 09 10:40:13 CST 2021 by jiang
