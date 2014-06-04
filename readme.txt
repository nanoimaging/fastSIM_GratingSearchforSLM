Copyright 2014 Hui-Wen Lu-Walther


-----------------------------------------------------------
Use Matlab and Dipimage tool box. (http://www.diplib.org/)
-----------------------------------------------------------

1. Search for gratings

call "CalcGrat.m" function 

% Example: CalcGrat(2.800, 2.850, 3, 1, 3)
% Example: CalcGrat(2.700, 2.850, 9, 4, 6)

Note: boundaries of parameters in this function should be defined
para.axmax=28;  % large number is required for 6 Numdir, eg. 40
para.aymax=28;  % large number is required for 6 Numdir, eg. 40
para.bxmax=28;  % large number is required for 6 Numdir, eg. 40
para.bxmin=2;
para.bymax=28;  % large number is required for 6 Numdir, eg. 40
para.bymin=2;


2. After some grating parameters are found, generate binary grating images with those parameters and check the phase of each grating image.

call "FourDimGrating2png_HW.m" function 

Example: FourDimGrating2png_HW([5 17 25;-26 -19 -9;2 19 33;4 -17 -9],3,3,1,'o3p3_LSIM')




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
