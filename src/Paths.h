/*
 *  paths.h
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/18/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */
#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include <queue>
#include "ofxMSASpline.h"

#define kStrokeMax 500
#define kSegmentPoints 10000
#define kSegmentLength 10
#define kNumLines 50

class Paths {

	typedef struct Line{
		ofPoint startPoint;
		ofPoint endPoint;
	} Line;

public:
	ofPoint stroke[kStrokeMax];
	int strokeIndex;
	
	ofPoint segmentedStroke[kSegmentPoints];
	int segStrokeIndex;
	ofPoint currentSegment[kSegmentPoints];
	
	int lineIndex;
	int prevLineIndex;
	bool touchesMoving;
	
	ofPoint currentPosition;
	ofPoint prevPosition;
	Line lines[kNumLines];


	void update();
	void update(ofxMSASpline2D spline, int resolution);
	void addLine(ofPoint startPoint, ofPoint endPoint);
	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);

};