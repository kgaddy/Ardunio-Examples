#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
byte ip[] = { 192,168,1,177 };//this ipaddress
byte server[]   = {192,168,1,2};//the node server

Client client(server, 1337); // Start client mode, 1337 is the prt number

int sensorPin = A0; //the sensor
int sensorValue = 0;
String varOne,values,contentLen;
int charLength,diff,oldValue;



void setup() {
  contentLen="Content-length: ";
  varOne = String("code=Light&sensorValue=");
  oldValue=0;
  diff=0;
  Ethernet.begin(mac, ip);
  Serial.begin(9600);

}

void loop()
{
   delay(1000); // give the Ethernet a second
    charLength=0;
    sensorValue=0;
    sensorValue = analogRead(sensorPin); 
 
    //Serial.println(oldValue);
    Serial.println(sensorValue);

    if(sensorValue > oldValue)
    {
      diff=sensorValue-oldValue;
    }
    else{
      diff=oldValue-sensorValue;
    }
 
    if(diff>15)
    {
      Serial.println("logging A");
      Serial.println(sensorValue);
      Serial.println("logging B");
      oldValue = sensorValue;
     
      values=varOne + sensorValue;
      charLength=values.length();
        // if you get a connection, report back via serial:
        if(client.connect()) {
          Serial.println("connected");
          client.println("POST /device/post/ HTTP/1.0");
          client.println("Content-Type: application/x-www-form-urlencoded; charset=utf-8");
          client.println("Host: 192.168.1.2:1337?id=1&callback=moxsvc");
          client.println(contentLen + charLength);
          client.println();
          client.println(values);
          client.println();
        }
  }
 
    // we have read all we need from the server stop now
    if(!client.connected()) {
      client.stop();
    }
}
