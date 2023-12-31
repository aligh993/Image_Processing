# -*- coding: utf-8 -*-
"""
Created on Sun May 20 18:20:33 2018

@author: ALI GHANBARI 
@email: alighanbari446@gmail.com
"""

import numpy as np
import cv2
import glob
import os
import sys
from matplotlib import pyplot as plt
from Tkinter import Tk
from tkFileDialog import askopenfilename
from tkMessageBox import askyesno


wdth = 9 ; hith = 6

#---- Camera Calibration Using Webcam Train_level ----
def CameraCalibrationWebcamTrain():
    criteria = (cv2.TERM_CRITERIA_EPS|cv2.TERM_CRITERIA_MAX_ITER,30,0.001)
    
    objp = np.zeros((wdth*hith,3),np.float32)
    objp[:,:2] = np.mgrid[0:wdth,0:hith].T.reshape(-1,2)
    
    objpoints = []
    imgpoints = []
    
    cam = cv2.VideoCapture(0)
    (w, h) = (int(cam.get(4)),int(cam.get(3)))
    
    print("Finding Chessboard automatically with pressing any key, press 'ESC' key to exit")
    
    while(True):
        _, frame = cam.read()
        frame = cv2.flip(frame,1)
        gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
        ret, corners = cv2.findChessboardCorners(gray,(wdth,hith),None)
        
        if ret == True:
            objpoints.append(objp)
            corners = cv2.cornerSubPix(gray,corners,(11,11),(-1,-1),criteria)
            imgpoints.append(corners)
            
            cv2.drawChessboardCorners(frame,(wdth,hith),corners,ret)
            cv2.imshow('Finding Chessboard - Training level',frame)
            cv2.waitKey(0)
            
        cv2.imshow('Finding Chessboard - Training level',frame)
        print "Number of Chessboards find:",len(imgpoints)
        
        k = cv2.waitKey(1)
        if k == 27:      # ESC pressed
            print("ESC pressed, Closing Train level...")
            break
            
    cam.release()
    cv2.destroyAllWindows()
            
    ret,oldMtx,coef,rvecs,tvecs = cv2.calibrateCamera(objpoints,imgpoints,gray.shape[::-1],None,None)
    newMtx,roi = cv2.getOptimalNewCameraMatrix(oldMtx,coef,(w,h),1,(w,h))
    
    print "Original Camera Matrix:\n", oldMtx
    print "Optimal Camera Matrix:\n", newMtx

    np.save("Original camera matrix", oldMtx)
    np.save("Distortion coefficients", coef)
    np.save("Optimal camera matrix", newMtx)
#---- Camera Calibration Using Webcam Train_level ----
    
    
#---- Camera Calibration Using Webcam Test_level ----   
def CameraCalibrationWebcamTest():
    oldMtx = np.load("Original camera matrix.npy")
    coef = np.load("Distortion coefficients.npy")
    newMtx = np.load("Optimal camera matrix.npy")

    cam = cv2.VideoCapture(0)
    
    while(True):
        _,frame = cam.read()
        undis = cv2.undistort(frame,oldMtx,coef,newMtx)
        
        cv2.imshow("Original vs Undistortion - Test level",np.hstack([frame,undis]))
        k = cv2.waitKey(1)
        if k == 27:      # ESC pressed
            print("ESC pressed, Closing Test level ...")
            break
        
    cam.release()
    cv2.destroyAllWindows()
#---- Camera Calibration Using Webcam Test_level ----


