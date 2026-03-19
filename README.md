# Traffic Light FSM

This project implements a 4-state traffic light controller in SystemVerilog and simulates its behavior in Questa.

The design is based on a Moore finite state machine. It controls two traffic directions, North-South and East-West, and moves through four states in sequence. In each state, one direction is allowed to proceed while the other remains stopped.

The state sequence is:

S0 -> S1 -> S2 -> S3 -> S0

The traffic light behavior in each state is defined as follows:

- S0: North-South Green, East-West RedA counter is used to hold each state for a fixed duration. In the testbench, a 10 ns clock is generated to keep the simulation practical and fast. For this reason, the FSM parameters were scaled for simulation, and the state transitions were observed over a reduced number of clock cycles. In the current simulation setup, the full sequence is completed after 400 clock cycles, and the simulation time corresponds to the number of generated testbench clock periods.

If the parameter inside `traffic_light_fsm` is set to the real clock frequency, such as 100 MHz, then the real 5-second delay for each state can also be simulated. However, this would require a much longer simulation time. Therefore, the simulation results shown here were obtained using a scaled model with an approximate 1:100000 timing ratio.

The project includes the main FSM design file, a testbench, and a Questa script for compilation and simulation.

- S1: North-South Yellow, East-West Red
- S2: North-South Red, East-West Green
- S3: North-South Red, East-West Yellow


A counter is used to hold each state for a fixed duration. In the testbench, a 10 ns clock is generated to keep the simulation practical and fast. For this reason, the FSM parameters were scaled for simulation, and the state transitions were observed over a reduced number of clock cycles. In the current simulation setup, the full sequence is completed after 400 clock cycles, and the simulation time corresponds to the number of generated testbench clock periods.

If the parameter inside `traffic_light_fsm` is set to the real clock frequency, such as 100 MHz, then the real 5-second delay for each state can also be simulated. However, this would require a much longer simulation time. Therefore, the simulation results shown here were obtained using a scaled model with an approximate 1:100000 timing ratio.

The project includes the main FSM design file, a testbench, and a Questa script for compilation and simulation.


Files:
- `traffic_light_fsm.sv`: main FSM design
- `traffic_light_fsm_tb.sv`: testbench
- `run.do`: Questa simulation script

To run the simulation:

```bash
vsim -do run.do
````

This project was prepared for the  ELE432 assignment.

<img width="742" height="144" alt="Screenshot from 2026-03-19 22-13-30" src="https://github.com/user-attachments/assets/e6bd7cc5-af3d-4b42-b0c2-77434c333090" />
<img width="1840" height="1022" alt="Screenshot testbench" src="https://github.com/user-attachments/assets/a4eccc89-3cd2-46ca-8a17-551e5f2434bb" />

