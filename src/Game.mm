/*
 *  Game.cpp
 *  kunstBaueniPhone
 *
 *  Created by Rob Seward on 4/29/10.
 *  Copyright 2010 VHS DESIGN LLC. All rights reserved.
 *
 */

#include "Game.h"



//--------------------------------------------------------------
void Game::setup(){	
	int device = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? IPAD : IPHONE);
	
	if (device == IPAD) {
		squareSize = 150;
		speed = 10;
		destroyThreshold = 1000;
	} else if (device == IPHONE) {
		squareSize = 80;
		speed = 10;
		destroyThreshold = 400;
	}
		
	spline.setInterpolation(OFX_MSA_SPLINE_LINEAR);
	ignoreNextTouch = false;
}


//--------------------------------------------------------------
void Game::update() {
	ofBackground(255,0, 0);
	
	path.update(spline, 200);
	
	int pathPositionStart = 0;//pathPosition - 200;
	pathPositionStart = pathPositionStart < 0 ? 0 : pathPositionStart;
	
	squares.clear();
	pathPositionEnd = pathPositionEnd > path.segStrokeIndex - (speed) ? path.segStrokeIndex - speed : pathPositionEnd;
	
	for(pathPosition = pathPositionStart; pathPosition < pathPositionEnd; pathPosition += speed){
		//printf("pathPosition: %d, strokeIndex:%d\n", pathPosition,  path.segStrokeIndex);
		
		Square s;
		s.w = squareSize;
		s.h = squareSize;
		s.x = path.segmentedStroke[pathPosition].x;
		s.y = path.segmentedStroke[pathPosition].y;
		
		s.active = true;
		
		//printf("sX: %d, sY:%d size: %d\n", s.x,  s.y, squares.size());
		
		squares.push_front(s);
		
	}
	pathPositionEnd += speed * 3;
	
	/*	if (ofGetFrameNum() % 2 == 0 && frameCounter > kDestroyThreshold && squares.size() > 0) {
	 squares.pop_back();
	 }
	 */	
	Square::update();	
	frameCounter++;
	
	list<Square>::iterator iter;
	for(iter = squares.begin(); iter != squares.end(); iter++){
		iter->xRotate = ofGetFrameNum() % 360;
	}
}

//--------------------------------------------------------------
void Game::draw() {
	//mvButtons.draw();
	
	list<Square>::iterator iter;
	for(iter = squares.begin(); iter != squares.end(); iter++){
		iter->draw();		
	}
	//printf("%f\n", ofGetFrameRate());
	
	
	//////Draw lines and splines
	
	/*ofSetColor(150, 150, 150);
	 for (int i=0; i < kStrokeMax; i++) {
	 ofRect(path.stroke[i].x, path.stroke[i].y, 1, 1);
	 }
	 */
	//	ofSetColor(255, 255, 0);
	//	for (int i=0;  i < path.segStrokeIndex; i++) {
	//		ofRect(path.segmentedStroke[i].x, path.segmentedStroke[i].y, 1, 1);
	//	}
	//	
	//	ofSetColor(0, 200, 0);
	//	spline.drawSmooth(100, 3, 0);
	
}



//--------------------------------------------------------------
void Game::exit() {
	printf("exit()\n");
}

//--------------------------------------------------------------
void Game::touchDown(int x, int y, int id){
	//printf("touch %i down at (%i,%i)\n", id, x,y);
	if (id == 0) {
		if(!ignoreNextTouch){	//for double tap
			spline.push_back(ofxVec2f(x, y));
			path.touchDown(x, y, id);		
		}
		
		if(squares.size() < 5) frameCounter = 0;
		ignoreNextTouch = false;
	}
}

//--------------------------------------------------------------
void Game::touchMoved(int x, int y, int id){
	//dissallow multitouch
	if (id == 0) {
		spline.push_back(ofxVec2f(x, y));
		path.touchMoved(x, y, id);
	}
}

//--------------------------------------------------------------
void Game::touchUp(int x, int y, int id){
	//printf("touch %i up at (%i,%i)\n", id, x, y);
	touchesMoving = false;
}

//--------------------------------------------------------------
void Game::touchDoubleTap(int x, int y, int id){
	//printf("touch %i double tap at (%i,%i)\n", id, x, y);
	pathPosition =0;
	frameCounter = 0;
	squares.clear();
	spline.clear();
	ignoreNextTouch = true;
}

//--------------------------------------------------------------
void Game::lostFocus() {
}

//--------------------------------------------------------------
void Game::gotFocus() {
}

//--------------------------------------------------------------
void Game::gotMemoryWarning() {
}

//--------------------------------------------------------------
void Game::deviceOrientationChanged(int newOrientation){
}