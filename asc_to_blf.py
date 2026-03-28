# pip install python-can 

import can

# Read .asc and write .blf
with can.BLFWriter("MAC_BMSClosedLoopHIL_DCFC.blf") as blf:
    for msg in can.ASCReader("MAC_BMSClosedLoopHIL_DCFC.asc"):
        blf(msg)