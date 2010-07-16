/*
 *  paths.cpp
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/18/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Paths.h"



void Paths::update(){
	if (touchesMoving) {
		lineIndex = strokeIndex / kSegmentLength;
		
		ofPoint startPoint, endPoint;
		
		int startIndex;
		if (lineIndex != prevLineIndex && lineIndex > 0) {				//new line
			startIndex = (lineIndex - 1) * kSegmentLength - 1;
			startIndex = startIndex >= 0 ? startIndex : 0;
			startPoint = stroke[startIndex];
			endPoint = stroke[lineIndex * kSegmentLength - 1];
			addLine(startPoint, endPoint);
			//printf("lineIndex:%d  startX: %f startX: %f edn: %f end: %f\n", (lineIndex - 1) * kSegmentLength, startPoint.x, startPoint.y, endPoint.x, endPoint.y);
		}
		prevLineIndex = lineIndex;
	}
}


void Paths::update(ofxMSASpline2D spline, int resolution){
	segStrokeIndex = 0;
	
	if (spline.size() == 0) {
		return;
	}
	
	int numSteps = resolution;
	float spacing =  1.0/numSteps;
	ofPoint startPoint;
	ofxVec2f splineVec= spline.sampleAt(0);
	startPoint.set(splineVec.x, splineVec.y, 0); 
	ofPoint endPoint;
	
	for (float f=spacing; f < 1.0; f += spacing) {
		splineVec = spline.sampleAt(f);
		endPoint.set(splineVec.x, splineVec.y, 0); 

		addLine(startPoint, endPoint);
		//printf("F:%f  startX: %f starty: %f endX: %f endY: %f\n", f, startPoint.x, startPoint.y, endPoint.x, endPoint.y);
		startPoint = endPoint;
	}
	
}


/*
 *	 We nee to create our own lines because the graphic line functions don't give you
 *   the points in-between the end-points, and we need those to place the squares.
 */
void Paths::addLine(ofPoint startPoint, ofPoint endPoint){
	
	int rise = startPoint.y - endPoint.y;
	int run = startPoint.x - endPoint.x;
	
	bool runGreater = abs(run) > abs(rise) ? true : false;	
	int numPixels = runGreater ? abs(run) : abs(rise);
	float slope;
	
	if (run == 0) {	//don't wanna divide by 0
		slope = 10000;
	} else {
		slope = (float)rise / (float)run;

	}

	
	
	int yIntercept = + startPoint.y - (slope * startPoint.x) ;
	//printf("rise: %d | run: %d | b:%d \n", rise, run, yIntercept);
	
	bool leftToRight = startPoint.x < endPoint.x ? true : false;
	bool topToBottom = startPoint.y < endPoint.y ? true : false;
	
	int i;
	for (i = 0; i < numPixels && i < kSegmentPoints; i++) {
		if (runGreater) {
			currentSegment[i].x = leftToRight ? startPoint.x + i : startPoint.x - i;
			currentSegment[i].y = (slope * (float)currentSegment[i].x) + yIntercept + .5;
		} else {
			currentSegment[i].y = topToBottom ? startPoint.y + i : startPoint.y - i;
			currentSegment[i].x = (float)(currentSegment[i].y - yIntercept) / slope;
		}
	}
	
	int j;
	for (j = 0; j < i && j < kSegmentPoints; j++) {
		segmentedStroke[j + segStrokeIndex] = currentSegment[j];
	}
	 
	segStrokeIndex = segStrokeIndex + j;
}


void Paths::touchDown(int x, int y, int id){
	strokeIndex = 0;
	segStrokeIndex = 0;
	//printf("touch %i down at (%i,%i)\n", id, x,y);
	for (int i=0; i < kStrokeMax; i++) {
		stroke[i].x = -1;
		stroke[i].y = -1;
	}	
}

void Paths::touchMoved(int x, int y, int id){
	stroke[strokeIndex].x  = x;
	stroke[strokeIndex].y  = y;
	strokeIndex++;
	strokeIndex %= kStrokeMax;
	touchesMoving = true;
}

void Paths::touchUp(int x, int y, int id){
	touchesMoving = false;
}
