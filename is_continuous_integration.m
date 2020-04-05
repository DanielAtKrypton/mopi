% ---------------------------------------------------------------------
% Check whether we are inside a continuous integration testing environment
function tf = is_continuous_integration()
    cmdString = '$CI';
    [~, res] = system(['echo ' cmdString]);
    trimmedRes = strtrim(res);
    if isempty(trimmedRes) || strcmp(cmdString, trimmedRes)
        tf = false;
    else
        tf = true;
    end
end