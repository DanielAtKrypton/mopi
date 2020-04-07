function [matched, before, after] = regex(inputString, pattern, varargin)
%REGEX Summary of this function goes here
%   Detailed explanation goes here
inputString = char(inputString);
pattern = char(pattern);
switch nargin
case 2
    modifier = 'g';
case 3
    modifier = varargin{1};
otherwise
    error('Wrong number of inputs!')
end
if is_octave
    regResult = regexp(inputString, pattern);
    if regResult
        substitutedString = regexprep (inputString, pattern, '');
        resultingString = substr (inputString, regResult, length(inputString)-length(substitutedString));
    else
        resultingString = '';
    end
    matched = resultingString;
else
    resultingString = perl('regexpScript.pl', inputString, pattern, modifier);
    result = splitlines(resultingString);
    matched = result{1};
    before = result{2};
    after = result{3};
end



