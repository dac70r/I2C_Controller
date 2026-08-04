# Repository for I2C Controller Design

## I2C Protocol Overview
I2C is a half-duplex communication protocol, only a single controller can claim ownership of the I2C bus at a given time. Communication is initiated and ceased exclusively by an I2C Controller - which eliminates bus contention problems. That said, multiple controllers may connect to the I2C bus at the same time. 

## Version Control
- 4/8/2026 Init

## Appendix

### Settling time of I2C signals on I2C bus (Open-drain/ Open Collector) (RC Circuit)
Because of capacitance on the I2C communication line, the SDA and SCL lines discharge with an exponential settling RC time constant depending on the size of the pullup resistor and capacitance on the I2C bus. Higher capacitance limits the speed of I2C communication, the number of devices, and the physical distance between devices on the bus. A smaller pullup resistor has a faster rise time, but requires more power for communication. A larger pullup resistor has a slower rise time leading to slower communication, but requires less power - Page 5, A Basic Guide to I2C, Texas Instruments.

### I2C Start and Stop

sda:    1   0   0 ....      ....    0   0   1
scl:    1   1   0 ....      ....    0   1   1

