# Simulink Battery Management System (BMS) Models

This repository contains **Simulink models and scripts** developed for research on Battery Management System (BMS) algorithms for light-duty electric vehicles, specifically the Stellantis RAM ProMASTER van. The work focuses on **model-based software development, system integration, and simulation validation** using MATLAB/Simulink and related toolboxes.

## Overview

As a Research Assistant under the supervision of a PhD candidate, I, Tridib Banik, contributed to the design, simulation, and analysis of battery pack models and BMS subsystems. The repository includes models for cell monitoring, contactor control, passive cell balancing, SOC/SOP estimation, and other key BMS functionalities.

## Key Features & Contributions

1. **105s34p Battery Pack Modeling**
   - Functional simulation of a full-scale battery pack in Simulink.
   - Integrated subsystems: Cell Monitoring Unit (CMU), Battery Junction Box (BJB), contactor control, fault indicators, passive cell balancing, SOC/SOP estimation.

2. **Scaling from Emulator to Full Pack**
   - Expanded models from a 14-cell emulator to a 105-cell configuration.
   - Incorporated **140 temperature sensors** across 35 modules for thermal monitoring.

3. **Memory Usage Analysis**
   - Evaluated BMS subsystem memory usage.
   - Visualized microcontroller memory distribution via **intuitive pie charts** for efficient analysis.

4. **Simulation & Data Logging**
   - Logged and exported simulation data to MATLAB Workspace to verify subsystem behavior.
   - Ensured simulation results are consistent and deployable to physical battery packs.

5. **Tools & Technologies**
   - MATLAB, Simulink and Stateflow
   - Simscape & NXP Model-Based Design Toolbox
   - FreeMASTER for signal visualization
   - MATLAB scripting for analysis, plotting, and circuit design

6. **Research & Documentation**
   - Co-authored sections of a research manuscript: *“Holistic Memory Analysis of Battery Management System Algorithms for Light-Duty EV Battery Pack”* (in preparation).
   - Contributions cover **Contactor Control, Fault Management, and Passive Cell Balancing Strategies**.

## Skills & Learning Outcomes

- Embedded systems and microcontroller memory analysis
- Model-based design and system integration in MATLAB/Simulink
- EV battery technologies, BMS algorithm design, and validation
- Signal processing, visualization, and analysis of large-scale battery pack data
