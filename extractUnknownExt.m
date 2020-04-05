function result = extractUnknownExt(filename, targetFolder)
%EXTRACTUNKNOWNEXT Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
if is_continuous_integration()
    scriptPath = fileparts(scriptPath);
end
script = fullfile(scriptPath, 'extract.sh');
[status, result] = system(['bash ' convertPcToUnixPath(script) ' ' convertPcToUnixPath(filename) ' '  convertPcToUnixPath(targetFolder)]);
if status
    ME = MException('ExtractUnknownExt:errorOnExtraction', ...
        result);
    throw(ME)
end