#---- Camera Calibration Using Images ----
def CameraCalibrationImage():
    Tk().withdraw()
    selPic = askopenfilename(title = "Select Image, to Calibrate",filetypes = (("jpeg files","*.jpg"),("png files","*.png"),("all files","*.*")))
    print("Selected Image is: "+os.path.basename(selPic))
    
    ce2 = wdth-1 ; ce3 = wdth*hith-1 ; ce4 = wdth*(hith-1)
    
    img = cv2.imread(selPic)
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    ret, corners = cv2.findChessboardCorners(gray,(wdth,hith),None)
    
    xf_1 = corners[0][0][0] ; yf_1 = corners[0][0][1]
    xf_2 = corners[ce2][0][0] ; yf_2 = corners[ce2][0][1]
    xf_3 = corners[ce3][0][0] ; yf_3 = corners[ce3][0][1]
    xf_4 = corners[ce4][0][0] ; yf_4 = corners[ce4][0][1]
    
    img = cv2.line(img,(xf_1,yf_1),(xf_2,yf_2),(0,0,255),2)
    img = cv2.line(img,(xf_2,yf_2),(xf_3,yf_3),(0,0,255),2)
    img = cv2.line(img,(xf_3,yf_3),(xf_4,yf_4),(0,0,255),2)
    img = cv2.line(img,(xf_4,yf_4),(xf_1,yf_1),(0,0,255),2)
    
    cv2.imshow('Check Distortion Image',img)
    print("Press 'c' key to save image and continue, or press 'ESC' key to exit")
    k = cv2.waitKey(0)
    if k == ord('c'):   # wait for 'c' key to save and continue
        cv2.imwrite('Output/chkDisImage.png',img)
        print("Check Distortion Image Saved!")
        cv2.destroyAllWindows()
    elif k == 27:       # wait for ESC key to exit
        print("ESC pressed, Closing...")
        cv2.destroyAllWindows()
        sys.exit()
        
    criteria = (cv2.TERM_CRITERIA_EPS+cv2.TERM_CRITERIA_MAX_ITER,30,0.001)
    
    objp = np.zeros((wdth*hith,3),np.float32)
    objp[:,:2] = np.mgrid[0:wdth,0:hith].T.reshape(-1,2)
    
    objpoints = []
    imgpoints = []
    
    images = glob.glob(os.path.dirname(selPic)+"/*.jpg")
    
    for fname in images:
        img = cv2.imread(fname)
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        ret, corners = cv2.findChessboardCorners(gray,(wdth,hith),None)
    
        if ret == True:
            objpoints.append(objp)
            corners = cv2.cornerSubPix(gray,corners,(11,11),(-1,-1),criteria)
            imgpoints.append(corners)
    
            img = cv2.drawChessboardCorners(img,(wdth,hith),corners,ret)
            winname = os.path.basename(fname)
            cv2.imshow(winname,img)
            cv2.waitKey(1000)
            cv2.destroyWindow(winname)
    
    cv2.destroyAllWindows()
    
    ret,mtx,dist,rvecs,tvecs = cv2.calibrateCamera(objpoints,imgpoints,gray.shape[::-1],None,None)
    
    img = cv2.imread(selPic)
    h,  w = img.shape[:2]
    newcameramtx, roi=cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h),1,(w,h))
    
    dst = cv2.undistort(img, mtx, dist, None, newcameramtx)
    
    x,y,w,h = roi ; dst = dst[y:y+h, x:x+w]
    
    plt.subplot(121),plt.imshow(img),plt.title('Input Image'),plt.xticks([]),plt.yticks([])
    plt.subplot(122),plt.imshow(dst),plt.title('Output Image'),plt.xticks([]),plt.yticks([])
    
    cv2.imshow('Output Image',dst)
    print("Press 's' key to save image and exit, or press 'ESC' key to exit")
    k = cv2.waitKey(0)
    if k == ord('s'):   # wait for 's' key to save and exit
        cv2.imwrite('Output/calibratedImage.png',dst)
        print("Output Image Saved!")
        cv2.destroyAllWindows()
    elif k == 27:       # wait for ESC key to exit
        print("ESC pressed, Closing...")
        cv2.destroyAllWindows()
    
    tot_error = 0
    for i in xrange(len(objpoints)):
        imgpoints2, _ = cv2.projectPoints(objpoints[i], rvecs[i], tvecs[i], mtx,dist)
        error = cv2.norm(imgpoints[i],imgpoints2, cv2.NORM_L2)/len(imgpoints2)
        tot_error += error
    
    print "total error: ", tot_error
#---- Camera Calibration Using Images ----   
    

result = askyesno("Webcam?","Do you want to finding chessboard automatically with webcam?")

if result == True:
    result2 = askyesno("Training Webcam?","Do you want to Training webcam?")
    
    if result2 == True:
        CameraCalibrationWebcamTrain()
        CameraCalibrationWebcamTest()
        
    else:
        CameraCalibrationWebcamTest()
        
else:
    CameraCalibrationImage()