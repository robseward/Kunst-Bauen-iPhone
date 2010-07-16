/*
 *  Square.h
 *  kunstBauen
 *
 *  Created by Rob Seward on 4/13/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#pragma once

#include "ofMain.h"
#define kNumTiles 4
#define kInitialScalingRate .02
#define kScalingRateChange .0005

class Square {

public:
	int x;
	int y;
	int w;
	int h;
	
	float xRotate;
	bool active;
	
	void draw();
	Square(int w=0, int h=0);
	
	static void update();
	static float getScaling(){ return scaling;};

private:
	static bool scaleUp;
	static float scaling;
	static float scalingRate;

};