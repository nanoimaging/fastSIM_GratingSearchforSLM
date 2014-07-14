Copyright 2014 Hui-Wen Lu-Walther


-----------------------------------------------------------
Use Matlab and Dipimage tool box. (http://www.diplib.org/)
-----------------------------------------------------------

1. Search for gratings

call "CalcGrat.m" function 

% CalcGrat(gratpermin,gratpermax, Hsteps, Vsteps, Numdir, filtersize, Iunwanted)
% for searching 3 or 6 orientations of gratings.
% This code only work with either 3 grating orientations or 6 grating
% orientations.
% gratpermin: minumum grating period (unit: in pixels)
% gratpermax: maximum grating period (unit: in pixels)
% Hsteps: # of equi-phase steps in x or y
% Vsteps: # of equi-phase steps in y or x
% Numdir: 3 or 6 orientations of gratings
% filtersize: the half size of the hole on the Fourier filter. eg. 10
% Iunwanted: maximum intensity (in percentage) of unwanted orders through Fourier filter. eg. 0.03
% Example: CalcGrat(2.800, 2.850, 3, 1, 3, 10, 0.03)
% Example: CalcGrat(2.700, 2.850, 9, 4, 6, 10, 0.03)

Note: boundaries of parameters in this function should be defined
para.axmax=28;  % large number is required for 6 Numdir, eg. 40
para.aymax=28;  % large number is required for 6 Numdir, eg. 40
para.bxmax=28;  % large number is required for 6 Numdir, eg. 40
para.bxmin=2;
para.bymax=28;  % large number is required for 6 Numdir, eg. 40
para.bymin=2;


2. After some grating parameters are found, generate binary grating images with those parameters and check the phase of each grating image.

call "FourDimGrating2png_HW.m" function 

% FourDimGrating2png_HW(gratingparameter, Numdir, Numphase, pngortif, foldername)
% produce pictures of the gratings including asigned phase steps
% produce 1-bit png images / tif images
% Also check equi-phase steps and generate a .txt file afterward
% Numdir: # of grating orientations
% Numphase: # of grating phase shifts
% pngortif: '1' .png, '0' .tif
% foldername: should be a string
% Example: FourDimGrating2png_HW([5 17 25;-26 -19 -9;2 19 33;4 -17 -9],3,3,1,'o3p3_LSIM')




    This file is part of GratingPatternGenerationAlgorithm.

    GratingPatternGenerationAlgorithm is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GratingPatternGenerationAlgorithm is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with fastSIM_GratingSearchforSLM.  If not, see <http://www.gnu.org/licenses/>.
