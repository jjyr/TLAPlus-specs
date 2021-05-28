-------------------------- MODULE MemoryInterface --------------------------
VARIABLE memInt
CONSTANTS 
    Send(_, _, _, _),
    Reply(_,_,_,_),
    InitMemInt,
    Proc,
    Adr,
    Val
    
\* Assert the return value of Send & Reply
ASSUME \A p, d, miOld, miNew:
    /\ Send(p, d, miOld, miNew) \in BOOLEAN
    /\ Reply(p, d, miOld, miNew) \in BOOLEAN

-----------------------------------------------------------------------------

MReq == [op: {"Rd"}, adr: Adr] \union [op: {"Wr"}, adr: Adr, val: Val]
NoVal == CHOOSE v: v \notin Val

=============================================================================
\* Modification History
\* Last modified Sun May 23 16:22:27 CST 2021 by jiang
\* Created Sun May 23 16:12:15 CST 2021 by jiang
