 ---------------------------- MODULE HashingFunc ----------------------------
CONSTANTS Key, Value
VARIABLES mapping

Init == mapping = {}
TypeInvariant == mapping \in [Key |-> Value]

mapping_values == { mapping[k] : k \in DOMAIN mapping }
NewHashingResult == CHOOSE v: v \notin mapping_values

Hash(input) == 
    /\ input \in Key
    /\ IF input \in DOMAIN mapping THEN
        mapping[input]
       ELSE
        LET
            r == NewHashingResult
        IN
            /\ mapping' = [mapping EXCEPT ![input] = r]
            /\ r
        
Consistent ==
    \/ \A x, y \in Key:
        /\ x /= y => Hash(x) /= Hash(y)
        /\ x = y => Hash(x) = Hash(y)
        

Next == CHOOSE x \in Key:
    Hash(x)
    
Spec == Init /\ [][Next]_mapping

-----------------------------------------------------------------------------

THEOREM Spec => [][TypeInvariant /\ Consistent]_mapping
        

=============================================================================
\* Modification History
\* Last modified Sat May 29 00:26:05 CST 2021 by jiang
\* Created Fri May 28 15:28:26 CST 2021 by jiang
