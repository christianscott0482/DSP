%  ECE 486 Lab #5 - Task #1
%
%  Authors:
%   Christian Auspland
%   Matthew Blanchard
%   Ben Grooms
%   Hunter Smith
% 
%  This script calls an initalization script that allows the user to input
%  paramiters into a GUI and select a filter design, windowing method.
clear;
clc;

assignin('base','WindowAmplitudeBartlett',1.0);
assignin('base','WindowLangthBartlett',64.0);
assignin('base','WindowAmplitudeBlackman',1.0);
assignin('base','WindowLangthBlackman',64.0);
assignin('base','WindowAmplitudeBoxcar',1.0);
assignin('base','WindowLangthBoxcar',64.0);
assignin('base','WindowSidelobeChebyshev',100);
assignin('base','WindowLangthChebyshev',64.0);
assignin('base','WindowAmplitudeHamming',1.0);
assignin('base','WindowLangthHamming',64.0);
assignin('base','WindowTypeHamming','symmetric');
assignin('base','WindowAmplitudeHann',1.0);
assignin('base','WindowLangthHann',64.0);
assignin('base','WindowTypeHann','symmetric');
assignin('base','WindowAmplitudeTaylor',1.0);
assignin('base','WindowLangthTaylor',64.0);
assignin('base','WindowBetaTaylor',5);
assignin('base','WindowSidelobeLevelTaylor',-30);
assignin('base','WindowLangthKaiser',64.0);
assignin('base','WindowBetaKaiser',5);
assignin('base','WindowAmplitudeKaiser',1);

new_gui

