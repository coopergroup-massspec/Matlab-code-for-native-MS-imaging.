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

%% Baseline Correction

%NOTE: Will require the variables sumscans & uniquemzs in the workspace

correctedscans = zeros(size(sumscans));

for i=1:size(sumscans, 2)
    counts = sumscans(:,i);
    
    % Calc the max baseline
    maxbl = maxbaseline(counts,25);
    
    % Median filter the max baseline to remove the peaks
    % Use a wide filter for this
    medbl = medianbaseline(maxbl, 500);
    
    
    % Subtract the median filter maximum baseline
    counts = counts - medbl;
    counts(counts<0) = 0;
     
    correctedscans(:,i) = counts;
end

%% Normalisation

% Totoal ion current normalisation
TICfromcorrected = sum(correctedscans,1); % Calculating the total ion count 
NormalisationFactor = (reshape(TICfromcorrected,8,10))'; %reshaping into matrix same size as image

%% Create ion map figure
mzvalue = [1344.66, 1234.89, 1344.47, 1235.15]; % m/z values you want to create ion maps for 

for j = 1:size(mzvalue,2) %loops through your mzvalue vector

[f,index] = min(abs(uniquemzs-mzvalue(j))); % finds the mz (and the index) closest to the mzvalue you entered
 
sumpixel = correctedscans(index,:)+ correctedscans(index+1,:) + correctedscans(index-1,:);

Ionsum = (reshape(sumpixel,8,10))';

%Creating the normalised image
IonsumNorm = Ionsum./NormalisationFactor;

ProduceFigure(IonsumNorm)
title(strcat('TIC Normalised Baseline Subtract m/z- ', num2str(mzvalue(j))))

end

