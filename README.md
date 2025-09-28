AHB to APB Bridge Using Verilog
Project Overview

This project implements a hardware bridge connecting the AHB bus to the APB bus using Verilog. It enables AHB masters to communicate with APB slaves, supporting single and burst read/write operations. Full testbenches and simulation results are included to validate functionality.

Features

AHB → APB bridge supporting single & burst transfers

Fully modular Verilog design

Testbenches for all main modules (AHB master, AHB slave, bridge, APB controller)

Simulation waveforms and synthesis results included

Architecture

Block Diagram:
![photo_2025-09-18_20-06-50](https://github.com/user-attachments/assets/052b80a5-1132-4d99-a21d-89f34de3c077)

Key Modules:

ahb_master.v → Generates AHB read/write requests

ahb_slave.v → Receives requests and sends responses

bridge_top.v → Converts AHB transactions to APB protocol

apb_controller.v → Manages APB read/write operations

apb_slave.v → Implements the peripheral behavior




Simulation Results :-

1)Simulation Of AHB-Slave-Interface block
<img width="1586" height="827" alt="Screenshot 2025-09-17 215351" src="https://github.com/user-attachments/assets/4eec8c56-070d-4d6b-bad1-c3c827c21d43" />

2)Simulation Of the Bridge Operations 

a)Single Read and Single Write 
<img width="1904" height="1015" alt="Screenshot 2025-09-20 104249" src="https://github.com/user-attachments/assets/1546f2d3-dc18-4857-a239-5f9810a08091" />

b)Burst Read
<img width="1887" height="981" alt="Screenshot 2025-09-20 103113" src="https://github.com/user-attachments/assets/192482e9-66d0-45ac-bfd5-d2dce1c789d1" />

c)Burst Write 
<img width="1904" height="1001" alt="Screenshot 2025-09-20 102500" src="https://github.com/user-attachments/assets/235408b8-9798-4dea-b690-ac45b0388478" />

Synthesis Results :-
AHB-APB BRIDGE 
<img width="1573" height="809" alt="Screenshot 2025-09-17 201543" src="https://github.com/user-attachments/assets/5cf00b3d-dc5d-44a9-9c47-073a294330bc" />

BRIDGE TOP (combining master,slave and the Bridge)
<img width="1583" height="812" alt="Screenshot 2025-09-17 201904" src="https://github.com/user-attachments/assets/8c1dd727-76e4-4cf2-a690-925a0537167d" />







