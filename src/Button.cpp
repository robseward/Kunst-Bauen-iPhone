/*
 *  Button.cpp
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Button.h"

Button::Button(float x, float y, string upFilename, string downFilename){
	this->x = x;
	this->y = y;
	
	
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
	if(xPos > x && yPos > y && xPos < x + w && yPos < y + h){
		touched = true;
		return true;
	}
	else {
		touched = false;
		return false;
	}
}