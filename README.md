\# DE10-Lite Sensor → UART (Week 1)



\*\*Device\*\*: 10M50DAF484C7G  

\*\*Clock\*\*: 50 MHz



```mermaid

flowchart LR

&nbsp; S\[Sensor (I²C)] -->|SDA/SCL| I2C\[I²C Master]

&nbsp; I2C --> REG\[Data Registers]

&nbsp; REG --> PROC\[Processing Block]

&nbsp; PROC --> UART\[UART TX]

&nbsp; UART --> PC\[PC (USB-UART)]

&nbsp; PROC --> LEDS\[LEDs (debug)]

&nbsp; CLK\[\[50 MHz CLK]] --> I2C \& PROC \& UART

&nbsp; RST\[\[Reset Sync]] --> I2C \& PROC \& UART

Modules (planned)

top.v — top-level, pin hookups, reset sync



clk\_rst\_sync.v — reset synchronizer / optional div



i2c\_master.v — 100 kHz, 7-bit master



i2c\_regs.v — capture sensor bytes



proc\_block.v — light processing/formatting



baud\_gen.v — tick from 50 MHz for UART



uart\_tx.v — 8-N-1 transmitter (115200)



led\_debug.v — status → LEDs



Folders

src/ — HDL source files



test/ — Simulation/testbenches



docs/ — Diagrams and notes



constraints/ — Pin assignments (.qsf/.csv)



