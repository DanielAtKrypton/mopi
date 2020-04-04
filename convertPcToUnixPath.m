function unixPath = convertPcToUnixPath(pcPath)
%CONVERTPCTOUNIXPATH Summary of this function goes here
%   Detailed explanation goes here
    drive = regex(pcPath, '^[A-Z](?![A-Z]:\\)');
    pathA = strrep(pcPath, regex(pcPath, ['^' drive ':\\']), ['/mnt/' lower(drive), '/']);
    unixPath = strrep(pathA, '\', '/');
end

