# Traffic Light FSM

This project implements a 4-state traffic light controller in SystemVerilog and simulates its behavior in Questa.

The design is based on a Moore finite state machine. It controls two traffic directions, North-South and East-West, and moves through four states in sequence. In each state, one direction is allowed to proceed while the other remains stopped.

The state sequence is:

S0 -> S1 -> S2 -> S3 -> S0

The traffic light behavior in each state is defined as follows:

- S0: North-South Green, East-West Red
- S1: North-South Yellow, East-West Red
- S2: North-South Red, East-West Green
- S3: North-South Red, East-West Yellow

A counter is used to hold each state for a fixed duration. The clock frequency is set to 100 Hz and the state duration is set to 5 seconds. Based on these values, each state lasts 500 clock cycles.

The project includes the main FSM design file, a testbench, and a Questa script for compilation and simulation.

Files:
- `traffic_light_fsm.sv`: main FSM design
- `traffic_light_fsm_tb.sv`: testbench
- `run.do`: Questa simulation script

To run the simulation:

```bash
vsim -do run.do
````

This project was prepared for the ELE432 assignment.

```
