\# DE10-Lite Sensor → UART (Week 1)



\*\*Device\*\*: 10M50DAF484C7G  

\*\*Clock\*\*: 50 MHz



flowchart LR
  S[Sensor (I²C)] -->|SDA/SCL| I2C[I²C Master]
  I2C --> REG[Data Registers]
  REG --> PROC[Processing Block]
  PROC --> UART[UART TX]
  UART --> PC[PC (USB‑UART)]
  PROC --> LEDS[LEDs (debug)]
  CLK[[50 MHz CLK]] --> I2C & PROC & UART
  RST[[Reset Sync]] --> I2C & PROC & UART

Modules (planned)

top.v — glue logic, pin hookups, reset sync.

clk_rst_sync.v — reset synchronizer & optional clock divs.

i2c_master.v — simple I²C master (you can start with 100 kHz, 7‑bit addr).

i2c_regs.v — capture sensor bytes into readable registers.

proc_block.v — any light processing/formatting (e.g., scale, checksum).

uart_tx.v — 8‑N‑1 transmitter with baud generator (115200 default).

led_debug.v — maps status/flags to LEDs.

baud_gen.v — tick generator from 50 MHz for UART.



Folders

src/ — HDL source files



test/ — Simulation/testbenches



docs/ — Diagrams and notes



constraints/ — Pin assignments (.qsf/.csv)



