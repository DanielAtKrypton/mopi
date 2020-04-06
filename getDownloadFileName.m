function result = getDownloadFileName(url)
%GETDOWNLOADFILENAME Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
if is_continuous_integration()
    scriptPath = fileparts(scriptPath);
end
script = fullfile(scriptPath, 'getDownloadFileName.sh');
[status, result] = system(['bash ' convertPcToUnixPath(script) ' ' url]);
if status
    ME = MException('ExtractUnknownExt:errorOnExtraction', ...
        result);
    throw(ME)
end
result = strtrim(result);