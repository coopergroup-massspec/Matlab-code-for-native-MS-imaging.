% Copyright 2017 University of Birmingham
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
% 
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

% This file is released as part of the supplementary information for
% R.L. Griffiths, et al., Native mass spectrometry imaging of intact proteins and protein
% complexes in thin tissue sections, Int. J. Mass Spectrom. (2017),
% https://doi.org/10.1016/j.ijms.2017.10.009
% If you use this software, please acknowledge this work by citing this paper.

% Parts of this code were adapted from SpectralAnalysis, downloaded from 
% https://github.com/AlanRace/SpectralAnalysis on 21/03/2017 and used in this work
% under the conditions of the Apache License, version 2.0.

%% Inputs 

Path='C:\Users\axs1299\Documents\MATLAB\170420_Rian_musbrainmzML\'; %folder containing the mzML files

imzMLConverterLocation='C:\Users\axs1299\Documents\MATLAB\imzMLConverter_1.3\imzMLConverter.jar\'; %Converter location

javaclasspath(imzMLConverterLocation);
javaaddpath(imzMLConverterLocation);

Scansstart=xlsread('C:\Users\axs1299\Documents\MATLAB\SynaptImage\scan_info.xlsx','B4:B83'); %xls file containing scan start numbers
Scansend=xlsread('C:\Users\axs1299\Documents\MATLAB\SynaptImage\scan_info.xlsx','C4:C83'); %xls file containing the scan end numbers
filestoprocess=dir([Path '*.mzML']); %creates a list of the mzML files in folder 'Path'

scans = 60; % number of scans to sum over

%% Finding a List of the unique mz values from all the the pixels

uniquemzs = MZListSynapt(Path, Scansstart, Scansend);

%% Creating a counts matrix, contains all the counts for each pixel 

ctsmatrix = CountsMatrixSynapt(Path, Scansstart, Scansend, scans, uniquemzs); %mz x no of scans x no of pixels

%sum over the scans - gives total countsfor each mz value in each pixel
sumscans = squeeze(sum(ctsmatrix,2)); %  mz  x no of pixels

