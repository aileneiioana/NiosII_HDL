#ifndef ADXL345_H
#define ADXL345_H


#include <stdio.h>
#include <system.h>
#include <io.h>
#include "alt_types.h"
#include "i2c_avalon_mm_if.h"
#include "unistd.h"


#define ADXL345_ADDR 0x53 //gsensor_alt_addr=0
#define ADXL345_DEV_ID 0xe5

//typedef enum {
//ADXL345 registers, see table 19 in datasheet.
#define ADXL345_DEV_ID_REG         0x00
#define ADXL345_THRESH_TAP_REG     0x1D
#define ADXL345_OFSX_REG           0x1E
#define ADXL345_OFSY_REG           0x1F
#define ADXL345_OFSZ_REG           0x20
#define ADXL345_DUR_REG            0x21
#define ADXL345_LATENT_REG         0x22
#define ADXL345_WINDOW_REG         0x23
#define ADXL345_THRESH_ACT_REG     0x24
#define ADXL345_THRESH_INACT_REG   0x25
#define ADXL345_TIME_INAC_REGT     0x26
#define ADXL345_ACT_INACT_CTL_REG  0x27
#define ADXL345_THRESH_FF_REG      0x28
#define ADXL345_TIME_FF_REG        0x29
#define ADXL345_TAP_AXES_REG       0x2A
#define ADXL345_ACT_TAP_STATUS_REG 0x2B
#define ADXL345_BW_RATE_REG        0x2C
#define ADXL345_POWER_CTL_REG      0x2D
#define ADXL345_INT_ENABLE_REG     0x2E
#define ADXL345_INT_MAP_REG        0x2F
#define ADXL345_INT_SOURCE_REG     0x30
#define ADXL345_DATA_FORMAT_REG    0x31
#define ADXL345_DATAX0_REG         0x32
#define ADXL345_DATAX1_REG         0x33
#define ADXL345_DATAY0_REG         0x34
#define ADXL345_DATAY1_REG         0x35
#define ADXL345_DATAZ0_REG         0x36
#define ADXL345_DATAZ1_REG         0x37
#define ADXL345_FIFO_CTL_REG       0x38
#define ADXL345_FIFO_STATUS_REG    0x39
//} adxl345Registers_t;


typedef struct {
    alt_u16 x;
    alt_u16 y;
    alt_u16 z;
} adxl345_raw_data_t;

typedef struct {
    float x;
    float y;
    float z;
} adxl345_data_t;




typedef enum
{
    ACCEL_RANGE_2G               = 2,// Sens 4/32768= 0,0001220703125 g/LSB (8192LSB/g)
    ACCEL_RANGE_4G               = 4,// Sens 8/32768= 0,000244140625 g/LSB  (4096LSB/g)
    ACCEL_RANGE_8G              = 8,// Sens 16/32768= 0,00048828125 g/LSB (2048LSB/g)
    ACCEL_RANGE_16G              = 16,// Sens 30/32768= 0,0009155273438 g/LSB (1024LSB/g)
} adxl345_accel_range_t;

typedef enum {
    ACCEL_RANGE = 2,
    RES_BITS = 10,

    THRES_TAP = 0x40,  // 62.5mg/LSB threshold for event
    OFSX = 0,
    OFSY = 0,
    OFSZ = 0,
    DUR = 0x30, // 625us/LSB (event should be less than duration) =0 disable tap functions
    LATENT = 0x40, // 1.25ms/LSB wait time from tap to start of time ADXL345_WINDOW
    WINDOW = 0xff, // 1.25ms/LSB window after wait time when second tap is valid
    TAP_X = 1,
    TAP_Y = 1,
    TAP_Z = 1,

    LOW_POWER_BIT = 0,
    BW_RATE = 0xA,
    MEASURE = 1,
    SLEEP = 0,
    WAKEUP = 0,
    INT_ENABLE = 0x60,
    INT_MAP = 0x20
} adxl345_config_t;


alt_u8 read_device_id();
void config_device(adxl345_accel_range_t accel_range);
alt_u8 read_irq_reg();
alt_u8 read_adxl345_reg(int reg_addr);

//adxl345_raw_data_t accel_raw_data;
//adxl345_data_t accel_data;
//read_acceleration_data_raw();
adxl345_data_t read_acceleration_data();
adxl345_accel_range_t accel_range;
float _range_accel;




#endif
