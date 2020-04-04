function result = regex(inputString, pattern)
%REGEX Summary of this function goes here
%   Detailed explanation goes here
if strncmp(pattern,'^', 1)
    pattern = ['^' pattern];
end
result = perl('regexpScript.pl', inputString, pattern);

