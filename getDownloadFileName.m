function result = getDownloadFileName(url)
%GETDOWNLOADFILENAME Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
% ! TODO Check if the commented section below works.
% if is_continuous_integration()
%     scriptPath = fileparts(scriptPath);
% end
script = fullfile(scriptPath, 'getDownloadFileName.sh');
if ispc
    script = convertPcToUnixPath(script);
end
[status, result] = system(['bash "' script '" ' url]);
if status
    ME = MException('ExtractUnknownExt:errorOnExtraction', ...
        result);
    throw(ME)
end
result = strtrim(result);