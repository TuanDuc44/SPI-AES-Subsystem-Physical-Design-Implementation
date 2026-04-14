# SPI-AES-Subsystem-Physical-Design-Implementation
This project demonstrates a complete ASIC Back-end flow (Physical Design) for an integrated SPI-AES subsystem. Utilizing the Librelane framework and OpenROAD engine, the design was transformed from RTL Verilog into a sign-off-ready GDSII layout.
# Technical Specifications
Process Design Kit (PDK): IHP 130nm / SkyWater 130nm (Open Source)
EDA Tools: Librelane, OpenROAD, Magic (DRC), Netgen (LVS), KLayout
Modules: SPI Wrapper, AES Core, Synchronizers, Edge Detectors, Wishbone Interface
Physical Sign-off: Clean DRC/LVS verified
# Physical Design Highlights
Design Constraints (SDC): Managed dual-stage timing constraints with pnr.sdc for implementation and signoff.sdc for final validation.
Clock Domain Crossing (CDC) Management: Successfully implemented and closed timing for specialized modules (synchronizer.sv, reclocking.sv) to ensure metastable-free operation across clock domains.
Floorplanning & Power Planning: Optimized core area and power distribution network (PDN) to meet target PPA (Power, Performance, Area).
Timing Closure: Achieved zero Setup and Hold violations by iteratively tuning placement and routing parameters within the OpenROAD engine.
Physical Verification: Achieved 0 DRC/LVS errors, ensuring the layout matches the netlist and meets manufacturing rules.
