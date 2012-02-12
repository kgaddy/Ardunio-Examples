#include <OneWire.h>

/* DS18S20 Temperature chip i/o*/

OneWire  ds(10);  // on pin 10

void setup(void) {
  Serial.begin(9600);
}

void loop() {
  byte i;
  byte present = 0;
  byte data[12];
  byte addr[8];
  int Temp;
  if ( !ds.search(addr)) {
    //Serial.print("No more addresses.\n");
    ds.reset_search();
    return;
  }
  
  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);	   // start conversion, with parasite power on at the end

  delay(1000);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  present = ds.reset();
  ds.select(addr);
  ds.write(0xBE);	   // Read Scratchpad

  for ( i = 0; i < 9; i++) {	     // we need 9 bytes
    data[i] = ds.read();
  }
  Temp=(data[1]<<8)+data[0];//take the two bytes from the response relating to temperature

  Temp=Temp>>4;//divide by 16 to get pure celcius readout

  //next line is Fahrenheit conversion
  Temp=Temp*1.8+32; // comment this line out to get celcius

  Serial.println(Temp);
 
}

