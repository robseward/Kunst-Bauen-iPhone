/*
 *  Button.h
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"

class Button {
private:
	ofImage upImage;
	ofImage downImage;
	
	float x;
	float y;
	float w;
	float h;
	
public:
	Button(float x, float y, string upFilename, string downFilename);
	
	bool isTouched(float xPos, float yPos);
	void draw();
	
	bool touched;
};