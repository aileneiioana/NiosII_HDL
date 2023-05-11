#include "adxl345.h"
#include "i2c_avalon_mm_if.h"


void config_device(adxl345_accel_range_t accel_range){


    //Set device into measurement mode by making sure that the Measure bit is set to 1 in the
    //POWER_CTL register. Default value is 0xA, thus it is already on by default.
    write_to_i2c_device(ADXL345_ADDR,ADXL345_POWER_CTL_REG,1,0xA);

    //Set device data format
    _range_accel = accel_range;

    // Set bit D3 to full resolution
    // Set INT_INVERT bit to 1 to activate active low interrupt
    // All other values are default 0

    alt_u8 set_accel_config =  0x20 | 0x8;


    // Add settings for g-range
    switch(accel_range) {
    case (ACCEL_RANGE_2G):
        set_accel_config = set_accel_config | (0b00);
        break;
    case (ACCEL_RANGE_4G):
        set_accel_config= set_accel_config | (0b01);
        break;
    case (ACCEL_RANGE_8G):
        set_accel_config= set_accel_config | (0b10);
        break;
    case (ACCEL_RANGE_16G):
        set_accel_config= set_accel_config | (0b11);
        break;
    }




    //Data format register
    write_to_i2c_device(ADXL345_ADDR,ADXL345_DATA_FORMAT_REG,1,set_accel_config);
    printf("Configuring ADXL345\n");

    //Disable FIFO, STREAM and Trigger mode. Not necessary as default is 0x0.
    write_to_i2c_device(ADXL345_ADDR,ADXL345_FIFO_CTL_REG,1,0x00);

    //set tap thresholds
    // The THRESH_TAP register is eight bits and holds the threshold value for tap interrupts. The data format is unsigned, therefore, the magnitude of the tap event is compared with the value in THRESH_TAP for normal tap detection. The scale factor is 62.5 mg/LSB (that is, 0xFF = 16 g). A value of 0 may result in undesirable behavior if single tap/double tap interrupts are enabled.
    write_to_i2c_device(ADXL345_ADDR,ADXL345_THRESH_TAP_REG,1,0x20); //1000 mg
    //The DUR register is eight bits and contains an unsigned time value representing the maximum time that an event must be above the THRESH_TAP threshold to qualify as a tap event. The scale factor is 625 μs/LSB. A value of 0 disables the single tap/ double tap functions.
    write_to_i2c_device(ADXL345_ADDR,ADXL345_DUR_REG,1,0x40); // < 30 ms
    //The latent register is eight bits and contains an unsigned time value representing the wait time from the detection of a tap event to the start of the time window (defined by the window register) during which a possible second tap event can be detected. The scale factor is 1.25 ms/LSB. A value of 0 disables the double tap function.
    write_to_i2c_device(ADXL345_ADDR,ADXL345_LATENT_REG,1,0x60); //40 ms
    //The window register is eight bits and contains an unsigned time value representing the amount of time after the expiration of the latency time (determined by the latent register) during which a second valid tap can begin. The scale factor is 1.25 ms/LSB. A value of 0 disables the double tap function
    write_to_i2c_device(ADXL345_ADDR,ADXL345_WINDOW_REG,1,0xFF); //38.75 ms


    //Initialize interrupts to be used
    write_to_i2c_device(ADXL345_ADDR,ADXL345_INT_MAP_REG,1,0x20); // map double tap to int2 pin and data ready to int1 pin
    write_to_i2c_device(ADXL345_ADDR,ADXL345_TAP_AXES_REG,1,0x01); // z-axis only
    write_to_i2c_device(ADXL345_ADDR,ADXL345_INT_ENABLE_REG,1,0xa0); // Enable data ready and double tap

}

alt_u8 read_device_id(void){

    alt_u8 data[8] = {0};
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DEV_ID_REG,1,&data[0]);

    return ((alt_u8) data[0]) & 0xff;
}


alt_u8 read_irq_reg(void){
    alt_u8 data = 0;
    read_from_i2c_device(ADXL345_ADDR,ADXL345_INT_SOURCE_REG,1,&data);
    //printf("IRQREG: 0x%x\n",data);
    return data;
}

alt_u8 read_adxl345_reg(int reg_addr){
    alt_u8 data = 0;
    read_from_i2c_device(ADXL345_ADDR,reg_addr,1,&data);
    //printf("IRQREG: 0x%x\n",data);
    return data;
}


adxl345_data_t read_acceleration_data(){


    alt_u16 ax = 0, ay = 0, az = 0;
    float value = 0;
    adxl345_data_t accel_data;
    alt_u8 data[8] = {0};
    alt_u8 no_bytes =6;
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAX0_REG,no_bytes,&data[0]);
  /*
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAX0_REG,1,&data[0]);
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAX1_REG,1,&data[1]);
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAY0_REG,1,&data[2]);
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAY1_REG,1,&data[3]);
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAZ0_REG,1,&data[4]);
    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATAZ1_REG,1,&data[5]);
*/

    ax = data[1] << 8 | data[0];
    ay = data[3] << 8 | data[2];
    az = data[5] << 8 | data[4];


    read_from_i2c_device(ADXL345_ADDR,ADXL345_DATA_FORMAT_REG,1,&data[0]);

    int full_res_bit = (data[0] >> 3 ) & 0x1;


    float resolution = (float) _range_accel / 512.0;

    if (full_res_bit) {
        resolution  = (float) 2/512;
    }



    value = (alt_16)ax;
    //accel_raw_data.x = ax;
    accel_data.x = value * resolution;

    value = (alt_16)ay;
    //accel_raw_data.y = ay;
    accel_data.y = value * resolution;

    value = (alt_16)az;
    //accel_raw_data.z = az;   //accRange * value / 32768;
    accel_data.z = value * resolution;

    return accel_data;

}
