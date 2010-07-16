/*
 *  Game.h
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#pragma once


#define IPHONE 0
#define IPAD 1
#define IPHONE4 2


#include "ofMain.h"
#include "Square.h"
#include "Paths.h"
#include "ofxMSASpline.h"

class Game {
private:
	ofxMSASpline2D spline;
	Paths path;
	
	int squareSegIndex;
	
	int lineIndex;
	int prevLineIndex;
	bool touchesMoving;
	int frameCounter;
	int pathPosition;
	int pathPositionEnd;
	
	int squareSize;
	int speed;
	int destroyThreshold;
	
public:
	void setup();
	void update();
	void update(ofxMSASpline2D spline);
	void draw();
	void exit();
	
	void touchDown(int x, int y, int id);
	void touchMoved(int x, int y, int id);
	void touchUp(int x, int y, int id);
	void touchDoubleTap(int x, int y, int id);
	
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	
	list<Square> squares;
	
	int squareEndIndex;
	int squareBeginIndex;
	
	
	bool ignoreNextTouch;
};
