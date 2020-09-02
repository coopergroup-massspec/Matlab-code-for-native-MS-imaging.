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

function [ ctsmatrix ] = CountsMatrixSynapt( Path, Scansstart, Scansend, scans, uniquemzs)
%CountsMatrixSynapt - creates large matrix with all the counts of each scan
%in each pixel


filestoprocess=dir([Path '*.mzML']); %creates a list of the mzML files in folder 'Path'

ctsmatrix=zeros(size(uniquemzs,1),scans,size(filestoprocess,1));


for m=1:size(filestoprocess,1) %looping through pixels

    filename = filestoprocess(m).name; %reads the name of the working file from the list 'filestoprocess'
    
    filePath = [Path filesep filename]; %generates the individual file path by adding the working file name to the working directory path
    
    mzML = imzMLConverter.MzMLHandler.parsemzML(filePath);
    
    mzArray = cell(Scansend(m)-Scansstart(m)+1,1);
    countz = cell(size(mzArray,1),1);
    counter2 = 1;
    
    %if statement to deal with scans that are shorter than the size
    %specified in the scan info list
    
    if Scansstart(m)-1+scans-1 <= mzML.getRun().getSpectrumList.size()-1
        END = Scansstart(m)-1+scans-1;
        
    else
        END = mzML.getRun().getSpectrumList.size()-1;
        ActualLength = END+1;
        x = ['Scan ',num2str(m),' is shorter than ',num2str(scans),' scans. Actual lenghth is ',num2str(ActualLength),'.'];
        disp(x)
        
    end
    
    
    for k = Scansstart(m)-1:END %looping through scans in the pixel
        
        spectrum = mzML.getRun().getSpectrumList().getSpectrum(k); %reads in the spectrum of scan k
            mzArray{counter2} = spectrum.getmzArray(); %pulls out the mzarray
             countz{counter2} = spectrum.getIntensityArray(); %pulls out the intensity array
            
        s = 1; %counter
        mzindex = ismember(uniquemzs,mzArray{counter2}); %logic matrix - what mz values in this scan match the mz values in the uniquemzs vector
        countsvector = countz{counter2}; %brings the counts vector out of a cell format into a vector format
    
        for n=1:length(uniquemzs) %looping through the length of the unique mz list
        
            if mzindex(n) == 1 % if the nth element of the logic matrix=1  
               ctsmatrix(n,counter2,m) = countsvector(s); %put the associating count in the nth element of the counts matrix
            
               s = s+1;
            
            else %else do nothing, counter stays the same
            
            end %end of if statement
            
        end %end of loop through the mz list
        
    counter2 = counter2+1; %increasing counter2 to move along to the next column in the cts matrix
    
    end %end of loop through the scans

end %end of the loop through the pixels


end

