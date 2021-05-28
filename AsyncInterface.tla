--------------------------- MODULE AsyncInterface ---------------------------
EXTENDS Naturals

CONSTANT Data

VARIABLES rdy, ack, val

TypeInvariant == 
    /\ rdy \in {0, 1}
    /\ ack \in {0, 1}
    /\ val \in Data

-----------------------------------------------------------------------------

Init == 
    /\ rdy \in {0, 1}
    /\ ack = rdy
    /\ val \in Data
              
Send ==
    /\ ack = rdy
    /\ rdy' = 1 - rdy
    /\ val' \in Data
    /\ UNCHANGED<<ack>>
    
Recv ==
    /\ ack /= rdy
    /\ ack' = 1 - ack
    /\ UNCHANGED<<rdy, val>>
    
Next == Send \/ Recv

Spec ==
    /\ Init
    /\ [][Next]_<<rdy, ack, val>>

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Tue May 11 20:34:53 CST 2021 by jiang
\* Created Mon May 10 10:29:06 CST 2021 by jiang
