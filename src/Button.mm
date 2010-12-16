/*
 *  Button.cpp
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Button.h"
#import "DeviceDetection.h"

Button::Button(float x, float y, string upFilename, string downFilename){
	
	
	if ([DeviceDetection detectScreen] == SCREEN_RETINA) {
		this->x = x * 2;
		this->y = y * 2;
	} else {
		this->x = x;
		this->y = y;
	}

	
	upImage.loadImage(upFilename);
	downImage.loadImage(downFilename);
	
	w = upImage.getWidth();
	h = upImage.getHeight();
	
	touched = false;
}

void Button::draw(){
	
	if (touched) {
		downImage.draw(x, y);
	} else {
		upImage.draw(x, y);
	}
	/*if (touched) {
		ofSetColor(255, 255, 255);
	}else {
		ofSetColor(100, 100, 100);
	}
	
	ofRect(x, y, w, h);
	 */
}

bool Button::isTouched(float xPos, float yPos){
	if ([DeviceDetection detectScreen] == SCREEN_RETINA) {
		xPos = xPos * 2;
		yPos = yPos * 2;
	}
	
	if(xPos > x && yPos > y && xPos < x + w && yPos < y + h){
		touched = true;
		return true;
	}
	else {
		touched = false;
		return false;
	}
}