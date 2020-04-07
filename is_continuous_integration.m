% ---------------------------------------------------------------------
% Check whether we are inside a continuous integration testing environment
function r = is_continuous_integration()
persistent x;
if (isempty (x))
    cmdString = '$CI';
    [~, res] = system(['echo ' cmdString]);
    trimmedRes = strtrim(res);
    if isempty(trimmedRes) || strcmp(cmdString, trimmedRes)
        x = false;
    else
        x = true;
    end
end
r = x;