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

function [ uniquemzs ] = MZListSynapt(Path, Scansstart, Scansend)


filestoprocess=dir([Path '*.mzML']); %creates a list of the mzML files in folder 'Path'
totalmzs = [];

for i=1:size(filestoprocess,1)
    
    filename = filestoprocess(i).name; %reads the name of the working file from the list 'filestoprocess'
    
    filePath = [Path filesep filename]; %generates the individual file path by adding the working file name to the working directory path
    
    mzML = imzMLConverter.MzMLHandler.parsemzML(filePath);
    
    %Setting up the cells to contain the mzArrays and the counts
    mzArray = cell(Scansend(i)-Scansstart(i)+1,1); 
    
    counter = 1; % to deal with not all scans starting at 1
    
    
    for j = Scansstart(i)-1:Scansend(i)-1   %loop through the scans in a pixel

            spectrum = mzML.getRun().getSpectrumList().getSpectrum(j); %calling out the spectrum from the scan specified
            mzArray{counter} = spectrum.getmzArray(); %
            
            counter = counter+1; %moving the counter along one            
            
    end
    
    total = cat(1,mzArray{:}); % concatonating the mz arrays for each scan of the pixel
    totalmzs = cat(1,totalmzs,total); % concatonating the mz array with previous mz arrays

    
end


uniquemzs = unique(totalmzs); % FULL MZ LIST, gets rid of any dupicate mz values and sorts in ascending order

end

