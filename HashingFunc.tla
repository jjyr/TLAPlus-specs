 ---------------------------- MODULE HashingFunc ----------------------------
EXTENDS Integers
CONSTANTS Key
VARIABLES mapping, hash_v

NoVal == 0

Init == 
    /\ mapping = [k \in Key |-> NoVal]
    /\ hash_v = 1

TypeInvariant == 
    /\ mapping \in [Key |-> Int]
    /\ hash_v \in Int


DoHashing(input) == 
    /\ input \in Key
    /\ mapping[input] = NoVal
    /\ mapping' = [mapping EXCEPT ![input] = hash_v]
    /\ hash_v' = hash_v + 1
                   
Consistent ==
    \A x, y \in DOMAIN mapping:
        /\ NoVal \notin {mapping[x], mapping[y]} /\ x /= y => mapping[x] /= mapping[y]
        /\ NoVal \notin {mapping[x], mapping[y]} /\ x = y => mapping[x] = mapping[y]
        
        
IsAllKeyHashed == \A k \in DOMAIN mapping:
    /\ mapping[k] /= NoVal
    
Next == 
    /\ \E x \in Key:
        DoHashing(x)
    
Spec == Init /\ [][Next]_<<mapping, hash_v>>

-----------------------------------------------------------------------------

THEOREM Spec => [][TypeInvariant /\ Consistent]_<<mapping, hash_v>>
        

=============================================================================
\* Modification History
\* Last modified Mon May 31 18:18:14 CST 2021 by jiang
\* Created Fri May 28 15:28:26 CST 2021 by jiang
