function result = extractUnknownExt(filename, targetFolder)
%EXTRACTUNKNOWNEXT Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
script = fullfile(scriptPath, 'extract.sh');
if ispc
    script = convertPcToUnixPath(script);
    filename = convertPcToUnixPath(filename);
    targetFolder = convertPcToUnixPath(targetFolder);
end
[status, result] = system(['bash "' script '" "' filename '" "'  targetFolder '"' ]);
if status
    % ME = MException('ExtractUnknownExt:errorOnExtraction', ...
    %     result);
    % throw(ME)
    error(['ExtractUnknownExt:errorOnExtraction: ' result]);
end

