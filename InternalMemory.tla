--------------------------- MODULE InternalMemory ---------------------------
EXTENDS MemoryInterface
VARIABLES mem, ctl, buf
-----------------------------------------------------------------------------
IInit ==
    /\ mem \in [Adr |-> Val]        \* The key is a set, so it's means that mem is a [Adr |-> Val] Set. So the \in here means \subset of [Adr |-> Val]
    /\ ctl = [p \in Proc |-> "rdy"] \* Each processror is ready to issue requests
    /\ buf = [p \in Proc |-> NoVal] \* Set each buf to NoVal
    /\ memInt \in InitMemInt
    
TypeInvariant ==
    /\ mem \in [Adr |-> Val]
    /\ ctl \in [Proc |-> {"rdy", "busy", "done"}]
    /\ buf \in [Proc |-> MReq \union Val \union {NoVal}] \* Request or Reponse(Val)
    
Req(p) ==
    /\ ctl[p] = "rdy"
    /\ \E req \in MReq:
        /\ Send(p, req, memInt, memInt')
        /\ buf' = [buf EXCEPT ![p] = req]
        /\ ctl' = [ctl EXCEPT ![p] = "busy"]
    /\ UNCHANGED mem
    
Do(p) ==
    /\ ctl[p] = "busy"
    /\ mem' = IF buf[p].op = "Wr"
                THEN [mem EXCEPT
                        ![buf[p].addr] = buf[p].val]
                ELSE mem
    /\ buf' = [buf EXCEPT
                ![p] = IF buf[p].op = "Wr"
                        THEN NoVal
                        ELSE mem[buf[p].adr]]
    /\ ctl' = [ctl EXCEPT ![p] = "done"]
    /\ UNCHANGED memInt
    
Rsp(p) ==
    /\ ctl[p] = "done"
    /\ Reply(p, buf[p], memInt, memInt')
    /\ ctl' = [ctl EXCEPT ![p] = "rdy"]
    /\ UNCHANGED<<mem, buf>>
    
INext == \E p \in Proc: Req(p) \/ Do(p) \/ Rsp(p)

ISpec == IInit /\ [][INext]_<<memInt, mem, buf, ctl>>

---------------------------------------------------------------------------------

THEOREM ISpec => []TypeInvariant


=============================================================================
\* Modification History
\* Last modified Sun May 23 18:09:26 CST 2021 by jiang
\* Created Sun May 23 15:26:12 CST 2021 by jiang
