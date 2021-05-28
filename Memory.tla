------------------------------- MODULE Memory -------------------------------
EXTENDS MemoryInterface

Inner(mem, ctl, buf) == INSTANCE InternalMemory

Spec == \E  mem, ctl, buf: Inner(mem, ctl, buf)!ISpec

=============================================================================
\* Modification History
\* Last modified Sun May 23 20:15:01 CST 2021 by jiang
\* Created Sun May 23 20:13:16 CST 2021 by jiang
