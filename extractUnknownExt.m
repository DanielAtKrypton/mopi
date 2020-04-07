function result = extractUnknownExt(filename, targetFolder)
%EXTRACTUNKNOWNEXT Summary of this function goes here
%   Detailed explanation goes here
scriptPath = fileparts(mfilename('fullpath'));
% ! TODO Check if the commented section below works.
% if is_continuous_integration()
%     scriptPath = fileparts(scriptPath);
% end
script = fullfile(scriptPath, 'extract.sh');
if ispc
    script = convertPcToUnixPath(script);
    filename = convertPcToUnixPath(filename);
    targetFolder = convertPcToUnixPath(targetFolder);
end
[status, result] = system(['bash "' script '" "' filename '" "'  targetFolder '"' ]);
if status
    ME = MException('ExtractUnknownExt:errorOnExtraction', ...
        result);
    throw(ME)
end

