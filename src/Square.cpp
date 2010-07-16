/*
 *  Square.cpp
 *  kunstBauen
 *
 *  Created by Rob Seward on 4/13/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Square.h"

bool Square::scaleUp = true;
float Square::scaling = 1;
float Square::scalingRate = kInitialScalingRate;

Square::Square(int w, int h){
	this->w = w;
	this->h = h;
}

void Square::update(){
	
	if(scaleUp && scaling < (float)kNumTiles){
		scaling += scalingRate;
		scalingRate += kScalingRateChange;
	}else {
		scaleUp = false;
	}
	
	if (!scaleUp && scaling > 1) {
		scaling -= scalingRate;
		scalingRate -= kScalingRateChange;
		
	}else {
		scaleUp = true;
	}	
	 
}


void Square::draw(){
	
	//ofTranslate(x, y, 0);
	//ofPushMatrix();
	//ofPopMatrix();
	
	ofPushMatrix();

	float xMove = sin((xRotate * (PI / 180)) / 2) * (w);
	ofTranslate(0, fabs(xMove), 0);
	
	ofTranslate(x - (w/2), y - (h/2), 0);
	ofRotateX(xRotate);
	
	ofSetColor(0, 255, 255);
	ofRect(0, 0, w, h);
	ofSetColor(0, 0, 0);
	
	int smallStartW = w / kNumTiles;
	int smallStartH = h / kNumTiles;
	
	int smallRectSpacing = (w / kNumTiles) / 6;
	int xPos, yPos;
	int rightMost=0;
	int bottomMost=0;
	int smallDrawW=0;
	int smallDrawH=0;
	
	float scaling = this->getScaling();

	
	for(int i=0; i < kNumTiles; i++){
		yPos = i * (smallStartH + smallRectSpacing) * scaling;
		smallDrawH = smallStartH * scaling;
		bottomMost = yPos + (smallStartH * scaling);

		if (bottomMost > h) {
			smallDrawH = smallDrawH - (bottomMost - h);
		}
		for(int j=0; j < kNumTiles; j++){
			xPos = j * (smallStartW + smallRectSpacing) * scaling;
			
			smallDrawW = smallStartW * scaling;
			rightMost = xPos + (smallStartW * scaling);
			
			if(rightMost > w){
				smallDrawW = smallDrawW - (rightMost - w);
			} 
			
			ofRect(xPos, yPos , smallDrawW, smallDrawH); //we're going to make the small rects square			
			if(rightMost + (smallRectSpacing * scaling) > w){
				break;
			}
		}
		if (bottomMost + (smallRectSpacing * scaling) > h) {
			break;
		}
	}
	
	//printf("scaling %f", scaling);
	
	ofPopMatrix();
 
}

