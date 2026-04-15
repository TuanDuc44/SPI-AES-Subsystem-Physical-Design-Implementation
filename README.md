# SPI-AES Subsystem: RTL-to-GDSII Physical Design Flow

## Overview

This project demonstrates a complete Physical Design (PD) flow for an **SPI-AES Subsystem**. Using the **Librelane** framework and **OpenROAD** engine, the design was implemented from RTL netlist to a production-ready **GDSII** layout.

## Key Technical Specifications

- **PDK**: IHP 130nm / SkyWater 130nm
- **Tools**: Librelane, OpenROAD, Magic (DRC), Netgen (LVS)
- **Core Modules**: SPI Wrapper, AES Core, Synchronizers, and Edge Detectors

## Physical Design Highlights

- **Synthesis & Constraints**: Applied rigorous timing constraints using `pnr.sdc` to guide the placement and routing phases.
- **Floorplanning**: Optimized core utilization and power grid (PDN) to ensure minimal IR-drop.
- **Clock Tree Synthesis (CTS)**: Achieved balanced clock distribution for high-frequency synchronization modules (`synchronizer.sv`, `reclocking.sv`).
- **Timing Sign-off**: Verified final timing convergence using `signoff.sdc` to ensure zero setup/hold violations.
- **Physical Verification**: Successfully passed **DRC (Design Rule Check)** and **LVS (Layout Vs Schematic)** with zero errors.

## How to Reproduce

1. Install Librelane environment.
2. Place the RTL files in the `design/` folder.
3. Run the flow:
   ```bash
   librelane run config.json
   ```

## GDSII Layout Preview

![GDSII Layout Preview](layout/spi.png)

**Figure 1**: Final GDSII layout with 0 DRC/LVS errors

- **Tools**: KLayout view of the final routed design using Librelane/OpenROAD flow
- **Status**: Clean routing with zero DRC/LVS violations
- **Pin Placement**: Optimized I/O pins for `wbs_dat_o`, `wbs_dat_i`, and `wb_clk_i` to minimize wire length and congestion
- **Core Density**: High utilization with balanced cell placement and power grid distribution

---

## Physical Design & Sign-off Results

### 1. Physical Design (PnR) Summary

The design was implemented using the Librelane/OpenROAD flow on the IHP/SkyWater 130nm node. All timing and physical constraints were met with significant margins.

#### Key PPA (Power, Performance, Area) Metrics

| Metric | Result | Status/Note |
|--------|--------|------------|
| Technology Node | IHP/SkyWater 130nm | Open-source PDK |
| Total Instance Count | 2,993 cells | Optimized density |
| Standard Cell Area | 37,661.5 µm² | Compact footprint |
| Core Utilization | 64.2% | Ideal for ASIC routability |
| Total Power | 0.86 mW | Ultra-low power consumption |
| Worst Setup Slack | 9.04 ns | Passed (Supports >100MHz) |
| Worst Hold Slack | 0.13 ns | Passed (No violations) |

### 2. Final Physical Sign-off Status

The layout has passed all rigorous industry-standard verification checks, ensuring the design is ready for fabrication.

- **DRC (Design Rule Check)**: 0 Errors (Verified by both Magic and KLayout)
- **LVS (Layout Vs Schematic)**: 0 Errors (Layout perfectly matches Netlist)
- **Antenna Check**: 0 Violations (Sign-off ready)
- **XOR Difference**: 0 (No layout discrepancies)
- **IR Drop Analysis**: 0.002V (Worst Case) - The robust Power Grid (PDN) design ensures minimal voltage droop and high physical integrity

### 3. Implementation Details & Analysis

- **Timing Closure**: Achieved timing convergence across multiple corners (Fast/Slow/Typical). The worst-case corner (`nom_slow_1p08V_125C`) maintains a healthy setup margin of 9.04ns.
- **Routing Optimization**: Successfully resolved 280 initial DRC issues through 3 iterations of automated routing, resulting in a 0 DRC error final GDSII.
- **Clock Tree Synthesis (CTS)**: Utilized 49 Clock Buffers and 14 Clock Inverters to minimize skew and ensure stable synchronization for cross-clock domain modules.
- **Physical Stability**: Integrated 1,557 Fill Cells (approx. 1/3 of the area) to ensure uniform density and facilitate potential future engineering change orders (ECO).

### 4. Design Artifacts

The following sign-off files are available in this repository:

- **output/spi_wb_wrapper.gds**: Final production-ready GDSII layout
- **reports/metrics.json**: Full PPA and timing summary
- **scripts/signoff.sdc**: Final timing constraints used for verification

---

## License

This project is licensed under the [Open Source License](LICENSE).

## Contact

For questions or further information, please reach out to the project maintainers.