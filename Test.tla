-------------------------------- MODULE Test --------------------------------
EXTENDS Naturals

fact[n \in Nat] ==
    IF n = 0 THEN 1 ELSE n + fact[n - 1]

=============================================================================
\* Modification History
\* Last modified Sun May 23 20:31:17 CST 2021 by jiang
\* Created Sun May 23 20:24:38 CST 2021 by jiang
