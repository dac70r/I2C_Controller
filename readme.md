# Repository for I2C Controller Design
This I2C Controller is designed to accomodate the BH1750FVI Ambient Light Sensor. Slight modifications might be necessary to reuse this I2C Controller with other I2C device.

## I2C Protocol Overview
I2C is a half-duplex communication protocol, only a single controller can claim ownership of the I2C bus at a given time. Communication is initiated and ceased exclusively by an I2C Controller - which eliminates bus contention problems. That said, multiple controllers may connect to the I2C bus at the same time. 

## Version Control
- 4/8/2026 Init
- 13/8/2026 I2C Controller Complete & Able to Interface with BH1750. Lacks fine tuning and additional features.

## Appendix

### BH1750FVI Specifications
1. Slave Address: if ADDR = "H", 1011100. if ADDR = "L", 0100011.
2. BH1750FVI is unable to accept plural cmd without stop condition. Must insert SP every 1 Opecode.
3. Calculate LUX: if high and low bytes are: "10000011" "10010000" respectively, LUX = (2^15 + 2^9 + 2^8 + 2^7 + 2^4) / 1.2 ~ 28067

### Settling time of I2C signals on I2C bus (Open-drain/ Open Collector) (RC Circuit)
Because of capacitance on the I2C communication line, the SDA and SCL lines discharge with an exponential settling RC time constant depending on the size of the pullup resistor and capacitance on the I2C bus. Higher capacitance limits the speed of I2C communication, the number of devices, and the physical distance between devices on the bus. A smaller pullup resistor has a faster rise time, but requires more power for communication. A larger pullup resistor has a slower rise time leading to slower communication, but requires less power - Page 5, A Basic Guide to I2C, Texas Instruments.

### I2C Address
I2C Address is natively 7-bit. One might encounter 8-bit read/write address, which are comprised of the original 7-bit address <<1 + read/write bit. 

### I2C Start and Stop

sda:    1   0   0 ....      ....    0   0   1
scl:    1   1   0 ....      ....    0   1   1

