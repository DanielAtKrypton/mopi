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
resultingString = perl('regexpScript.pl', inputString, pattern, modifier);
if is_octave
    % composedStringArray = compose(["\r\n", "\n", "\r"]);
    % save('composedStringArray.mat', 'composedStringArray');
%     load('composedStringArray.mat', 'composedStringArray');
    result = strsplit(resultingString, {"??", "?", "?"});
else
    result = splitlines(resultingString);
end
matched = result{1};
before = result{2};
after = result{3};



