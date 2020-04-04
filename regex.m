function result = regex(inputString, pattern)
%REGEX Summary of this function goes here
%   Detailed explanation goes here
if startsWith(pattern,'^')
    pattern = ['^' pattern];
end
result = perl('regexpScript.pl', inputString, pattern);

