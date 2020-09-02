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

function  [] = ProduceFigure(imagename)

figure()
imagesc(imagename)
axis equal
colormap pink
axis off
colorbar

end

