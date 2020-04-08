function result = getDownloadFileName(url)
%GETDOWNLOADFILENAME Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
script = fullfile(scriptPath, 'getDownloadFileName.sh');
if ispc
    script = convertPcToUnixPath(script);
end
[status, result] = system(['bash "' script '" ' url]);
if status
    % ME = MException('ExtractUnknownExt:errorOnExtraction', ...
    %     result);
    % throw(ME)
  error(['ExtractUnknownExt:errorOnExtraction: ', result]);
end
result = strtrim(result);