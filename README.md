# 1KB Synchronous RAM Module

This project contains a Verilog implementation of a **1KB Synchronous Random Access Memory (RAM)**. The module supports basic read and write operations using a single `inout` data bus and a 10-bit address bus.

## Module Specifications
*   **Memory Size:** 1024 words (1KB)
*   **Word Width:** 8 bits
*   **Address Width:** 10 bits ($2^{10} = 1024$)
*   **Interface:** Bidirectional Data Bus (`inout`)
*   **Clocking:** Synchronous (Positive-Edge Triggered)

## Port Descriptions


| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1 | System Clock |
| `address` | Input | 10 | Memory address to access |
| `cs` | Input | 1 | **Chip Select:** Must be HIGH for any operation |
| `read` | Input | 1 | **Read Enable:** HIGH to output data from memory |
| `write` | Input | 1 | **Write Enable:** HIGH to store data into memory |
| `data` | Inout | 8 | Bidirectional Data Bus |

## Operational Logic

### 1. Write Operation
*   Set `cs = 1`, `write = 1`, and `read = 0`.
*   Provide the target address on `address` and data on the `data` bus.
*   Data is stored in `memory[address]` on the rising edge of `clk`.

### 2. Read Operation
*   Set `cs = 1`, `read = 1`, and `write = 0`.
*   Provide the target address on `address`.
*   On the rising edge of `clk`, the data is fetched and driven onto the `data` bus.

### 3. High-Impedance State
*   If `cs` is LOW or `read` is LOW, the `data` bus is set to **High-Z (`8'bz`)** to prevent bus contention.

## Usage Note
This module utilizes a single `inout` port for data. Ensure that the external driver of the `data` bus is set to high-impedance when `read` is active to avoid electrical conflicts.
