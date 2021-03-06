
#include <Wire.h>

#include <MCP23017.h>

#include <Hackerling_Shield.h>

#include <MCP23008.h>

// include the library code:
//#include <Wire.h>
//#include <MCP23017.h>
#include "Print.h"

// The shield uses the I2C SCL and SDA pins. On classic Arduinos
// this is Analog 4 and 5 so you can't use those for analogRead() anymore
// However, you can connect other I2C sensors to the I2C bus and share
// the I2C bus.

void setup() {
  // Debugging output
  Serial.begin(9600);
  // set up the LCD's number of columns and rows:
	hs.begin();
	Serial.print("Step 7 Verification:\n Toggle the switch to verify that it works.\n");
}

#define TEST_STATE_SWITCH_ON 1
#define TEST_STATE_SWITCH_OFF 2
#define TEST_PASS 3

void printStates(uint8_t b){
	if(b & TEST_STATE_SWITCH_ON)
		Serial.print("On ");
	else
		Serial.print("   ");
	if(b & TEST_STATE_SWITCH_OFF)
		Serial.print("Off ");
	else
		Serial.print("    ");
}

uint8_t response=0;
uint8_t state=0;
uint8_t total=0;
void loop() {

	response = hs.readSwitches();
	if(response & 0x10)
		state=TEST_STATE_SWITCH_ON;
	else
		state=TEST_STATE_SWITCH_OFF;

	total |= state;
	if(total){
		Serial.print("Current:   ");
		printStates(state);
		Serial.print("  Seen:   ");
		printStates(total);
		if(total == TEST_PASS)
			Serial.print("      Test Complete: PASS! ");
		Serial.print("\n");
	}
	delay(100);

}
